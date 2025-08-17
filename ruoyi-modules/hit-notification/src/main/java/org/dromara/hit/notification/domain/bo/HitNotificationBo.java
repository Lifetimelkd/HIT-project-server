package org.dromara.hit.notification.domain.bo;

import org.dromara.hit.notification.domain.HitNotification;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.time.LocalDateTime;

/**
 * 消息通知业务对象 hit_notification
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitNotification.class, reverseConvertGenerate = false)
public class HitNotificationBo extends BaseEntity {

    /**
     * 通知ID
     */
    @NotNull(message = "通知ID不能为空", groups = { EditGroup.class })
    private Long notificationId;

    /**
     * 接收用户ID
     */
    @NotNull(message = "接收用户ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 发送者ID
     */
    private Long senderId;

    /**
     * 通知类型(application/approval/project_update/task_assign等)
     */
    @NotBlank(message = "通知类型不能为空", groups = { AddGroup.class, EditGroup.class })
    private String notificationType;

    /**
     * 通知标题
     */
    @NotBlank(message = "通知标题不能为空", groups = { AddGroup.class, EditGroup.class })
    @Size(max = 200, message = "通知标题长度不能超过200个字符")
    private String title;

    /**
     * 通知内容
     */
    private String content;

    /**
     * 相关对象ID(项目ID/任务ID等)
     */
    private Long relatedId;

    /**
     * 相关对象类型(project/task/application等)
     */
    private String relatedType;

    /**
     * 操作链接
     */
    @Size(max = 500, message = "操作链接长度不能超过500个字符")
    private String actionUrl;

    /**
     * 是否已读(0否 1是)
     */
    private String isRead;

    /**
     * 阅读时间
     */
    private LocalDateTime readTime;

    /**
     * 优先级(low/normal/high/urgent)
     */
    private String priority;

    /**
     * 通知渠道(system/email/sms/wechat)
     */
    private String channel;

    /**
     * 发送状态(pending/sent/failed)
     */
    private String sendStatus;

    /**
     * 发送时间
     */
    private LocalDateTime sendTime;

    /**
     * 关联部门id
     */
    private Long deptId;

}
