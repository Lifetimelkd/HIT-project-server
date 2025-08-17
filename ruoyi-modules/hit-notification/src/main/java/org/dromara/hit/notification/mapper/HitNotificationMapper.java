package org.dromara.hit.notification.mapper;

import org.dromara.hit.notification.domain.HitNotification;
import org.dromara.hit.notification.domain.vo.HitNotificationVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.List;

/**
 * 消息通知Mapper接口
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
public interface HitNotificationMapper extends BaseMapperPlus<HitNotification, HitNotificationVo> {

    /**
     * 查询用户未读通知列表
     *
     * @param userId 用户ID
     * @return 未读通知列表
     */
    List<HitNotificationVo> selectUnreadNotifications(@Param("userId") Long userId);

    /**
     * 查询用户已读通知列表
     *
     * @param userId 用户ID
     * @return 已读通知列表
     */
    List<HitNotificationVo> selectReadNotifications(@Param("userId") Long userId);

    /**
     * 查询用户未读通知列表（分页）
     *
     * @param page 分页参数
     * @param userId 用户ID
     * @return 未读通知列表
     */
    IPage<HitNotificationVo> selectUnreadNotificationsPage(Page<HitNotificationVo> page, @Param("userId") Long userId);

    /**
     * 查询用户已读通知列表（分页）
     *
     * @param page 分页参数
     * @param userId 用户ID
     * @return 已读通知列表
     */
    IPage<HitNotificationVo> selectReadNotificationsPage(Page<HitNotificationVo> page, @Param("userId") Long userId);

    /**
     * 批量标记通知为已读
     *
     * @param notificationIds 通知ID列表
     * @param userId 用户ID
     * @return 更新行数
     */
    int batchMarkAsRead(@Param("notificationIds") List<Long> notificationIds, @Param("userId") Long userId);

    /**
     * 标记所有通知为已读
     *
     * @param userId 用户ID
     * @return 更新行数
     */
    int markAllAsRead(@Param("userId") Long userId);

    /**
     * 查询用户未读通知数量
     *
     * @param userId 用户ID
     * @return 未读通知数量
     */
    Long countUnreadNotifications(@Param("userId") Long userId);

    /**
     * 删除用户的已读通知
     *
     * @param notificationIds 通知ID列表
     * @param userId 用户ID
     * @return 删除行数
     */
    int deleteReadNotifications(@Param("notificationIds") List<Long> notificationIds, @Param("userId") Long userId);

    /**
     * 查询通知详情（包含发送者和接收者信息）
     *
     * @param notificationId 通知ID
     * @return 通知详情
     */
    HitNotificationVo selectNotificationWithUserInfo(@Param("notificationId") Long notificationId);

}
