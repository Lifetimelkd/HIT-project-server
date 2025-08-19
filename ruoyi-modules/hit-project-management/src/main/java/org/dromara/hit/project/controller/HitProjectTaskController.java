package org.dromara.hit.project.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

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
import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.domain.vo.TaskStatisticsVo;
import org.dromara.hit.project.domain.bo.HitProjectTaskBo;
import org.dromara.hit.project.service.IHitProjectTaskService;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.satoken.utils.LoginHelper;

/**
 * 项目任务
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project/task")
public class HitProjectTaskController extends BaseController {

    private final IHitProjectTaskService hitProjectTaskService;

    /**
     * 查询项目任务列表
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/list")
    public TableDataInfo<HitProjectTaskVo> list(HitProjectTaskBo bo, PageQuery pageQuery) {
        return hitProjectTaskService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出项目任务列表
     */
    @SaCheckPermission("hit:project:task:export")
    @Log(title = "项目任务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitProjectTaskBo bo, HttpServletResponse response) {
        List<HitProjectTaskVo> list = hitProjectTaskService.queryList(bo);
        ExcelUtil.exportExcel(list, "项目任务", HitProjectTaskVo.class, response);
    }

    /**
     * 获取项目任务详细信息
     */
    @SaCheckPermission("hit:project:task:query")
    @GetMapping("/{taskId}")
    public R<HitProjectTaskVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long taskId) {
        return R.ok(hitProjectTaskService.queryById(taskId));
    }

    /**
     * 新增项目任务
     */
    @SaCheckPermission("hit:project:task:add")
    @Log(title = "项目任务", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitProjectTaskBo bo) {
        return toAjax(hitProjectTaskService.insertByBo(bo));
    }

    /**
     * 修改项目任务
     */
    @SaCheckPermission("hit:project:task:edit")
    @Log(title = "项目任务", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitProjectTaskBo bo) {
        return toAjax(hitProjectTaskService.updateByBo(bo));
    }

    /**
     * 删除项目任务
     */
    @SaCheckPermission("hit:project:task:remove")
    @Log(title = "项目任务", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] taskIds) {
        return toAjax(hitProjectTaskService.deleteWithValidByIds(List.of(taskIds), true));
    }

    // ==================== 业务接口 ====================

    /**
     * 查询项目的所有任务
     */
    @GetMapping("/project/{projectId}")
    public R<List<HitProjectTaskVo>> getProjectTasks(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.queryTasksByProjectId(projectId));
    }

    /**
     * 查询用户负责的任务
     */
    @GetMapping("/my/assigned")
    public R<List<HitProjectTaskVo>> getMyAssignedTasks() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitProjectTaskService.queryTasksByAssigneeId(userId));
    }

    /**
     * 查询用户创建的任务
     */
    @GetMapping("/my/created")
    public R<List<HitProjectTaskVo>> getMyCreatedTasks() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitProjectTaskService.queryTasksByCreatorId(userId));
    }

    /**
     * 查询父任务的子任务
     */
    @GetMapping("/{parentTaskId}/subtasks")
    public R<List<HitProjectTaskVo>> getSubTasks(@PathVariable Long parentTaskId) {
        return R.ok(hitProjectTaskService.querySubTasks(parentTaskId));
    }

    /**
     * 查询项目的里程碑任务
     */
    @GetMapping("/project/{projectId}/milestones")
    public R<List<HitProjectTaskVo>> getMilestoneTasks(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.queryMilestoneTasks(projectId));
    }

    /**
     * 查询即将到期的任务
     */
    @GetMapping("/due-soon")
    public R<List<HitProjectTaskVo>> getTasksDueSoon(@RequestParam(defaultValue = "7") Integer days) {
        return R.ok(hitProjectTaskService.queryTasksDueSoon(days));
    }

    /**
     * 查询逾期的任务
     */
    @GetMapping("/overdue")
    public R<List<HitProjectTaskVo>> getOverdueTasks() {
        return R.ok(hitProjectTaskService.queryOverdueTasks());
    }

    /**
     * 更新任务状态
     */
    @SaCheckPermission("hit:project:task:edit")
    @Log(title = "更新任务状态", businessType = BusinessType.UPDATE)
    @PutMapping("/{taskId}/status")
    public R<Void> updateTaskStatus(@PathVariable Long taskId, @RequestParam String status) {
        return toAjax(hitProjectTaskService.updateTaskStatus(taskId, status));
    }

    /**
     * 更新任务进度
     */
    @SaCheckPermission("hit:project:task:edit")
    @Log(title = "更新任务进度", businessType = BusinessType.UPDATE)
    @PutMapping("/{taskId}/progress")
    public R<Void> updateTaskProgress(@PathVariable Long taskId, @RequestParam Integer progress) {
        return toAjax(hitProjectTaskService.updateTaskProgress(taskId, progress));
    }

    /**
     * 分配任务
     */
    @SaCheckPermission("hit:project:task:assign")
    @Log(title = "分配任务", businessType = BusinessType.UPDATE)
    @PutMapping("/{taskId}/assign")
    public R<Void> assignTask(@PathVariable Long taskId, @RequestParam Long assigneeId) {
        return toAjax(hitProjectTaskService.assignTask(taskId, assigneeId));
    }

    /**
     * 批量分配任务
     */
    @SaCheckPermission("hit:project:task:assign")
    @Log(title = "批量分配任务", businessType = BusinessType.UPDATE)
    @PutMapping("/batch/assign")
    public R<Void> batchAssignTasks(@RequestBody List<Long> taskIds, @RequestParam Long assigneeId) {
        return toAjax(hitProjectTaskService.batchAssignTasks(taskIds, assigneeId));
    }

    /**
     * 添加任务依赖
     */
    @SaCheckPermission("hit:project:task:edit")
    @Log(title = "添加任务依赖", businessType = BusinessType.UPDATE)
    @PostMapping("/{taskId}/dependency")
    public R<Void> addTaskDependency(@PathVariable Long taskId, @RequestParam Long dependencyId) {
        return toAjax(hitProjectTaskService.addTaskDependency(taskId, dependencyId));
    }

    /**
     * 移除任务依赖
     */
    @SaCheckPermission("hit:project:task:edit")
    @Log(title = "移除任务依赖", businessType = BusinessType.UPDATE)
    @DeleteMapping("/{taskId}/dependency")
    public R<Void> removeTaskDependency(@PathVariable Long taskId, @RequestParam Long dependencyId) {
        return toAjax(hitProjectTaskService.removeTaskDependency(taskId, dependencyId));
    }

    /**
     * 统计项目任务数量（按状态分组）
     */
    @GetMapping("/project/{projectId}/stats")
    public R<Map<String, Object>> getProjectTaskStats(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.countTasksByStatus(projectId));
    }

    /**
     * 统计用户任务数量（按状态分组）
     */
    @GetMapping("/my/stats")
    public R<Map<String, Object>> getMyTaskStats() {
        Long userId = LoginHelper.getUserId();
        return R.ok(hitProjectTaskService.countUserTasksByStatus(userId));
    }

    /**
     * 获取任务看板数据
     */
    @GetMapping("/project/{projectId}/kanban")
    public R<Map<String, List<HitProjectTaskVo>>> getTaskKanbanData(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.getTaskKanbanData(projectId));
    }

    /**
     * 获取任务甘特图数据
     */
    @GetMapping("/project/{projectId}/gantt")
    public R<List<Map<String, Object>>> getTaskGanttData(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.getTaskGanttData(projectId));
    }

    /**
     * 获取项目下可选的父任务（未过期且未完成的任务）
     */
    @GetMapping("/project/{projectId}/available-parent-tasks")
    public R<List<HitProjectTaskVo>> getAvailableParentTasks(@PathVariable Long projectId) {
        return R.ok(hitProjectTaskService.queryAvailableParentTasks(projectId));
    }

    /**
     * 复制任务
     */
    @SaCheckPermission("hit:project:task:add")
    @Log(title = "复制任务", businessType = BusinessType.INSERT)
    @PostMapping("/{taskId}/copy")
    public R<Void> copyTask(@PathVariable Long taskId, @RequestParam String newTaskName) {
        return toAjax(hitProjectTaskService.copyTask(taskId, newTaskName));
    }

    /**
     * 归档任务
     */
    @SaCheckPermission("hit:project:task:remove")
    @Log(title = "归档任务", businessType = BusinessType.DELETE)
    @PostMapping("/{taskId}/archive")
    public R<Void> archiveTask(@PathVariable Long taskId) {
        return toAjax(hitProjectTaskService.archiveTask(taskId));
    }

    // ==================== 统计相关接口 ====================

    /**
     * 获取任务概览统计数据
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/statistics/overview")
    public R<TaskStatisticsVo.OverviewStats> getTaskOverviewStats(
            @RequestParam(required = false) String projectId,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        TaskStatisticsVo.OverviewStats stats = hitProjectTaskService.getOverviewStats(projectId, startDate, endDate);
        return R.ok(stats);
    }

    /**
     * 获取任务分布统计数据
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/statistics/distribution")
    public R<TaskStatisticsVo.DistributionStats> getTaskDistributionStats(
            @RequestParam(required = false) String projectId,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        TaskStatisticsVo.DistributionStats stats = hitProjectTaskService.getDistributionStats(projectId, startDate, endDate);
        return R.ok(stats);
    }

    /**
     * 获取任务趋势统计数据
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/statistics/trends")
    public R<TaskStatisticsVo.TrendStats> getTaskTrendStats(
            @RequestParam(required = false) String projectId,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        TaskStatisticsVo.TrendStats stats = hitProjectTaskService.getTrendStats(projectId, startDate, endDate);
        return R.ok(stats);
    }

    /**
     * 获取项目任务统计列表
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/statistics/projects")
    public R<List<TaskStatisticsVo.ProjectStats>> getProjectTaskStats(
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        List<TaskStatisticsVo.ProjectStats> stats = hitProjectTaskService.getProjectStats(startDate, endDate);
        return R.ok(stats);
    }

    /**
     * 调试接口：查看任务基本信息
     */
    @SaCheckPermission("hit:project:task:list")
    @GetMapping("/debug/tasks")
    public R<List<Map<String, Object>>> debugTasks() {
        // 直接查询任务表中的基本信息
        List<Map<String, Object>> tasks = hitProjectTaskService.queryList(new HitProjectTaskBo())
            .stream()
            .map(task -> {
                Map<String, Object> map = new HashMap<>();
                map.put("taskId", task.getTaskId());
                map.put("projectId", task.getProjectId());
                map.put("taskName", task.getTaskName());
                map.put("status", task.getStatus());
                map.put("createTime", task.getCreateTime());
                map.put("completedDate", task.getCompletedDate());
                return map;
            })
            .collect(java.util.stream.Collectors.toList());
        return R.ok(tasks);
    }

}
