package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitTaskCommentVo;
import org.dromara.hit.project.domain.bo.HitTaskCommentBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 任务评论Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
public interface IHitTaskCommentService {

    /**
     * 查询任务评论
     */
    HitTaskCommentVo queryById(Long commentId);

    /**
     * 查询任务评论列表
     */
    TableDataInfo<HitTaskCommentVo> queryPageList(HitTaskCommentBo bo, PageQuery pageQuery);

    /**
     * 查询任务评论列表
     */
    List<HitTaskCommentVo> queryList(HitTaskCommentBo bo);

    /**
     * 新增任务评论
     */
    Boolean insertByBo(HitTaskCommentBo bo);

    /**
     * 修改任务评论
     */
    Boolean updateByBo(HitTaskCommentBo bo);

    /**
     * 校验并批量删除任务评论信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    // ==================== 业务接口 ====================

    /**
     * 查询任务的所有评论（包含关联信息）
     *
     * @param taskId 任务ID
     * @return 评论列表
     */
    List<HitTaskCommentVo> queryCommentsByTaskId(Long taskId);

    /**
     * 查询任务的顶级评论（不包含回复）
     *
     * @param taskId 任务ID
     * @return 顶级评论列表
     */
    List<HitTaskCommentVo> queryTopLevelComments(Long taskId);

    /**
     * 查询评论的回复
     *
     * @param parentCommentId 父评论ID
     * @return 回复列表
     */
    List<HitTaskCommentVo> queryRepliesByParentId(Long parentCommentId);

    /**
     * 查询用户的评论
     *
     * @param userId 用户ID
     * @return 用户评论列表
     */
    List<HitTaskCommentVo> queryCommentsByUserId(Long userId);

    /**
     * 查询置顶评论
     *
     * @param taskId 任务ID
     * @return 置顶评论列表
     */
    List<HitTaskCommentVo> queryPinnedComments(Long taskId);

    /**
     * 查询提及用户的评论
     *
     * @param userId 被提及用户ID
     * @return 提及评论列表
     */
    List<HitTaskCommentVo> queryCommentsByMentionedUser(Long userId);

    /**
     * 统计任务评论数量
     *
     * @param taskId 任务ID
     * @return 评论数量
     */
    Integer countCommentsByTaskId(Long taskId);

    /**
     * 统计用户评论数量
     *
     * @param userId 用户ID
     * @return 评论数量
     */
    Integer countCommentsByUserId(Long userId);

    /**
     * 点赞评论
     *
     * @param commentId 评论ID
     * @return 操作结果
     */
    Boolean likeComment(Long commentId);

    /**
     * 取消点赞评论
     *
     * @param commentId 评论ID
     * @return 操作结果
     */
    Boolean unlikeComment(Long commentId);

    /**
     * 设置评论置顶状态
     *
     * @param commentId 评论ID
     * @param isPinned 是否置顶
     * @return 操作结果
     */
    Boolean setPinnedStatus(Long commentId, Boolean isPinned);

    /**
     * 回复评论
     *
     * @param parentCommentId 父评论ID
     * @param content 回复内容
     * @param mentionedUsers 提及的用户ID列表
     * @return 操作结果
     */
    Boolean replyComment(Long parentCommentId, String content, List<Long> mentionedUsers);

    /**
     * 添加任务评论（带@提醒功能）
     *
     * @param taskId 任务ID
     * @param content 评论内容
     * @param commentType 评论类型
     * @param mentionedUsers 提及的用户ID列表
     * @param attachments 附件列表
     * @return 操作结果
     */
    Boolean addTaskComment(Long taskId, String content, String commentType, 
                          List<Long> mentionedUsers, List<Object> attachments);

    /**
     * 获取任务评论树形结构
     *
     * @param taskId 任务ID
     * @return 评论树形结构
     */
    List<HitTaskCommentVo> getCommentTree(Long taskId);

    /**
     * 批量删除任务的所有评论
     *
     * @param taskId 任务ID
     * @return 删除结果
     */
    Boolean deleteCommentsByTaskId(Long taskId);

    /**
     * 导入评论（从其他任务复制评论）
     *
     * @param sourceTaskId 源任务ID
     * @param targetTaskId 目标任务ID
     * @return 导入结果
     */
    Boolean importCommentsFromTask(Long sourceTaskId, Long targetTaskId);

    /**
     * 获取评论统计信息
     *
     * @param taskId 任务ID
     * @return 统计信息
     */
    Object getCommentStatistics(Long taskId);

}
