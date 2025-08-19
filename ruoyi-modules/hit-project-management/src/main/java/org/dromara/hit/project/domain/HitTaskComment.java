package org.dromara.hit.project.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.tenant.core.TenantEntity;

/**
 * 任务评论对象 hit_task_comment
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_task_comment")
public class HitTaskComment extends TenantEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 评论ID
     */
    @TableId(value = "comment_id")
    private Long commentId;

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 评论人ID
     */
    private Long userId;

    /**
     * 父评论ID
     */
    private Long parentCommentId;

    /**
     * 评论内容
     */
    private String commentContent;

    /**
     * 评论类型(normal/status_change/file_upload)
     */
    private String commentType;

    /**
     * 提及用户ID列表(JSON格式)
     */
    private String mentionedUsers;

    /**
     * 附件列表(JSON格式)
     */
    private String attachments;

    /**
     * 点赞数
     */
    private Integer likeCount;

    /**
     * 是否置顶(0否 1是)
     */
    private String isPinned;

    /**
     * 关联部门id
     */
    private Long deptId;

}
