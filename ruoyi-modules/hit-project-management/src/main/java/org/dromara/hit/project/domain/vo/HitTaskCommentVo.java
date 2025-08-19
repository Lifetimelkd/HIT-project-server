package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitTaskComment;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 任务评论视图对象 hit_task_comment
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitTaskComment.class)
public class HitTaskCommentVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 评论ID
     */
    @ExcelProperty(value = "评论ID")
    private Long commentId;

    /**
     * 任务ID
     */
    @ExcelProperty(value = "任务ID")
    private Long taskId;

    /**
     * 任务名称
     */
    @ExcelProperty(value = "任务名称")
    private String taskName;

    /**
     * 评论人ID
     */
    @ExcelProperty(value = "评论人ID")
    private Long userId;

    /**
     * 评论人姓名
     */
    @ExcelProperty(value = "评论人姓名")
    private String userName;

    /**
     * 评论人头像
     */
    private String userAvatar;

    /**
     * 父评论ID
     */
    @ExcelProperty(value = "父评论ID")
    private Long parentCommentId;

    /**
     * 父评论内容
     */
    private String parentCommentContent;

    /**
     * 父评论用户名
     */
    private String parentUserName;

    /**
     * 评论内容
     */
    @ExcelProperty(value = "评论内容")
    private String commentContent;

    /**
     * 评论类型
     */
    @ExcelProperty(value = "评论类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "normal=普通评论,status_change=状态变更,file_upload=文件上传")
    private String commentType;

    /**
     * 提及用户ID列表(JSON格式)
     */
    private String mentionedUsers;

    /**
     * 提及用户列表
     */
    private List<String> mentionedUserNames;

    /**
     * 附件列表(JSON格式)
     */
    private String attachments;

    /**
     * 附件列表
     */
    private List<Object> attachmentList;

    /**
     * 点赞数
     */
    @ExcelProperty(value = "点赞数")
    private Integer likeCount;

    /**
     * 是否置顶(0否 1是)
     */
    @ExcelProperty(value = "是否置顶", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=否,1=是")
    private String isPinned;

    /**
     * 关联部门id
     */
    private Long deptId;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    /**
     * 子评论列表
     */
    private List<HitTaskCommentVo> children;

    /**
     * 当前用户是否点赞
     */
    private Boolean isLiked;

}
