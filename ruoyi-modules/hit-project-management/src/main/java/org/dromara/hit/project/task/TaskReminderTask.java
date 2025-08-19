package org.dromara.hit.project.task;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.service.IHitProjectTaskService;
import org.dromara.hit.project.utils.TaskNotificationUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * 任务提醒定时任务
 * 
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class TaskReminderTask {

    private final IHitProjectTaskService taskService;
    private final TaskNotificationUtils taskNotificationUtils;

    /**
     * 每天上午9点检查即将到期的任务
     */
    @Scheduled(cron = "0 0 9 * * ?")
    public void checkTasksDueSoon() {
        log.info("开始检查即将到期的任务...");
        
        try {
            // 检查3天内到期的任务
            List<HitProjectTaskVo> tasksDueSoon = taskService.queryTasksDueSoon(3);
            
            for (HitProjectTaskVo task : tasksDueSoon) {
                if (task.getDueDate() != null) {
                    long daysLeft = ChronoUnit.DAYS.between(LocalDate.now(), task.getDueDate());
                    if (daysLeft >= 0 && daysLeft <= 3) {
                        taskNotificationUtils.sendTaskDueSoonNotification(task.getTaskId(), (int) daysLeft);
                        log.info("发送即将到期提醒: 任务ID={}, 剩余天数={}", task.getTaskId(), daysLeft);
                    }
                }
            }
            
            log.info("即将到期任务检查完成，共处理 {} 个任务", tasksDueSoon.size());
            
        } catch (Exception e) {
            log.error("检查即将到期任务失败", e);
        }
    }

    /**
     * 每天上午10点检查逾期的任务
     */
    @Scheduled(cron = "0 0 10 * * ?")
    public void checkOverdueTasks() {
        log.info("开始检查逾期的任务...");
        
        try {
            List<HitProjectTaskVo> overdueTasks = taskService.queryOverdueTasks();
            
            for (HitProjectTaskVo task : overdueTasks) {
                if (task.getDueDate() != null) {
                    long overdueDays = ChronoUnit.DAYS.between(task.getDueDate(), LocalDate.now());
                    if (overdueDays > 0) {
                        taskNotificationUtils.sendTaskOverdueNotification(task.getTaskId(), (int) overdueDays);
                        log.info("发送逾期提醒: 任务ID={}, 逾期天数={}", task.getTaskId(), overdueDays);
                    }
                }
            }
            
            log.info("逾期任务检查完成，共处理 {} 个任务", overdueTasks.size());
            
        } catch (Exception e) {
            log.error("检查逾期任务失败", e);
        }
    }

    /**
     * 每周一上午8点发送任务统计报告
     */
    @Scheduled(cron = "0 0 8 * * MON")
    public void sendWeeklyTaskReport() {
        log.info("开始生成周任务统计报告...");
        
        try {
            // 这里可以实现周报功能
            // 比如统计本周完成的任务数量、逾期任务数量等
            // 发送给项目管理员或相关人员
            
            log.info("周任务统计报告生成完成");
            
        } catch (Exception e) {
            log.error("生成周任务统计报告失败", e);
        }
    }

    /**
     * 每小时检查一次高优先级逾期任务（紧急提醒）
     */
    @Scheduled(cron = "0 0 * * * ?")
    public void checkUrgentOverdueTasks() {
        log.debug("开始检查高优先级逾期任务...");
        
        try {
            List<HitProjectTaskVo> overdueTasks = taskService.queryOverdueTasks();
            
            for (HitProjectTaskVo task : overdueTasks) {
                // 只处理高优先级和紧急优先级的任务
                if ("high".equals(task.getPriority()) || "urgent".equals(task.getPriority())) {
                    if (task.getDueDate() != null) {
                        long overdueDays = ChronoUnit.DAYS.between(task.getDueDate(), LocalDate.now());
                        if (overdueDays > 0) {
                            // 对于高优先级逾期任务，每天都发送提醒
                            taskNotificationUtils.sendTaskOverdueNotification(task.getTaskId(), (int) overdueDays);
                            log.warn("发送高优先级逾期提醒: 任务ID={}, 优先级={}, 逾期天数={}", 
                                task.getTaskId(), task.getPriority(), overdueDays);
                        }
                    }
                }
            }
            
        } catch (Exception e) {
            log.error("检查高优先级逾期任务失败", e);
        }
    }

}
