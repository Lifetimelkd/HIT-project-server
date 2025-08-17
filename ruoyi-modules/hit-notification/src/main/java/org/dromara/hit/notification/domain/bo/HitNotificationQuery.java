package org.dromara.hit.notification.domain.bo;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.time.LocalDateTime;

/**
 * 消息通知查询对象 hit_notification
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class HitNotificationQuery extends BaseEntity {

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
     * 相关对象ID(项目ID/任务ID等)
     */
    private Long relatedId;

    /**
     * 相关对象类型(project/task/application等)
     */
    private String relatedType;

    /**
     * 是否已读(0否 1是)
     */
    private String isRead;

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
     * 发送时间开始
     */
    private LocalDateTime sendTimeStart;

    /**
     * 发送时间结束
     */
    private LocalDateTime sendTimeEnd;

    /**
     * 创建时间开始
     */
    private LocalDateTime createTimeStart;

    /**
     * 创建时间结束
     */
    private LocalDateTime createTimeEnd;

}
