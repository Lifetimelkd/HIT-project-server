package org.dromara.hit.project.controller;

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
import org.dromara.hit.project.domain.vo.HitTaskCommentVo;
import org.dromara.hit.project.domain.bo.HitTaskCommentBo;
import org.dromara.hit.project.service.IHitTaskCommentService;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.satoken.utils.LoginHelper;

/**
 * 任务评论
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project/task/comment")
public class HitTaskCommentController extends BaseController {

    private final IHitTaskCommentService hitTaskCommentService;

    /**
     * 查询任务评论列表
     */
    @SaCheckPermission("hit:project:task:comment:list")
    @GetMapping("/list")
    public TableDataInfo<HitTaskCommentVo> list(HitTaskCommentBo bo, PageQuery pageQuery) {
        return hitTaskCommentService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出任务评论列表
     */
    @SaCheckPermission("hit:project:task:comment:export")
    @Log(title = "任务评论", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitTaskCommentBo bo, HttpServletResponse response) {
        List<HitTaskCommentVo> list = hitTaskCommentService.queryList(bo);
        ExcelUtil.exportExcel(list, "任务评论", HitTaskCommentVo.class, response);
    }

    /**
     * 获取任务评论详细信息
     */
    @SaCheckPermission("hit:project:task:comment:query")
    @GetMapping("/{commentId}")
    public R<HitTaskCommentVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long commentId) {
        return R.ok(hitTaskCommentService.queryById(commentId));
    }

    /**
     * 新增任务评论
     */
    @SaCheckPermission("hit:project:task:comment:add")
    @Log(title = "任务评论", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitTaskCommentBo bo) {
        return toAjax(hitTaskCommentService.insertByBo(bo));
    }

    /**
     * 修改任务评论
     */
    @SaCheckPermission("hit:project:task:comment:edit")
    @Log(title = "任务评论", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitTaskCommentBo bo) {
        return toAjax(hitTaskCommentService.updateByBo(bo));
    }

    /**
     * 删除任务评论
     */
    @SaCheckPermission("hit:project:task:comment:remove")
    @Log(title = "任务评论", businessType = BusinessType.DELETE)
    @DeleteMapping("/{commentIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] commentIds) {
        return toAjax(hitTaskCommentService.deleteWithValidByIds(List.of(commentIds), true));
    }

    // ==================== 业务接口 ====================

    /**
     * 查询任务的所有评论
     */
    @GetMapping("/task/{taskId}")
    public R<List<HitTaskCommentVo>> getTaskComments(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.queryCommentsByTaskId(taskId));
    }

    /**
     * 查询任务的评论树形结构
     */
    @GetMapping("/task/{taskId}/tree")
    public R<List<HitTaskCommentVo>> getTaskCommentTree(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.getCommentTree(taskId));
    }

    /**
     * 查询任务的顶级评论
     */
    @GetMapping("/task/{taskId}/top-level")
    public R<List<HitTaskCommentVo>> getTopLevelComments(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.queryTopLevelComments(taskId));
    }

    /**
     * 查询评论的回复
     */
    @GetMapping("/{parentCommentId}/replies")
    public R<List<HitTaskCommentVo>> getReplies(@PathVariable Long parentCommentId) {
        return R.ok(hitTaskCommentService.queryRepliesByParentId(parentCommentId));
    }

    /**
     * 查询用户的评论
     */
    @GetMapping("/my/comments")
    public R<List<HitTaskCommentVo>> getMyComments() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitTaskCommentService.queryCommentsByUserId(userId));
    }

    /**
     * 查询置顶评论
     */
    @GetMapping("/task/{taskId}/pinned")
    public R<List<HitTaskCommentVo>> getPinnedComments(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.queryPinnedComments(taskId));
    }

    /**
     * 查询提及我的评论
     */
    @GetMapping("/my/mentioned")
    public R<List<HitTaskCommentVo>> getMentionedComments() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitTaskCommentService.queryCommentsByMentionedUser(userId));
    }

    /**
     * 统计任务评论数量
     */
    @GetMapping("/task/{taskId}/count")
    public R<Integer> getTaskCommentCount(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.countCommentsByTaskId(taskId));
    }

    /**
     * 统计用户评论数量
     */
    @GetMapping("/my/count")
    public R<Integer> getMyCommentCount() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitTaskCommentService.countCommentsByUserId(userId));
    }

    /**
     * 点赞评论
     */
    @Log(title = "点赞评论", businessType = BusinessType.UPDATE)
    @PostMapping("/{commentId}/like")
    public R<Void> likeComment(@PathVariable Long commentId) {
        return toAjax(hitTaskCommentService.likeComment(commentId));
    }

    /**
     * 取消点赞评论
     */
    @Log(title = "取消点赞评论", businessType = BusinessType.UPDATE)
    @PostMapping("/{commentId}/unlike")
    public R<Void> unlikeComment(@PathVariable Long commentId) {
        return toAjax(hitTaskCommentService.unlikeComment(commentId));
    }

    /**
     * 设置评论置顶状态
     */
    @SaCheckPermission("hit:project:task:comment:pin")
    @Log(title = "设置评论置顶", businessType = BusinessType.UPDATE)
    @PutMapping("/{commentId}/pin")
    public R<Void> setPinnedStatus(@PathVariable Long commentId, @RequestParam Boolean isPinned) {
        return toAjax(hitTaskCommentService.setPinnedStatus(commentId, isPinned));
    }

    /**
     * 回复评论
     */
    @SaCheckPermission("hit:project:task:comment:add")
    @Log(title = "回复评论", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping("/{parentCommentId}/reply")
    public R<Void> replyComment(@PathVariable Long parentCommentId, 
                               @RequestParam String content,
                               @RequestParam(required = false) List<Long> mentionedUsers) {
        return toAjax(hitTaskCommentService.replyComment(parentCommentId, content, mentionedUsers));
    }

    /**
     * 添加任务评论（带@提醒功能）
     */
    @SaCheckPermission("hit:project:task:comment:add")
    @Log(title = "添加任务评论", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping("/task/{taskId}/add")
    public R<Void> addTaskComment(@PathVariable Long taskId,
                                 @RequestParam String content,
                                 @RequestParam(defaultValue = "normal") String commentType,
                                 @RequestParam(required = false) List<Long> mentionedUsers,
                                 @RequestParam(required = false) List<Object> attachments) {
        return toAjax(hitTaskCommentService.addTaskComment(taskId, content, commentType, mentionedUsers, attachments));
    }

    /**
     * 获取评论统计信息
     */
    @GetMapping("/task/{taskId}/statistics")
    public R<Object> getCommentStatistics(@PathVariable Long taskId) {
        return R.ok(hitTaskCommentService.getCommentStatistics(taskId));
    }

    /**
     * 批量删除任务的所有评论
     */
    @SaCheckPermission("hit:project:task:comment:remove")
    @Log(title = "批量删除任务评论", businessType = BusinessType.DELETE)
    @DeleteMapping("/task/{taskId}/all")
    public R<Void> deleteTaskComments(@PathVariable Long taskId) {
        return toAjax(hitTaskCommentService.deleteCommentsByTaskId(taskId));
    }

    /**
     * 导入评论（从其他任务复制评论）
     */
    @SaCheckPermission("hit:project:task:comment:add")
    @Log(title = "导入评论", businessType = BusinessType.INSERT)
    @PostMapping("/import")
    public R<Void> importComments(@RequestParam Long sourceTaskId, @RequestParam Long targetTaskId) {
        return toAjax(hitTaskCommentService.importCommentsFromTask(sourceTaskId, targetTaskId));
    }

}
