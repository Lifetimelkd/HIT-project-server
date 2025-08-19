package org.dromara.hit.project.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.hit.project.domain.bo.HitProjectTaskBo;
import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.domain.vo.TaskStatisticsVo;
import org.dromara.hit.project.domain.HitProjectTask;
import org.dromara.hit.project.mapper.HitProjectTaskMapper;
import org.dromara.hit.project.service.IHitProjectTaskService;
import org.dromara.hit.project.service.IHitProjectMemberService;
import org.dromara.hit.notification.service.IHitNotificationService;
import org.dromara.hit.project.utils.TaskNotificationUtils;
import org.dromara.common.satoken.utils.LoginHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 项目任务Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@RequiredArgsConstructor
@Service
public class HitProjectTaskServiceImpl implements IHitProjectTaskService {

    private final HitProjectTaskMapper baseMapper;
    private final IHitNotificationService notificationService;
    private final IHitProjectMemberService memberService;
    private final TaskNotificationUtils taskNotificationUtils;
    private final ObjectMapper objectMapper;

    /**
     * 查询项目任务
     */
    @Override
    public HitProjectTaskVo queryById(Long taskId) {
        return baseMapper.selectTaskWithDetails(taskId);
    }

    /**
     * 查询项目任务列表
     */
    @Override
    public TableDataInfo<HitProjectTaskVo> queryPageList(HitProjectTaskBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitProjectTask> lqw = buildQueryWrapper(bo);
        Page<HitProjectTaskVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询项目任务列表
     */
    @Override
    public List<HitProjectTaskVo> queryList(HitProjectTaskBo bo) {
        LambdaQueryWrapper<HitProjectTask> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitProjectTask> buildQueryWrapper(HitProjectTaskBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitProjectTask> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getProjectId() != null, HitProjectTask::getProjectId, bo.getProjectId());
        lqw.eq(bo.getParentTaskId() != null, HitProjectTask::getParentTaskId, bo.getParentTaskId());
        lqw.like(StringUtils.isNotBlank(bo.getTaskName()), HitProjectTask::getTaskName, bo.getTaskName());
        lqw.eq(StringUtils.isNotBlank(bo.getTaskType()), HitProjectTask::getTaskType, bo.getTaskType());
        lqw.eq(StringUtils.isNotBlank(bo.getPriority()), HitProjectTask::getPriority, bo.getPriority());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitProjectTask::getStatus, bo.getStatus());
        lqw.eq(bo.getAssigneeId() != null, HitProjectTask::getAssigneeId, bo.getAssigneeId());
        lqw.eq(bo.getCreatorId() != null, HitProjectTask::getCreatorId, bo.getCreatorId());
        lqw.eq(StringUtils.isNotBlank(bo.getIsMilestone()), HitProjectTask::getIsMilestone, bo.getIsMilestone());
        lqw.between(params.get("beginStartDate") != null && params.get("endStartDate") != null,
            HitProjectTask::getStartDate, params.get("beginStartDate"), params.get("endStartDate"));
        lqw.between(params.get("beginDueDate") != null && params.get("endDueDate") != null,
            HitProjectTask::getDueDate, params.get("beginDueDate"), params.get("endDueDate"));
        lqw.orderByDesc(HitProjectTask::getCreateTime);
        return lqw;
    }

    /**
     * 新增项目任务
     */
    @Override
    public Boolean insertByBo(HitProjectTaskBo bo) {
        HitProjectTask add = MapstructUtils.convert(bo, HitProjectTask.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setTaskId(add.getTaskId());
            // 发送任务创建通知
            taskNotificationUtils.sendTaskCreatedNotification(add.getTaskId());
        }
        return flag;
    }

    /**
     * 修改项目任务
     */
    @Override
    public Boolean updateByBo(HitProjectTaskBo bo) {
        HitProjectTask update = MapstructUtils.convert(bo, HitProjectTask.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;
        if (flag) {
            // 发送任务更新通知
            // 这里可以根据需要添加特定的更新通知逻辑
            // taskNotificationUtils.sendTaskUpdatedNotification(update.getTaskId());
        }
        return flag;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitProjectTask entity) {
        // 权限验证：确保用户只能在自己参与的项目下创建任务
        Long currentUserId = LoginHelper.getUserId();
        if (entity.getProjectId() != null) {
            // 检查用户是否为项目成员
            boolean isProjectMember = memberService.isProjectMember(entity.getProjectId(), currentUserId);
            if (!isProjectMember) {
                throw new RuntimeException("您没有在该项目下创建任务的权限");
            }
        }
        
        // 设置默认值
        if (StringUtils.isBlank(entity.getTaskType())) {
            entity.setTaskType("feature");
        }
        if (StringUtils.isBlank(entity.getPriority())) {
            entity.setPriority("medium");
        }
        if (StringUtils.isBlank(entity.getStatus())) {
            entity.setStatus("todo");
        }
        if (entity.getProgress() == null) {
            entity.setProgress(0);
        }
        if (StringUtils.isBlank(entity.getIsMilestone())) {
            entity.setIsMilestone("0");
        }
        if (entity.getCreatorId() == null) {
            entity.setCreatorId(LoginHelper.getUserId());
        }
    }

    /**
     * 批量删除项目任务
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 可以添加删除前的业务校验
        }
        boolean flag = baseMapper.deleteBatchIds(ids) > 0;
        if (flag) {
            // 发送任务删除通知
            // 删除操作通常不需要发送通知，因为任务已经不存在了
            // 如果需要可以在删除前发送通知
        }
        return flag;
    }

    // ==================== 业务接口实现 ====================

    @Override
    public List<HitProjectTaskVo> queryTasksByProjectId(Long projectId) {
        return baseMapper.selectTasksByProjectId(projectId);
    }

    @Override
    public List<HitProjectTaskVo> queryTasksByAssigneeId(Long assigneeId) {
        return baseMapper.selectTasksByAssigneeId(assigneeId);
    }

    @Override
    public List<HitProjectTaskVo> queryTasksByCreatorId(Long creatorId) {
        return baseMapper.selectTasksByCreatorId(creatorId);
    }

    @Override
    public List<HitProjectTaskVo> querySubTasks(Long parentTaskId) {
        return baseMapper.selectSubTasks(parentTaskId);
    }

    @Override
    public List<HitProjectTaskVo> queryMilestoneTasks(Long projectId) {
        return baseMapper.selectMilestoneTasks(projectId);
    }

    @Override
    public List<HitProjectTaskVo> queryTasksDueSoon(Integer days) {
        return baseMapper.selectTasksDueSoon(days);
    }

    @Override
    public List<HitProjectTaskVo> queryOverdueTasks() {
        return baseMapper.selectOverdueTasks();
    }

    @Override
    public List<HitProjectTaskVo> queryAvailableParentTasks(Long projectId) {
        return baseMapper.selectAvailableParentTasks(projectId);
    }

    @Override
    public Boolean updateTaskStatus(Long taskId, String status) {
        // 获取原状态
        HitProjectTaskVo task = queryById(taskId);
        String oldStatus = task != null ? task.getStatus() : null;

        Long userId = LoginHelper.getUserId();
        boolean flag = baseMapper.updateTaskStatus(taskId, status, userId) > 0;
        if (flag) {
            // 发送状态变更通知
            taskNotificationUtils.sendTaskStatusChangedNotification(taskId, status, oldStatus);
        }
        return flag;
    }

    @Override
    public Boolean updateTaskProgress(Long taskId, Integer progress) {
        // 获取原进度
        HitProjectTaskVo task = queryById(taskId);
        Integer oldProgress = task != null ? task.getProgress() : null;

        Long userId = LoginHelper.getUserId();
        boolean flag = baseMapper.updateTaskProgress(taskId, progress, userId) > 0;
        if (flag) {
            // 发送进度更新通知
            taskNotificationUtils.sendTaskProgressUpdatedNotification(taskId, progress, oldProgress);
        }
        return flag;
    }

    @Override
    public Boolean assignTask(Long taskId, Long assigneeId) {
        return batchAssignTasks(Arrays.asList(taskId), assigneeId);
    }

    @Override
    public Boolean batchAssignTasks(List<Long> taskIds, Long assigneeId) {
        // 获取原负责人信息
        Map<Long, Long> oldAssignees = new HashMap<>();
        for (Long taskId : taskIds) {
            HitProjectTaskVo task = queryById(taskId);
            if (task != null) {
                oldAssignees.put(taskId, task.getAssigneeId());
            }
        }

        Long userId = LoginHelper.getUserId();
        boolean flag = baseMapper.batchUpdateAssignee(taskIds, assigneeId, userId) > 0;
        if (flag) {
            // 发送任务分配通知
            for (Long taskId : taskIds) {
                Long oldAssigneeId = oldAssignees.get(taskId);
                taskNotificationUtils.sendTaskAssignedNotification(taskId, assigneeId, oldAssigneeId);
            }
        }
        return flag;
    }



    /**
     * 获取状态标签
     */
    private String getStatusLabel(String status) {
        switch (status) {
            case "todo": return "待开始";
            case "doing": return "进行中";
            case "testing": return "测试中";
            case "done": return "已完成";
            case "cancelled": return "已取消";
            default: return status;
        }
    }

    @Override
    public Boolean addTaskDependency(Long taskId, Long dependencyId) {
        // 检查循环依赖
        if (baseMapper.checkCircularDependency(taskId, dependencyId)) {
            throw new RuntimeException("添加依赖会造成循环依赖，操作失败");
        }

        try {
            HitProjectTask task = baseMapper.selectById(taskId);
            if (task != null) {
                List<Long> dependencies = parseDependencies(task.getDependencies());
                if (!dependencies.contains(dependencyId)) {
                    dependencies.add(dependencyId);
                    task.setDependencies(objectMapper.writeValueAsString(dependencies));
                    return baseMapper.updateById(task) > 0;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("添加任务依赖失败: " + e.getMessage());
        }
        return false;
    }

    @Override
    public Boolean removeTaskDependency(Long taskId, Long dependencyId) {
        try {
            HitProjectTask task = baseMapper.selectById(taskId);
            if (task != null) {
                List<Long> dependencies = parseDependencies(task.getDependencies());
                if (dependencies.remove(dependencyId)) {
                    task.setDependencies(objectMapper.writeValueAsString(dependencies));
                    return baseMapper.updateById(task) > 0;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("移除任务依赖失败: " + e.getMessage());
        }
        return false;
    }

    @Override
    public Map<String, Object> countTasksByStatus(Long projectId) {
        List<Object> results = baseMapper.countTasksByStatus(projectId);
        Map<String, Object> statusCount = new HashMap<>();
        for (Object result : results) {
            if (result instanceof Map) {
                Map<String, Object> map = (Map<String, Object>) result;
                statusCount.put((String) map.get("status"), map.get("count"));
            }
        }
        return statusCount;
    }

    @Override
    public Map<String, Object> countUserTasksByStatus(Long userId) {
        List<Object> results = baseMapper.countUserTasksByStatus(userId);
        Map<String, Object> statusCount = new HashMap<>();
        for (Object result : results) {
            if (result instanceof Map) {
                Map<String, Object> map = (Map<String, Object>) result;
                statusCount.put((String) map.get("status"), map.get("count"));
            }
        }
        return statusCount;
    }

    @Override
    public Map<String, List<HitProjectTaskVo>> getTaskKanbanData(Long projectId) {
        List<HitProjectTaskVo> tasks = queryTasksByProjectId(projectId);
        return tasks.stream().collect(Collectors.groupingBy(HitProjectTaskVo::getStatus));
    }

    @Override
    public List<Map<String, Object>> getTaskGanttData(Long projectId) {
        List<HitProjectTaskVo> tasks = queryTasksByProjectId(projectId);
        List<Map<String, Object>> ganttData = new ArrayList<>();

        for (HitProjectTaskVo task : tasks) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", task.getTaskId());
            item.put("text", task.getTaskName());
            item.put("start_date", task.getStartDate());
            item.put("duration", calculateDuration(task.getStartDate(), task.getDueDate()));
            item.put("progress", task.getProgress() / 100.0);
            item.put("parent", task.getParentTaskId() == null ? 0 : task.getParentTaskId());
            ganttData.add(item);
        }

        return ganttData;
    }

    @Override
    public Boolean copyTask(Long taskId, String newTaskName) {
        try {
            HitProjectTask originalTask = baseMapper.selectById(taskId);
            if (originalTask != null) {
                HitProjectTask newTask = new HitProjectTask();
                // 复制任务属性
                newTask.setProjectId(originalTask.getProjectId());
                newTask.setParentTaskId(originalTask.getParentTaskId());
                newTask.setTaskName(newTaskName);
                newTask.setTaskDescription(originalTask.getTaskDescription());
                newTask.setTaskType(originalTask.getTaskType());
                newTask.setPriority(originalTask.getPriority());
                newTask.setStatus("todo"); // 新任务状态为待开始
                newTask.setProgress(0); // 新任务进度为0
                newTask.setCreatorId(LoginHelper.getUserId());
                newTask.setEstimatedHours(originalTask.getEstimatedHours());
                newTask.setStartDate(originalTask.getStartDate());
                newTask.setDueDate(originalTask.getDueDate());
                newTask.setTags(originalTask.getTags());
                newTask.setIsMilestone(originalTask.getIsMilestone());

                return baseMapper.insert(newTask) > 0;
            }
        } catch (Exception e) {
            throw new RuntimeException("复制任务失败: " + e.getMessage());
        }
        return false;
    }

    @Override
    public Boolean archiveTask(Long taskId) {
        // 这里可以实现任务归档逻辑，比如移动到归档表或标记为归档状态
        // 暂时使用软删除的方式
        return baseMapper.deleteById(taskId) > 0;
    }

    /**
     * 解析依赖任务ID列表
     */
    private List<Long> parseDependencies(String dependencies) {
        if (StringUtils.isBlank(dependencies)) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(dependencies, new TypeReference<List<Long>>() {});
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    /**
     * 计算任务持续时间
     */
    private int calculateDuration(java.time.LocalDate startDate, java.time.LocalDate dueDate) {
        if (startDate == null || dueDate == null) {
            return 0;
        }
        return (int) java.time.temporal.ChronoUnit.DAYS.between(startDate, dueDate) + 1;
    }

    // ==================== 统计相关方法实现 ====================

    @Override
    public TaskStatisticsVo.OverviewStats getOverviewStats(String projectId, String startDate, String endDate) {
        // 获取当前期间统计数据
        Map<String, Object> currentStats = baseMapper.selectOverviewStats(projectId, startDate, endDate);
        
        // 获取上一期间统计数据用于计算增长率
        Map<String, Object> previousStats = null;
        if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
            // 计算上一个相同时间段
            LocalDate start = LocalDate.parse(startDate);
            LocalDate end = LocalDate.parse(endDate);
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(start, end);
            LocalDate prevStart = start.minusDays(daysBetween + 1);
            LocalDate prevEnd = start.minusDays(1);
            
            previousStats = baseMapper.selectPreviousOverviewStats(projectId, 
                prevStart.toString(), prevEnd.toString());
        }
        
        TaskStatisticsVo.OverviewStats overview = new TaskStatisticsVo.OverviewStats();
        
        // 设置当前统计数据
        overview.setTotalTasks(getIntValue(currentStats, "totalTasks", 0));
        overview.setCompletedTasks(getIntValue(currentStats, "completedTasks", 0));
        overview.setAvgProgress(getDoubleValue(currentStats, "avgProgress", 0.0));
        overview.setOverdueTasks(getIntValue(currentStats, "overdueTasks", 0));
        
        // 计算增长率
        if (previousStats != null) {
            overview.setTaskGrowth(calculateGrowthRateDouble(
                getIntValue(currentStats, "totalTasks", 0),
                getIntValue(previousStats, "totalTasks", 0)
            ));
            overview.setCompletionGrowth(calculateGrowthRateDouble(
                getIntValue(currentStats, "completedTasks", 0),
                getIntValue(previousStats, "completedTasks", 0)
            ));
            overview.setProgressGrowth(calculateGrowthRateDouble(
                getDoubleValue(currentStats, "avgProgress", 0.0),
                getDoubleValue(previousStats, "avgProgress", 0.0)
            ));
        } else {
            overview.setTaskGrowth(0.0);
            overview.setCompletionGrowth(0.0);
            overview.setProgressGrowth(0.0);
        }
        
        // 计算逾期率
        int totalTasks = overview.getTotalTasks();
        if (totalTasks > 0) {
            overview.setOverdueRate(
                Math.round((double) overview.getOverdueTasks() * 100.0 / totalTasks * 100.0) / 100.0
            );
        } else {
            overview.setOverdueRate(0.0);
        }
        
        return overview;
    }

    @Override
    public TaskStatisticsVo.DistributionStats getDistributionStats(String projectId, String startDate, String endDate) {
        TaskStatisticsVo.DistributionStats distribution = new TaskStatisticsVo.DistributionStats();
        
        // 获取状态分布
        List<TaskStatisticsVo.StatusDistribution> statusList = baseMapper.selectStatusDistribution(projectId, startDate, endDate);
        // 添加状态名称映射
        statusList.forEach(status -> {
            status.setStatusName(getStatusName(status.getStatus()));
        });
        distribution.setStatusDistribution(statusList);
        
        // 获取优先级分布
        List<TaskStatisticsVo.PriorityDistribution> priorityList = baseMapper.selectPriorityDistribution(projectId, startDate, endDate);
        // 添加优先级名称映射
        priorityList.forEach(priority -> {
            priority.setPriorityName(getPriorityName(priority.getPriority()));
        });
        distribution.setPriorityDistribution(priorityList);
        
        return distribution;
    }

    @Override
    public TaskStatisticsVo.TrendStats getTrendStats(String projectId, String startDate, String endDate) {
        System.out.println("=== 趋势统计查询参数 ===");
        System.out.println("projectId: " + projectId);
        System.out.println("startDate: " + startDate);
        System.out.println("endDate: " + endDate);
        
        List<Map<String, Object>> trendData = baseMapper.selectTaskTrends(projectId, startDate, endDate);
        
        System.out.println("=== 查询结果 ===");
        System.out.println("trendData size: " + (trendData != null ? trendData.size() : "null"));
        if (trendData != null) {
            for (Map<String, Object> data : trendData) {
                System.out.println("趋势数据: " + data);
            }
        }
        
        TaskStatisticsVo.TrendStats trends = new TaskStatisticsVo.TrendStats();
        
        List<String> dates = new ArrayList<>();
        List<Integer> newTasks = new ArrayList<>();
        List<Integer> completedTasks = new ArrayList<>();
        
        if (trendData != null) {
            for (Map<String, Object> data : trendData) {
                dates.add(getString(data, "date", ""));
                newTasks.add(getIntValue(data, "newTasks", 0));
                completedTasks.add(getIntValue(data, "completedTasks", 0));
            }
        }
        
        trends.setDates(dates);
        trends.setNewTasks(newTasks);
        trends.setCompletedTasks(completedTasks);
        
        System.out.println("=== 最终结果 ===");
        System.out.println("dates: " + dates);
        System.out.println("newTasks: " + newTasks);
        System.out.println("completedTasks: " + completedTasks);
        
        return trends;
    }

    @Override
    public List<TaskStatisticsVo.ProjectStats> getProjectStats(String startDate, String endDate) {
        return baseMapper.selectProjectStats(startDate, endDate);
    }

    // ==================== 辅助方法 ====================

    private int getIntValue(Map<String, Object> map, String key, int defaultValue) {
        Object value = map.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        try {
            return Integer.parseInt(value.toString());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private BigDecimal getBigDecimalValue(Map<String, Object> map, String key, BigDecimal defaultValue) {
        Object value = map.get(key);
        if (value == null) return defaultValue;
        if (value instanceof BigDecimal) {
            return (BigDecimal) value;
        }
        if (value instanceof Number) {
            return BigDecimal.valueOf(((Number) value).doubleValue());
        }
        try {
            return new BigDecimal(value.toString());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private String getString(Map<String, Object> map, String key, String defaultValue) {
        Object value = map.get(key);
        return value != null ? value.toString() : defaultValue;
    }

    private BigDecimal calculateGrowthRate(Number current, Number previous) {
        if (previous == null || previous.doubleValue() == 0) {
            return current != null && current.doubleValue() > 0 ? BigDecimal.valueOf(100) : BigDecimal.ZERO;
        }
        
        double currentVal = current != null ? current.doubleValue() : 0;
        double previousVal = previous.doubleValue();
        
        return BigDecimal.valueOf((currentVal - previousVal) / previousVal * 100)
            .setScale(2, RoundingMode.HALF_UP);
    }

    private BigDecimal calculateGrowthRate(BigDecimal current, BigDecimal previous) {
        if (previous == null || previous.compareTo(BigDecimal.ZERO) == 0) {
            return current != null && current.compareTo(BigDecimal.ZERO) > 0 ? BigDecimal.valueOf(100) : BigDecimal.ZERO;
        }
        
        BigDecimal currentVal = current != null ? current : BigDecimal.ZERO;
        
        return currentVal.subtract(previous)
            .divide(previous, 4, RoundingMode.HALF_UP)
            .multiply(BigDecimal.valueOf(100))
            .setScale(2, RoundingMode.HALF_UP);
    }

    private String getStatusName(String status) {
        switch (status) {
            case "todo": return "待处理";
            case "doing": return "进行中";
            case "testing": return "测试中";
            case "done": return "已完成";
            case "cancelled": return "已取消";
            default: return status;
        }
    }

    private String getPriorityName(String priority) {
        switch (priority) {
            case "low": return "低优先级";
            case "medium": return "中优先级";
            case "high": return "高优先级";
            case "urgent": return "紧急";
            default: return priority;
        }
    }

    private double getDoubleValue(Map<String, Object> map, String key, double defaultValue) {
        Object value = map.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        }
        try {
            return Double.parseDouble(value.toString());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private double calculateGrowthRateDouble(Number current, Number previous) {
        if (previous == null || previous.doubleValue() == 0) {
            return current != null && current.doubleValue() > 0 ? 100.0 : 0.0;
        }
        
        double currentVal = current != null ? current.doubleValue() : 0;
        double previousVal = previous.doubleValue();
        
        return (currentVal - previousVal) / previousVal * 100;
    }
}
