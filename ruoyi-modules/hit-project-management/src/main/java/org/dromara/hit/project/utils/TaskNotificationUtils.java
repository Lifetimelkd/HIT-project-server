package org.dromara.hit.project.utils;

import lombok.RequiredArgsConstructor;
import org.dromara.hit.notification.service.IHitNotificationService;
import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.domain.vo.HitTaskCommentVo;
import org.dromara.hit.project.mapper.HitProjectTaskMapper;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.dromara.common.core.utils.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 任务通知工具类
 * 
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Component
@RequiredArgsConstructor
public class TaskNotificationUtils {

    private final IHitNotificationService notificationService;
    private final HitProjectTaskMapper taskMapper;
    private final ObjectMapper objectMapper;

    /**
     * 发送任务创建通知
     *
     * @param taskId 任务ID
     */
    public void sendTaskCreatedNotification(Long taskId) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            String title = "新任务创建通知";
            String content = String.format("项目 [%s] 中创建了新任务: %s", 
                task.getProjectName(), task.getTaskName());

            // 通知任务负责人
            if (task.getAssigneeId() != null) {
                notificationService.sendProjectNotification(
                    task.getAssigneeId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_created"
                );
            }

            // 通知项目相关成员（可以根据需要扩展）
            // notifyProjectMembers(task.getProjectId(), title, content, "task_created");

        } catch (Exception e) {
            System.err.println("发送任务创建通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务分配通知
     *
     * @param taskId 任务ID
     * @param assigneeId 新负责人ID
     * @param oldAssigneeId 原负责人ID
     */
    public void sendTaskAssignedNotification(Long taskId, Long assigneeId, Long oldAssigneeId) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            // 通知新负责人
            if (assigneeId != null) {
                String title = "任务分配通知";
                String content = String.format("您被分配了新任务: %s", task.getTaskName());
                
                notificationService.sendProjectNotification(
                    assigneeId,
                    title,
                    content,
                    task.getProjectId(),
                    "task_assigned"
                );
            }

            // 通知原负责人（如果有）
            if (oldAssigneeId != null && !oldAssigneeId.equals(assigneeId)) {
                String title = "任务重新分配通知";
                String content = String.format("任务 [%s] 已被重新分配", task.getTaskName());
                
                notificationService.sendProjectNotification(
                    oldAssigneeId,
                    title,
                    content,
                    task.getProjectId(),
                    "task_reassigned"
                );
            }

        } catch (Exception e) {
            System.err.println("发送任务分配通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务状态变更通知
     *
     * @param taskId 任务ID
     * @param newStatus 新状态
     * @param oldStatus 原状态
     */
    public void sendTaskStatusChangedNotification(Long taskId, String newStatus, String oldStatus) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            String title = "任务状态变更通知";
            String content = String.format("任务 [%s] 状态从 [%s] 变更为 [%s]", 
                task.getTaskName(), 
                getStatusLabel(oldStatus), 
                getStatusLabel(newStatus));

            // 通知任务负责人
            if (task.getAssigneeId() != null) {
                notificationService.sendProjectNotification(
                    task.getAssigneeId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_status_changed"
                );
            }

            // 通知任务创建人（如果不是同一人）
            if (task.getCreatorId() != null && !task.getCreatorId().equals(task.getAssigneeId())) {
                notificationService.sendProjectNotification(
                    task.getCreatorId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_status_changed"
                );
            }

            // 如果任务完成，发送特殊通知
            if ("done".equals(newStatus)) {
                sendTaskCompletedNotification(taskId);
            }

        } catch (Exception e) {
            System.err.println("发送任务状态变更通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务完成通知
     *
     * @param taskId 任务ID
     */
    public void sendTaskCompletedNotification(Long taskId) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            String title = "任务完成通知";
            String content = String.format("恭喜！任务 [%s] 已完成", task.getTaskName());

            // 通知任务创建人
            if (task.getCreatorId() != null) {
                notificationService.sendProjectNotification(
                    task.getCreatorId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_completed"
                );
            }

        } catch (Exception e) {
            System.err.println("发送任务完成通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务进度更新通知
     *
     * @param taskId 任务ID
     * @param newProgress 新进度
     * @param oldProgress 原进度
     */
    public void sendTaskProgressUpdatedNotification(Long taskId, Integer newProgress, Integer oldProgress) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            // 只在进度有显著变化时发送通知（比如每增加25%）
            if (shouldNotifyProgressChange(oldProgress, newProgress)) {
                String title = "任务进度更新通知";
                String content = String.format("任务 [%s] 进度已更新为 %d%%", 
                    task.getTaskName(), newProgress);

                // 通知任务创建人
                if (task.getCreatorId() != null && !task.getCreatorId().equals(task.getAssigneeId())) {
                    notificationService.sendProjectNotification(
                        task.getCreatorId(),
                        title,
                        content,
                        task.getProjectId(),
                        "task_progress_updated"
                    );
                }
            }

        } catch (Exception e) {
            System.err.println("发送任务进度更新通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送评论@提醒通知
     *
     * @param comment 评论信息
     */
    public void sendCommentMentionNotification(HitTaskCommentVo comment) {
        try {
            List<Long> mentionedUsers = parseMentionedUsers(comment.getMentionedUsers());
            if (mentionedUsers.isEmpty()) return;

            HitProjectTaskVo task = taskMapper.selectVoById(comment.getTaskId());
            if (task == null) return;

            String title = "任务评论@提醒";
            String content = String.format("您在任务 [%s] 的评论中被提及: %s", 
                task.getTaskName(), 
                truncateContent(comment.getCommentContent(), 50));

            // 发送@提醒通知
            for (Long userId : mentionedUsers) {
                if (!userId.equals(comment.getUserId())) { // 不给自己发通知
                    notificationService.sendProjectNotification(
                        userId,
                        title,
                        content,
                        task.getProjectId(),
                        "comment_mention"
                    );
                }
            }

        } catch (Exception e) {
            System.err.println("发送评论@提醒通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送评论回复通知
     *
     * @param comment 回复评论
     * @param parentComment 被回复的评论
     */
    public void sendCommentReplyNotification(HitTaskCommentVo comment, HitTaskCommentVo parentComment) {
        try {
            if (parentComment == null || comment.getUserId().equals(parentComment.getUserId())) {
                return; // 不给自己发通知
            }

            HitProjectTaskVo task = taskMapper.selectVoById(comment.getTaskId());
            if (task == null) return;

            String title = "评论回复通知";
            String content = String.format("您在任务 [%s] 的评论收到了新回复: %s", 
                task.getTaskName(), 
                truncateContent(comment.getCommentContent(), 50));

            notificationService.sendProjectNotification(
                parentComment.getUserId(),
                title,
                content,
                task.getProjectId(),
                "comment_reply"
            );

        } catch (Exception e) {
            System.err.println("发送评论回复通知失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务即将到期提醒
     *
     * @param taskId 任务ID
     * @param daysLeft 剩余天数
     */
    public void sendTaskDueSoonNotification(Long taskId, Integer daysLeft) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            String title = "任务即将到期提醒";
            String content = String.format("任务 [%s] 将在 %d 天后到期，请及时处理", 
                task.getTaskName(), daysLeft);

            // 通知任务负责人
            if (task.getAssigneeId() != null) {
                notificationService.sendProjectNotification(
                    task.getAssigneeId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_due_soon"
                );
            }

        } catch (Exception e) {
            System.err.println("发送任务即将到期提醒失败: " + e.getMessage());
        }
    }

    /**
     * 发送任务逾期通知
     *
     * @param taskId 任务ID
     * @param overdueDays 逾期天数
     */
    public void sendTaskOverdueNotification(Long taskId, Integer overdueDays) {
        try {
            HitProjectTaskVo task = taskMapper.selectVoById(taskId);
            if (task == null) return;

            String title = "任务逾期通知";
            String content = String.format("任务 [%s] 已逾期 %d 天，请尽快处理", 
                task.getTaskName(), overdueDays);

            // 通知任务负责人
            if (task.getAssigneeId() != null) {
                notificationService.sendProjectNotification(
                    task.getAssigneeId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_overdue"
                );
            }

            // 通知任务创建人
            if (task.getCreatorId() != null && !task.getCreatorId().equals(task.getAssigneeId())) {
                notificationService.sendProjectNotification(
                    task.getCreatorId(),
                    title,
                    content,
                    task.getProjectId(),
                    "task_overdue"
                );
            }

        } catch (Exception e) {
            System.err.println("发送任务逾期通知失败: " + e.getMessage());
        }
    }

    // ==================== 私有辅助方法 ====================

    /**
     * 获取状态标签
     */
    private String getStatusLabel(String status) {
        if (StringUtils.isBlank(status)) return "";
        
        switch (status) {
            case "todo": return "待开始";
            case "doing": return "进行中";
            case "testing": return "测试中";
            case "done": return "已完成";
            case "cancelled": return "已取消";
            default: return status;
        }
    }

    /**
     * 判断是否应该发送进度变更通知
     */
    private boolean shouldNotifyProgressChange(Integer oldProgress, Integer newProgress) {
        if (oldProgress == null) oldProgress = 0;
        if (newProgress == null) newProgress = 0;
        
        // 每增加25%发送一次通知
        int oldMilestone = oldProgress / 25;
        int newMilestone = newProgress / 25;
        
        return newMilestone > oldMilestone;
    }

    /**
     * 解析提及的用户ID列表
     */
    private List<Long> parseMentionedUsers(String mentionedUsers) {
        if (StringUtils.isBlank(mentionedUsers)) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(mentionedUsers, new TypeReference<List<Long>>() {});
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    /**
     * 截断内容
     */
    private String truncateContent(String content, int maxLength) {
        if (StringUtils.isBlank(content)) return "";
        if (content.length() <= maxLength) return content;
        return content.substring(0, maxLength) + "...";
    }
}
