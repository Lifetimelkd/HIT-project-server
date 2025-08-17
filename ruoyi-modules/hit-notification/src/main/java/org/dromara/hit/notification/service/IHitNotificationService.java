package org.dromara.hit.notification.service;

import org.dromara.hit.notification.domain.vo.HitNotificationVo;
import org.dromara.hit.notification.domain.bo.HitNotificationBo;
import org.dromara.hit.notification.domain.bo.HitNotificationQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 消息通知Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
public interface IHitNotificationService {

    /**
     * 查询消息通知
     */
    HitNotificationVo queryById(Long notificationId);

    /**
     * 查询消息通知列表
     */
    TableDataInfo<HitNotificationVo> queryPageList(HitNotificationQuery query, PageQuery pageQuery);

    /**
     * 查询消息通知列表
     */
    List<HitNotificationVo> queryList(HitNotificationQuery query);

    /**
     * 新增消息通知
     */
    Boolean insertByBo(HitNotificationBo bo);

    /**
     * 修改消息通知
     */
    Boolean updateByBo(HitNotificationBo bo);

    /**
     * 校验并批量删除消息通知信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 查询用户未读通知列表
     *
     * @param userId 用户ID
     * @return 未读通知列表
     */
    List<HitNotificationVo> queryUnreadNotifications(Long userId);

    /**
     * 查询用户已读通知列表
     *
     * @param userId 用户ID
     * @return 已读通知列表
     */
    List<HitNotificationVo> queryReadNotifications(Long userId);

    /**
     * 查询用户未读通知列表（分页）
     *
     * @param userId 用户ID
     * @param pageQuery 分页参数
     * @return 未读通知列表
     */
    TableDataInfo<HitNotificationVo> queryUnreadNotifications(Long userId, PageQuery pageQuery);

    /**
     * 查询用户已读通知列表（分页）
     *
     * @param userId 用户ID
     * @param pageQuery 分页参数
     * @return 已读通知列表
     */
    TableDataInfo<HitNotificationVo> queryReadNotifications(Long userId, PageQuery pageQuery);

    /**
     * 标记通知为已读
     *
     * @param notificationId 通知ID
     * @param userId 用户ID
     * @return 操作结果
     */
    Boolean markAsRead(Long notificationId, Long userId);

    /**
     * 批量标记通知为已读
     *
     * @param notificationIds 通知ID列表
     * @param userId 用户ID
     * @return 操作结果
     */
    Boolean batchMarkAsRead(List<Long> notificationIds, Long userId);

    /**
     * 标记所有通知为已读
     *
     * @param userId 用户ID
     * @return 操作结果
     */
    Boolean markAllAsRead(Long userId);

    /**
     * 查询用户未读通知数量
     *
     * @param userId 用户ID
     * @return 未读通知数量
     */
    Long countUnreadNotifications(Long userId);

    /**
     * 删除已读通知
     *
     * @param notificationIds 通知ID列表
     * @param userId 用户ID
     * @return 操作结果
     */
    Boolean deleteReadNotifications(List<Long> notificationIds, Long userId);

    /**
     * 发送通知
     *
     * @param bo 通知信息
     * @return 操作结果
     */
    Boolean sendNotification(HitNotificationBo bo);

    /**
     * 发送系统通知
     *
     * @param userId 接收用户ID
     * @param title 通知标题
     * @param content 通知内容
     * @param notificationType 通知类型
     * @return 操作结果
     */
    Boolean sendSystemNotification(Long userId, String title, String content, String notificationType);

    /**
     * 发送项目相关通知
     *
     * @param userId 接收用户ID
     * @param title 通知标题
     * @param content 通知内容
     * @param projectId 项目ID
     * @param notificationType 通知类型
     * @return 操作结果
     */
    Boolean sendProjectNotification(Long userId, String title, String content, Long projectId, String notificationType);

}
