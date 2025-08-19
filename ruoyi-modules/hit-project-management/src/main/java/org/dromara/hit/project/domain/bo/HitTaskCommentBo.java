package org.dromara.hit.project.domain.bo;

import org.dromara.hit.project.domain.HitTaskComment;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 任务评论业务对象 hit_task_comment
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitTaskComment.class, reverseConvertGenerate = false)
public class HitTaskCommentBo extends BaseEntity {

    /**
     * 评论ID
     */
    @NotNull(message = "评论ID不能为空", groups = { EditGroup.class })
    private Long commentId;

    /**
     * 任务ID
     */
    @NotNull(message = "任务ID不能为空", groups = { AddGroup.class, EditGroup.class })
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
    @NotBlank(message = "评论内容不能为空", groups = { AddGroup.class, EditGroup.class })
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
    @Min(value = 0, message = "点赞数不能小于0")
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
