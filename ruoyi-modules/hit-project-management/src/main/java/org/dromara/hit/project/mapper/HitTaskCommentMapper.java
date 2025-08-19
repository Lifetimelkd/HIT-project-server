package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitTaskComment;
import org.dromara.hit.project.domain.vo.HitTaskCommentVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 任务评论Mapper接口
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
public interface HitTaskCommentMapper extends BaseMapperPlus<HitTaskComment, HitTaskCommentVo> {

    /**
     * 查询评论详情（包含关联信息）
     *
     * @param commentId 评论ID
     * @return 评论详情
     */
    HitTaskCommentVo selectCommentWithDetails(@Param("commentId") Long commentId);

    /**
     * 查询任务的所有评论（包含关联信息）
     *
     * @param taskId 任务ID
     * @return 评论列表
     */
    List<HitTaskCommentVo> selectCommentsByTaskId(@Param("taskId") Long taskId);

    /**
     * 查询任务的顶级评论（不包含回复）
     *
     * @param taskId 任务ID
     * @return 顶级评论列表
     */
    List<HitTaskCommentVo> selectTopLevelComments(@Param("taskId") Long taskId);

    /**
     * 查询评论的回复
     *
     * @param parentCommentId 父评论ID
     * @return 回复列表
     */
    List<HitTaskCommentVo> selectRepliesByParentId(@Param("parentCommentId") Long parentCommentId);

    /**
     * 查询用户的评论
     *
     * @param userId 用户ID
     * @return 用户评论列表
     */
    List<HitTaskCommentVo> selectCommentsByUserId(@Param("userId") Long userId);

    /**
     * 查询置顶评论
     *
     * @param taskId 任务ID
     * @return 置顶评论列表
     */
    List<HitTaskCommentVo> selectPinnedComments(@Param("taskId") Long taskId);

    /**
     * 查询提及用户的评论
     *
     * @param userId 被提及用户ID
     * @return 提及评论列表
     */
    List<HitTaskCommentVo> selectCommentsByMentionedUser(@Param("userId") Long userId);

    /**
     * 统计任务评论数量
     *
     * @param taskId 任务ID
     * @return 评论数量
     */
    int countCommentsByTaskId(@Param("taskId") Long taskId);

    /**
     * 统计用户评论数量
     *
     * @param userId 用户ID
     * @return 评论数量
     */
    int countCommentsByUserId(@Param("userId") Long userId);

    /**
     * 更新评论点赞数
     *
     * @param commentId 评论ID
     * @param increment 增量（可为负数）
     * @return 更新结果
     */
    int updateLikeCount(@Param("commentId") Long commentId, @Param("increment") Integer increment);

    /**
     * 批量删除任务的所有评论
     *
     * @param taskId 任务ID
     * @return 删除结果
     */
    int deleteCommentsByTaskId(@Param("taskId") Long taskId);

    /**
     * 设置评论置顶状态
     *
     * @param commentId 评论ID
     * @param isPinned 是否置顶
     * @param userId 操作用户ID
     * @return 更新结果
     */
    int updatePinnedStatus(@Param("commentId") Long commentId, @Param("isPinned") String isPinned, @Param("userId") Long userId);

}
