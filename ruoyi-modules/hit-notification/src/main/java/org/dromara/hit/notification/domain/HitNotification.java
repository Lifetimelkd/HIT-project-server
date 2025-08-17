package org.dromara.hit.notification.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.io.Serial;
import java.time.LocalDateTime;

/**
 * 消息通知对象 hit_notification
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_notification")
public class HitNotification extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 通知ID
     */
    @TableId(value = "notification_id")
    private Long notificationId;

    /**
     * 接收用户ID
     */
    private Long userId;

    /**
     * 发送者ID
     */
    private Long senderId;

    /**
     * 通知类型(application/approval/project_update/task_assign等)
     */
    private String notificationType;

    /**
     * 通知标题
     */
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
