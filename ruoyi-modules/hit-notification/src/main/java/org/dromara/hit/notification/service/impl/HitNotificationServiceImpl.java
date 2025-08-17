package org.dromara.hit.notification.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.hit.notification.domain.bo.HitNotificationBo;
import org.dromara.hit.notification.domain.vo.HitNotificationVo;
import org.dromara.hit.notification.domain.bo.HitNotificationQuery;
import org.dromara.hit.notification.domain.HitNotification;
import org.dromara.hit.notification.mapper.HitNotificationMapper;
import org.dromara.hit.notification.service.IHitNotificationService;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.common.sse.utils.SseMessageUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 消息通知Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@RequiredArgsConstructor
@Service
public class HitNotificationServiceImpl implements IHitNotificationService {

    private final HitNotificationMapper baseMapper;

    /**
     * 查询消息通知
     */
    @Override
    public HitNotificationVo queryById(Long notificationId){
        return baseMapper.selectNotificationWithUserInfo(notificationId);
    }

    /**
     * 查询消息通知列表
     */
    @Override
    public TableDataInfo<HitNotificationVo> queryPageList(HitNotificationQuery query, PageQuery pageQuery) {
        LambdaQueryWrapper<HitNotification> lqw = buildQueryWrapper(query);
        Page<HitNotificationVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询消息通知列表
     */
    @Override
    public List<HitNotificationVo> queryList(HitNotificationQuery query) {
        LambdaQueryWrapper<HitNotification> lqw = buildQueryWrapper(query);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitNotification> buildQueryWrapper(HitNotificationQuery query) {
        Map<String, Object> params = query.getParams();
        LambdaQueryWrapper<HitNotification> lqw = Wrappers.lambdaQuery();
        lqw.eq(query.getUserId() != null, HitNotification::getUserId, query.getUserId());
        lqw.eq(query.getSenderId() != null, HitNotification::getSenderId, query.getSenderId());
        lqw.eq(StringUtils.isNotBlank(query.getNotificationType()), HitNotification::getNotificationType, query.getNotificationType());
        lqw.like(StringUtils.isNotBlank(query.getTitle()), HitNotification::getTitle, query.getTitle());
        lqw.eq(query.getRelatedId() != null, HitNotification::getRelatedId, query.getRelatedId());
        lqw.eq(StringUtils.isNotBlank(query.getRelatedType()), HitNotification::getRelatedType, query.getRelatedType());
        lqw.eq(StringUtils.isNotBlank(query.getIsRead()), HitNotification::getIsRead, query.getIsRead());
        lqw.eq(StringUtils.isNotBlank(query.getPriority()), HitNotification::getPriority, query.getPriority());
        lqw.eq(StringUtils.isNotBlank(query.getChannel()), HitNotification::getChannel, query.getChannel());
        lqw.eq(StringUtils.isNotBlank(query.getSendStatus()), HitNotification::getSendStatus, query.getSendStatus());
        lqw.between(params.get("beginSendTime") != null && params.get("endSendTime") != null,
            HitNotification::getSendTime, params.get("beginSendTime"), params.get("endSendTime"));
        lqw.between(params.get("beginCreateTime") != null && params.get("endCreateTime") != null,
            HitNotification::getCreateTime, params.get("beginCreateTime"), params.get("endCreateTime"));
        lqw.orderByDesc(HitNotification::getCreateTime);
        return lqw;
    }

    /**
     * 新增消息通知
     */
    @Override
    public Boolean insertByBo(HitNotificationBo bo) {
        HitNotification add = MapstructUtils.convert(bo, HitNotification.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setNotificationId(add.getNotificationId());
        }
        return flag;
    }

    /**
     * 修改消息通知
     */
    @Override
    public Boolean updateByBo(HitNotificationBo bo) {
        HitNotification update = MapstructUtils.convert(bo, HitNotification.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitNotification entity){
        // 设置默认值
        if (StringUtils.isBlank(entity.getIsRead())) {
            entity.setIsRead("0"); // 默认未读
        }
        if (StringUtils.isBlank(entity.getPriority())) {
            entity.setPriority("normal"); // 默认普通优先级
        }
        if (StringUtils.isBlank(entity.getChannel())) {
            entity.setChannel("system"); // 默认系统通知
        }
        if (StringUtils.isBlank(entity.getSendStatus())) {
            entity.setSendStatus("sent"); // 默认已发送
        }
        if (entity.getSendTime() == null) {
            entity.setSendTime(LocalDateTime.now());
        }
    }

    /**
     * 批量删除消息通知
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 查询用户未读通知列表
     */
    @Override
    public List<HitNotificationVo> queryUnreadNotifications(Long userId) {
        return baseMapper.selectUnreadNotifications(userId);
    }

    /**
     * 查询用户已读通知列表
     */
    @Override
    public List<HitNotificationVo> queryReadNotifications(Long userId) {
        return baseMapper.selectReadNotifications(userId);
    }

    /**
     * 查询用户未读通知列表（分页）
     */
    @Override
    public TableDataInfo<HitNotificationVo> queryUnreadNotifications(Long userId, PageQuery pageQuery) {
        Page<HitNotificationVo> page = pageQuery.build();
        System.out.println("Service分页查询未读通知 - 用户ID: " + userId + ", 页码: " + page.getCurrent() + ", 页大小: " + page.getSize());

        // 使用数据库分页查询，提高效率
        IPage<HitNotificationVo> result = baseMapper.selectUnreadNotificationsPage(page, userId);
        System.out.println("Service分页查询结果 - 总数: " + result.getTotal() + ", 当前页数据量: " + result.getRecords().size());

        return TableDataInfo.build(result);
    }

    /**
     * 查询用户已读通知列表（分页）
     */
    @Override
    public TableDataInfo<HitNotificationVo> queryReadNotifications(Long userId, PageQuery pageQuery) {
        Page<HitNotificationVo> page = pageQuery.build();
        // 使用数据库分页查询，提高效率
        IPage<HitNotificationVo> result = baseMapper.selectReadNotificationsPage(page, userId);
        return TableDataInfo.build(result);
    }

    /**
     * 标记通知为已读
     */
    @Override
    public Boolean markAsRead(Long notificationId, Long userId) {
        return batchMarkAsRead(List.of(notificationId), userId);
    }

    /**
     * 批量标记通知为已读
     */
    @Override
    public Boolean batchMarkAsRead(List<Long> notificationIds, Long userId) {
        return baseMapper.batchMarkAsRead(notificationIds, userId) > 0;
    }

    /**
     * 标记所有通知为已读
     */
    @Override
    public Boolean markAllAsRead(Long userId) {
        return baseMapper.markAllAsRead(userId) > 0;
    }

    /**
     * 查询用户未读通知数量
     */
    @Override
    public Long countUnreadNotifications(Long userId) {
        return baseMapper.countUnreadNotifications(userId);
    }

    /**
     * 删除已读通知
     */
    @Override
    public Boolean deleteReadNotifications(List<Long> notificationIds, Long userId) {
        return baseMapper.deleteReadNotifications(notificationIds, userId) > 0;
    }

    /**
     * 发送通知
     */
    @Override
    public Boolean sendNotification(HitNotificationBo bo) {
        // 保存通知到数据库
        Boolean result = insertByBo(bo);

        if (result && bo.getUserId() != null) {
            // 发送SSE实时通知
            try {
                String message = bo.getTitle();
                if (StringUtils.isNotBlank(bo.getContent())) {
                    message = bo.getTitle() + ": " + bo.getContent();
                }
                SseMessageUtils.sendMessage(bo.getUserId(), message);
            } catch (Exception e) {
                // SSE发送失败不影响通知保存
                System.err.println("SSE通知发送失败: " + e.getMessage());
            }
        }

        return result;
    }

    /**
     * 发送系统通知
     */
    @Override
    public Boolean sendSystemNotification(Long userId, String title, String content, String notificationType) {
        HitNotificationBo bo = new HitNotificationBo();
        bo.setUserId(userId);
        bo.setSenderId(1L); // 系统通知，设置发送者为系统管理员
        bo.setTitle(title);
        bo.setContent(content);
        bo.setNotificationType(notificationType);
        bo.setPriority("normal");
        bo.setChannel("system");

        System.out.println("创建系统通知 - 接收用户ID: " + userId + ", 标题: " + title);
        return sendNotification(bo);
    }

    /**
     * 发送项目相关通知
     */
    @Override
    public Boolean sendProjectNotification(Long userId, String title, String content, Long projectId, String notificationType) {
        HitNotificationBo bo = new HitNotificationBo();
        bo.setUserId(userId);
        bo.setTitle(title);
        bo.setContent(content);
        bo.setNotificationType(notificationType);
        bo.setRelatedId(projectId);
        bo.setRelatedType("project");
        bo.setPriority("normal");
        bo.setChannel("system");

        return sendNotification(bo);
    }
}
