package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.domain.bo.HitProjectTaskBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.hit.project.domain.vo.TaskStatisticsVo;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 项目任务Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
public interface IHitProjectTaskService {

    /**
     * 查询项目任务
     */
    HitProjectTaskVo queryById(Long taskId);

    /**
     * 查询项目任务列表
     */
    TableDataInfo<HitProjectTaskVo> queryPageList(HitProjectTaskBo bo, PageQuery pageQuery);

    /**
     * 查询项目任务列表
     */
    List<HitProjectTaskVo> queryList(HitProjectTaskBo bo);

    /**
     * 新增项目任务
     */
    Boolean insertByBo(HitProjectTaskBo bo);

    /**
     * 修改项目任务
     */
    Boolean updateByBo(HitProjectTaskBo bo);

    /**
     * 校验并批量删除项目任务信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    // ==================== 业务接口 ====================

    /**
     * 查询项目的所有任务
     *
     * @param projectId 项目ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> queryTasksByProjectId(Long projectId);

    /**
     * 查询用户负责的任务
     *
     * @param assigneeId 负责人ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> queryTasksByAssigneeId(Long assigneeId);

    /**
     * 查询用户创建的任务
     *
     * @param creatorId 创建人ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> queryTasksByCreatorId(Long creatorId);

    /**
     * 查询父任务的子任务
     *
     * @param parentTaskId 父任务ID
     * @return 子任务列表
     */
    List<HitProjectTaskVo> querySubTasks(Long parentTaskId);

    /**
     * 查询项目的里程碑任务
     *
     * @param projectId 项目ID
     * @return 里程碑任务列表
     */
    List<HitProjectTaskVo> queryMilestoneTasks(Long projectId);

    /**
     * 查询即将到期的任务
     *
     * @param days 天数
     * @return 即将到期的任务列表
     */
    List<HitProjectTaskVo> queryTasksDueSoon(Integer days);

    /**
     * 查询逾期的任务
     *
     * @return 逾期任务列表
     */
    List<HitProjectTaskVo> queryOverdueTasks();

    /**
     * 查询项目下可选的父任务（未过期且未完成的任务）
     *
     * @param projectId 项目ID
     * @return 可选父任务列表
     */
    List<HitProjectTaskVo> queryAvailableParentTasks(Long projectId);

    /**
     * 更新任务状态
     *
     * @param taskId 任务ID
     * @param status 新状态
     * @return 更新结果
     */
    Boolean updateTaskStatus(Long taskId, String status);

    /**
     * 更新任务进度
     *
     * @param taskId 任务ID
     * @param progress 进度
     * @return 更新结果
     */
    Boolean updateTaskProgress(Long taskId, Integer progress);

    /**
     * 分配任务
     *
     * @param taskId 任务ID
     * @param assigneeId 负责人ID
     * @return 分配结果
     */
    Boolean assignTask(Long taskId, Long assigneeId);

    /**
     * 批量分配任务
     *
     * @param taskIds 任务ID列表
     * @param assigneeId 负责人ID
     * @return 分配结果
     */
    Boolean batchAssignTasks(List<Long> taskIds, Long assigneeId);

    /**
     * 添加任务依赖
     *
     * @param taskId 任务ID
     * @param dependencyId 依赖任务ID
     * @return 添加结果
     */
    Boolean addTaskDependency(Long taskId, Long dependencyId);

    /**
     * 移除任务依赖
     *
     * @param taskId 任务ID
     * @param dependencyId 依赖任务ID
     * @return 移除结果
     */
    Boolean removeTaskDependency(Long taskId, Long dependencyId);

    /**
     * 统计项目任务数量（按状态分组）
     *
     * @param projectId 项目ID
     * @return 统计结果
     */
    Map<String, Object> countTasksByStatus(Long projectId);

    /**
     * 统计用户任务数量（按状态分组）
     *
     * @param userId 用户ID
     * @return 统计结果
     */
    Map<String, Object> countUserTasksByStatus(Long userId);

    /**
     * 获取任务看板数据
     *
     * @param projectId 项目ID
     * @return 看板数据
     */
    Map<String, List<HitProjectTaskVo>> getTaskKanbanData(Long projectId);

    /**
     * 获取任务甘特图数据
     *
     * @param projectId 项目ID
     * @return 甘特图数据
     */
    List<Map<String, Object>> getTaskGanttData(Long projectId);

    /**
     * 复制任务
     *
     * @param taskId 原任务ID
     * @param newTaskName 新任务名称
     * @return 复制结果
     */
    Boolean copyTask(Long taskId, String newTaskName);

    /**
     * 归档任务
     *
     * @param taskId 任务ID
     * @return 归档结果
     */
    Boolean archiveTask(Long taskId);

    // ==================== 统计相关方法 ====================

    /**
     * 获取任务概览统计数据
     *
     * @param projectId 项目ID（可选，为空时统计所有项目）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 概览统计数据
     */
    TaskStatisticsVo.OverviewStats getOverviewStats(String projectId, String startDate, String endDate);

    /**
     * 获取任务分布统计数据
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 分布统计数据
     */
    TaskStatisticsVo.DistributionStats getDistributionStats(String projectId, String startDate, String endDate);

    /**
     * 获取任务趋势统计数据
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 趋势统计数据
     */
    TaskStatisticsVo.TrendStats getTrendStats(String projectId, String startDate, String endDate);

    /**
     * 获取项目任务统计列表
     *
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 项目统计列表
     */
    List<TaskStatisticsVo.ProjectStats> getProjectStats(String startDate, String endDate);

}
