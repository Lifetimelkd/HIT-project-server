package org.dromara.hit.project.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.hit.project.domain.bo.HitTaskCommentBo;
import org.dromara.hit.project.domain.vo.HitTaskCommentVo;
import org.dromara.hit.project.domain.HitTaskComment;
import org.dromara.hit.project.mapper.HitTaskCommentMapper;
import org.dromara.hit.project.service.IHitTaskCommentService;
import org.dromara.hit.notification.service.IHitNotificationService;
import org.dromara.hit.project.utils.TaskNotificationUtils;
import org.dromara.common.satoken.utils.LoginHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 任务评论Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@RequiredArgsConstructor
@Service
public class HitTaskCommentServiceImpl implements IHitTaskCommentService {

    private final HitTaskCommentMapper baseMapper;
    private final IHitNotificationService notificationService;
    private final TaskNotificationUtils taskNotificationUtils;
    private final ObjectMapper objectMapper;

    /**
     * 查询任务评论
     */
    @Override
    public HitTaskCommentVo queryById(Long commentId) {
        return baseMapper.selectCommentWithDetails(commentId);
    }

    /**
     * 查询任务评论列表
     */
    @Override
    public TableDataInfo<HitTaskCommentVo> queryPageList(HitTaskCommentBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitTaskComment> lqw = buildQueryWrapper(bo);
        Page<HitTaskCommentVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询任务评论列表
     */
    @Override
    public List<HitTaskCommentVo> queryList(HitTaskCommentBo bo) {
        LambdaQueryWrapper<HitTaskComment> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitTaskComment> buildQueryWrapper(HitTaskCommentBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitTaskComment> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getTaskId() != null, HitTaskComment::getTaskId, bo.getTaskId());
        lqw.eq(bo.getUserId() != null, HitTaskComment::getUserId, bo.getUserId());
        lqw.eq(bo.getParentCommentId() != null, HitTaskComment::getParentCommentId, bo.getParentCommentId());
        lqw.like(StringUtils.isNotBlank(bo.getCommentContent()), HitTaskComment::getCommentContent, bo.getCommentContent());
        lqw.eq(StringUtils.isNotBlank(bo.getCommentType()), HitTaskComment::getCommentType, bo.getCommentType());
        lqw.eq(StringUtils.isNotBlank(bo.getIsPinned()), HitTaskComment::getIsPinned, bo.getIsPinned());
        lqw.between(params.get("beginCreateTime") != null && params.get("endCreateTime") != null,
            HitTaskComment::getCreateTime, params.get("beginCreateTime"), params.get("endCreateTime"));
        lqw.orderByDesc(HitTaskComment::getIsPinned).orderByAsc(HitTaskComment::getCreateTime);
        return lqw;
    }

    /**
     * 新增任务评论
     */
    @Override
    public Boolean insertByBo(HitTaskCommentBo bo) {
        HitTaskComment add = MapstructUtils.convert(bo, HitTaskComment.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setCommentId(add.getCommentId());
            // 发送评论通知
            HitTaskCommentVo commentVo = queryById(add.getCommentId());
            if (commentVo != null) {
                // 发送@提醒通知
                taskNotificationUtils.sendCommentMentionNotification(commentVo);

                // 如果是回复评论，发送回复通知
                if (add.getParentCommentId() != null && add.getParentCommentId() > 0) {
                    HitTaskCommentVo parentComment = queryById(add.getParentCommentId());
                    taskNotificationUtils.sendCommentReplyNotification(commentVo, parentComment);
                }
            }
        }
        return flag;
    }

    /**
     * 修改任务评论
     */
    @Override
    public Boolean updateByBo(HitTaskCommentBo bo) {
        HitTaskComment update = MapstructUtils.convert(bo, HitTaskComment.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitTaskComment entity) {
        // 设置默认值
        if (StringUtils.isBlank(entity.getCommentType())) {
            entity.setCommentType("normal");
        }
        if (entity.getLikeCount() == null) {
            entity.setLikeCount(0);
        }
        if (StringUtils.isBlank(entity.getIsPinned())) {
            entity.setIsPinned("0");
        }
        if (entity.getUserId() == null) {
            entity.setUserId(LoginHelper.getUserId());
        }
        if (entity.getParentCommentId() == null) {
            entity.setParentCommentId(0L);
        }
    }

    /**
     * 批量删除任务评论
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 可以添加删除前的业务校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    // ==================== 业务接口实现 ====================

    @Override
    public List<HitTaskCommentVo> queryCommentsByTaskId(Long taskId) {
        return baseMapper.selectCommentsByTaskId(taskId);
    }

    @Override
    public List<HitTaskCommentVo> queryTopLevelComments(Long taskId) {
        return baseMapper.selectTopLevelComments(taskId);
    }

    @Override
    public List<HitTaskCommentVo> queryRepliesByParentId(Long parentCommentId) {
        return baseMapper.selectRepliesByParentId(parentCommentId);
    }

    @Override
    public List<HitTaskCommentVo> queryCommentsByUserId(Long userId) {
        return baseMapper.selectCommentsByUserId(userId);
    }

    @Override
    public List<HitTaskCommentVo> queryPinnedComments(Long taskId) {
        return baseMapper.selectPinnedComments(taskId);
    }

    @Override
    public List<HitTaskCommentVo> queryCommentsByMentionedUser(Long userId) {
        return baseMapper.selectCommentsByMentionedUser(userId);
    }

    @Override
    public Integer countCommentsByTaskId(Long taskId) {
        return baseMapper.countCommentsByTaskId(taskId);
    }

    @Override
    public Integer countCommentsByUserId(Long userId) {
        return baseMapper.countCommentsByUserId(userId);
    }

    @Override
    public Boolean likeComment(Long commentId) {
        return baseMapper.updateLikeCount(commentId, 1) > 0;
    }

    @Override
    public Boolean unlikeComment(Long commentId) {
        return baseMapper.updateLikeCount(commentId, -1) > 0;
    }

    @Override
    public Boolean setPinnedStatus(Long commentId, Boolean isPinned) {
        Long userId = LoginHelper.getUserId();
        String pinnedStatus = isPinned ? "1" : "0";
        return baseMapper.updatePinnedStatus(commentId, pinnedStatus, userId) > 0;
    }

    @Override
    public Boolean replyComment(Long parentCommentId, String content, List<Long> mentionedUsers) {
        try {
            HitTaskCommentVo parentComment = queryById(parentCommentId);
            if (parentComment == null) {
                throw new RuntimeException("父评论不存在");
            }

            HitTaskCommentBo bo = new HitTaskCommentBo();
            bo.setTaskId(parentComment.getTaskId());
            bo.setParentCommentId(parentCommentId);
            bo.setCommentContent(content);
            bo.setCommentType("normal");
            
            if (mentionedUsers != null && !mentionedUsers.isEmpty()) {
                bo.setMentionedUsers(objectMapper.writeValueAsString(mentionedUsers));
            }

            return insertByBo(bo);
        } catch (Exception e) {
            throw new RuntimeException("回复评论失败: " + e.getMessage());
        }
    }

    @Override
    public Boolean addTaskComment(Long taskId, String content, String commentType, 
                                 List<Long> mentionedUsers, List<Object> attachments) {
        try {
            HitTaskCommentBo bo = new HitTaskCommentBo();
            bo.setTaskId(taskId);
            bo.setCommentContent(content);
            bo.setCommentType(commentType);
            
            if (mentionedUsers != null && !mentionedUsers.isEmpty()) {
                bo.setMentionedUsers(objectMapper.writeValueAsString(mentionedUsers));
            }
            
            if (attachments != null && !attachments.isEmpty()) {
                bo.setAttachments(objectMapper.writeValueAsString(attachments));
            }

            return insertByBo(bo);
        } catch (Exception e) {
            throw new RuntimeException("添加评论失败: " + e.getMessage());
        }
    }

    @Override
    public List<HitTaskCommentVo> getCommentTree(Long taskId) {
        List<HitTaskCommentVo> topLevelComments = queryTopLevelComments(taskId);
        
        for (HitTaskCommentVo comment : topLevelComments) {
            List<HitTaskCommentVo> replies = queryRepliesByParentId(comment.getCommentId());
            comment.setChildren(replies);
        }
        
        return topLevelComments;
    }

    @Override
    public Boolean deleteCommentsByTaskId(Long taskId) {
        return baseMapper.deleteCommentsByTaskId(taskId) >= 0;
    }

    @Override
    public Boolean importCommentsFromTask(Long sourceTaskId, Long targetTaskId) {
        try {
            List<HitTaskCommentVo> sourceComments = queryCommentsByTaskId(sourceTaskId);
            
            for (HitTaskCommentVo sourceComment : sourceComments) {
                HitTaskCommentBo bo = new HitTaskCommentBo();
                bo.setTaskId(targetTaskId);
                bo.setCommentContent(sourceComment.getCommentContent());
                bo.setCommentType(sourceComment.getCommentType());
                bo.setMentionedUsers(sourceComment.getMentionedUsers());
                bo.setAttachments(sourceComment.getAttachments());
                
                insertByBo(bo);
            }
            
            return true;
        } catch (Exception e) {
            throw new RuntimeException("导入评论失败: " + e.getMessage());
        }
    }

    @Override
    public Object getCommentStatistics(Long taskId) {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalComments", countCommentsByTaskId(taskId));
        stats.put("pinnedComments", queryPinnedComments(taskId).size());
        
        List<HitTaskCommentVo> comments = queryCommentsByTaskId(taskId);
        Map<String, Long> typeStats = comments.stream()
            .collect(Collectors.groupingBy(HitTaskCommentVo::getCommentType, Collectors.counting()));
        stats.put("commentsByType", typeStats);
        
        return stats;
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
}
