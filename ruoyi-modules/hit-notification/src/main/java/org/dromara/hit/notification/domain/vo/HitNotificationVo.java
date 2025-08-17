package org.dromara.hit.notification.domain.vo;

import org.dromara.hit.notification.domain.HitNotification;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 消息通知视图对象 hit_notification
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitNotification.class)
public class HitNotificationVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 通知ID
     */
    @ExcelProperty(value = "通知ID")
    private Long notificationId;

    /**
     * 接收用户ID
     */
    @ExcelProperty(value = "接收用户ID")
    private Long userId;

    /**
     * 发送者ID
     */
    @ExcelProperty(value = "发送者ID")
    private Long senderId;

    /**
     * 通知类型(application/approval/project_update/task_assign等)
     */
    @ExcelProperty(value = "通知类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_notification_type")
    private String notificationType;

    /**
     * 通知标题
     */
    @ExcelProperty(value = "通知标题")
    private String title;

    /**
     * 通知内容
     */
    @ExcelProperty(value = "通知内容")
    private String content;

    /**
     * 相关对象ID(项目ID/任务ID等)
     */
    @ExcelProperty(value = "相关对象ID")
    private Long relatedId;

    /**
     * 相关对象类型(project/task/application等)
     */
    @ExcelProperty(value = "相关对象类型")
    private String relatedType;

    /**
     * 操作链接
     */
    @ExcelProperty(value = "操作链接")
    private String actionUrl;

    /**
     * 是否已读(0否 1是)
     */
    @ExcelProperty(value = "是否已读", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=否,1=是")
    private String isRead;

    /**
     * 阅读时间
     */
    @ExcelProperty(value = "阅读时间")
    private LocalDateTime readTime;

    /**
     * 优先级(low/normal/high/urgent)
     */
    @ExcelProperty(value = "优先级", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_notification_priority")
    private String priority;

    /**
     * 通知渠道(system/email/sms/wechat)
     */
    @ExcelProperty(value = "通知渠道", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_notification_channel")
    private String channel;

    /**
     * 发送状态(pending/sent/failed)
     */
    @ExcelProperty(value = "发送状态")
    private String sendStatus;

    /**
     * 发送时间
     */
    @ExcelProperty(value = "发送时间")
    private LocalDateTime sendTime;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private LocalDateTime createTime;

    /**
     * 发送者名称
     */
    @ExcelProperty(value = "发送者名称")
    private String senderName;

    /**
     * 接收者名称
     */
    @ExcelProperty(value = "接收者名称")
    private String receiverName;

}
