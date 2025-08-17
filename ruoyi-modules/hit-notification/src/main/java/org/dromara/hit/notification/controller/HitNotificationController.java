package org.dromara.hit.notification.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.hit.notification.domain.vo.HitNotificationVo;
import org.dromara.hit.notification.domain.bo.HitNotificationBo;
import org.dromara.hit.notification.domain.bo.HitNotificationQuery;
import org.dromara.hit.notification.service.IHitNotificationService;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.satoken.utils.LoginHelper;

/**
 * 消息通知
 *
 * @author HIT-project-team
 * @date 2025-01-17
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/notification")
public class HitNotificationController extends BaseController {

    private final IHitNotificationService hitNotificationService;

    /**
     * 查询消息通知列表
     */
    @SaCheckPermission("hit:notification:list")
    @GetMapping("/list")
    public TableDataInfo<HitNotificationVo> list(HitNotificationQuery query, PageQuery pageQuery) {
        return hitNotificationService.queryPageList(query, pageQuery);
    }

    /**
     * 导出消息通知列表
     */
    @SaCheckPermission("hit:notification:export")
    @Log(title = "消息通知", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitNotificationQuery query, HttpServletResponse response) {
        List<HitNotificationVo> list = hitNotificationService.queryList(query);
        ExcelUtil.exportExcel(list, "消息通知", HitNotificationVo.class, response);
    }

    /**
     * 获取消息通知详细信息
     */
    @SaCheckPermission("hit:notification:query")
    @GetMapping("/{notificationId}")
    public R<HitNotificationVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long notificationId) {
        return R.ok(hitNotificationService.queryById(notificationId));
    }

    /**
     * 新增消息通知
     */
    @SaCheckPermission("hit:notification:add")
    @Log(title = "消息通知", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitNotificationBo bo) {
        return toAjax(hitNotificationService.insertByBo(bo));
    }

    /**
     * 修改消息通知
     */
    @SaCheckPermission("hit:notification:edit")
    @Log(title = "消息通知", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitNotificationBo bo) {
        return toAjax(hitNotificationService.updateByBo(bo));
    }

    /**
     * 删除消息通知
     */
    @SaCheckPermission("hit:notification:remove")
    @Log(title = "消息通知", businessType = BusinessType.DELETE)
    @DeleteMapping("/{notificationIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] notificationIds) {
        return toAjax(hitNotificationService.deleteWithValidByIds(List.of(notificationIds), true));
    }

    // ==================== 用户通知相关接口 ====================

    /**
     * 获取当前用户未读通知列表
     */
    @GetMapping("/my/unread")
    public TableDataInfo<HitNotificationVo> getMyUnreadNotifications(PageQuery pageQuery) {
        Long userId = LoginHelper.getUserId();
        System.out.println("查询用户未读通知 - 用户ID: " + userId + ", 分页参数: " + pageQuery);
        TableDataInfo<HitNotificationVo> result = hitNotificationService.queryUnreadNotifications(userId, pageQuery);
        System.out.println("未读通知查询结果 - 总数: " + result.getTotal() + ", 当前页数据量: " + result.getRows().size());
        return result;
    }

    /**
     * 获取当前用户已读通知列表
     */
    @GetMapping("/my/read")
    public TableDataInfo<HitNotificationVo> getMyReadNotifications(PageQuery pageQuery) {
        Long userId = LoginHelper.getUserId();
        System.out.println("查询用户已读通知 - 用户ID: " + userId + ", 分页参数: " + pageQuery);
        TableDataInfo<HitNotificationVo> result = hitNotificationService.queryReadNotifications(userId, pageQuery);
        System.out.println("已读通知查询结果 - 总数: " + result.getTotal() + ", 当前页数据量: " + result.getRows().size());
        return result;
    }

    /**
     * 获取当前用户未读通知数量
     */
    @GetMapping("/my/unread/count")
    public R<Long> getUnreadCount() {
        Long userId = LoginHelper.getUserId();
        Long count = hitNotificationService.countUnreadNotifications(userId);
        System.out.println("查询用户未读通知数量 - 用户ID: " + userId + ", 未读数量: " + count);
        return R.ok(count);
    }

    /**
     * 标记通知为已读
     */
    @Log(title = "消息通知", businessType = BusinessType.UPDATE)
    @PostMapping("/{notificationId}/read")
    public R<Void> markAsRead(@PathVariable Long notificationId) {
        Long userId = LoginHelper.getUserId();
        return toAjax(hitNotificationService.markAsRead(notificationId, userId));
    }

    /**
     * 批量标记通知为已读
     */
    @Log(title = "消息通知", businessType = BusinessType.UPDATE)
    @PostMapping("/batch/read")
    public R<Void> batchMarkAsRead(@RequestBody List<Long> notificationIds) {
        Long userId = LoginHelper.getUserId();
        return toAjax(hitNotificationService.batchMarkAsRead(notificationIds, userId));
    }

    /**
     * 标记所有通知为已读
     */
    @Log(title = "消息通知", businessType = BusinessType.UPDATE)
    @PostMapping("/all/read")
    public R<Void> markAllAsRead() {
        Long userId = LoginHelper.getUserId();
        return toAjax(hitNotificationService.markAllAsRead(userId));
    }

    /**
     * 删除已读通知
     */
    @Log(title = "消息通知", businessType = BusinessType.DELETE)
    @DeleteMapping("/read")
    public R<Void> deleteReadNotifications(@RequestBody List<Long> notificationIds) {
        Long userId = LoginHelper.getUserId();
        return toAjax(hitNotificationService.deleteReadNotifications(notificationIds, userId));
    }

    /**
     * 发送通知（管理员接口）
     */
    @SaCheckPermission("hit:notification:send")
    @Log(title = "消息通知", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping("/send")
    public R<Void> sendNotification(@Validated(AddGroup.class) @RequestBody HitNotificationBo bo) {
        return toAjax(hitNotificationService.sendNotification(bo));
    }

    /**
     * 创建测试通知（用于调试）
     */
    @PostMapping("/test/create")
    public R<Void> createTestNotification() {
        Long userId = LoginHelper.getUserId();
        System.out.println("创建测试通知 - 用户ID: " + userId);

        Boolean result = hitNotificationService.sendSystemNotification(
            userId,
            "测试通知",
            "这是一条测试通知消息，用于验证通知功能是否正常工作。",
            "system"
        );

        System.out.println("测试通知创建结果: " + result);
        return toAjax(result);
    }

    /**
     * 直接查询数据库中的通知数据（用于调试）
     */
    @GetMapping("/test/db-check")
    public R<String> checkDatabaseData() {
        Long userId = LoginHelper.getUserId();
        System.out.println("检查数据库通知数据 - 用户ID: " + userId);

        // 直接查询未读通知
        List<HitNotificationVo> unreadList = hitNotificationService.queryUnreadNotifications(userId);
        System.out.println("数据库中未读通知数量: " + unreadList.size());

        // 查询未读通知数量
        Long unreadCount = hitNotificationService.countUnreadNotifications(userId);
        System.out.println("数据库中未读通知计数: " + unreadCount);

        StringBuilder result = new StringBuilder();
        result.append("用户ID: ").append(userId).append("\n");
        result.append("未读通知数量: ").append(unreadList.size()).append("\n");
        result.append("未读通知计数: ").append(unreadCount).append("\n");

        if (!unreadList.isEmpty()) {
            result.append("最新通知: ").append(unreadList.get(0).getTitle()).append("\n");
        }

        return R.ok(result.toString());
    }

}
