package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitProjectTask;
import org.dromara.hit.project.domain.vo.HitProjectTaskVo;
import org.dromara.hit.project.domain.vo.TaskStatisticsVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 项目任务Mapper接口
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
public interface HitProjectTaskMapper extends BaseMapperPlus<HitProjectTask, HitProjectTaskVo> {

    /**
     * 查询任务详情（包含关联信息）
     *
     * @param taskId 任务ID
     * @return 任务详情
     */
    HitProjectTaskVo selectTaskWithDetails(@Param("taskId") Long taskId);

    /**
     * 查询项目的所有任务（包含关联信息）
     *
     * @param projectId 项目ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> selectTasksByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询用户负责的任务
     *
     * @param assigneeId 负责人ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> selectTasksByAssigneeId(@Param("assigneeId") Long assigneeId);

    /**
     * 查询用户创建的任务
     *
     * @param creatorId 创建人ID
     * @return 任务列表
     */
    List<HitProjectTaskVo> selectTasksByCreatorId(@Param("creatorId") Long creatorId);

    /**
     * 查询父任务的子任务
     *
     * @param parentTaskId 父任务ID
     * @return 子任务列表
     */
    List<HitProjectTaskVo> selectSubTasks(@Param("parentTaskId") Long parentTaskId);

    /**
     * 查询项目的里程碑任务
     *
     * @param projectId 项目ID
     * @return 里程碑任务列表
     */
    List<HitProjectTaskVo> selectMilestoneTasks(@Param("projectId") Long projectId);

    /**
     * 查询即将到期的任务
     *
     * @param days 天数
     * @return 即将到期的任务列表
     */
    List<HitProjectTaskVo> selectTasksDueSoon(@Param("days") Integer days);

    /**
     * 查询逾期的任务
     *
     * @return 逾期任务列表
     */
    List<HitProjectTaskVo> selectOverdueTasks();

    /**
     * 查询项目下可选的父任务（未过期且未完成的任务）
     *
     * @param projectId 项目ID
     * @return 可选父任务列表
     */
    List<HitProjectTaskVo> selectAvailableParentTasks(@Param("projectId") Long projectId);

    /**
     * 统计项目任务数量（按状态分组）
     *
     * @param projectId 项目ID
     * @return 统计结果
     */
    List<Object> countTasksByStatus(@Param("projectId") Long projectId);

    /**
     * 统计用户任务数量（按状态分组）
     *
     * @param userId 用户ID
     * @return 统计结果
     */
    List<Object> countUserTasksByStatus(@Param("userId") Long userId);

    /**
     * 更新任务状态
     *
     * @param taskId 任务ID
     * @param status 新状态
     * @param userId 操作用户ID
     * @return 更新结果
     */
    int updateTaskStatus(@Param("taskId") Long taskId, @Param("status") String status, @Param("userId") Long userId);

    /**
     * 更新任务进度
     *
     * @param taskId 任务ID
     * @param progress 进度
     * @param userId 操作用户ID
     * @return 更新结果
     */
    int updateTaskProgress(@Param("taskId") Long taskId, @Param("progress") Integer progress, @Param("userId") Long userId);

    /**
     * 批量更新任务负责人
     *
     * @param taskIds 任务ID列表
     * @param assigneeId 新负责人ID
     * @param userId 操作用户ID
     * @return 更新结果
     */
    int batchUpdateAssignee(@Param("taskIds") List<Long> taskIds, @Param("assigneeId") Long assigneeId, @Param("userId") Long userId);

    /**
     * 检查任务是否存在循环依赖
     *
     * @param taskId 任务ID
     * @param dependencyId 依赖任务ID
     * @return 是否存在循环依赖
     */
    boolean checkCircularDependency(@Param("taskId") Long taskId, @Param("dependencyId") Long dependencyId);

    // ==================== 统计相关方法 ====================

    /**
     * 获取任务概览统计数据
     *
     * @param projectId 项目ID（可选，为空时统计所有项目）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 概览统计数据
     */
    Map<String, Object> selectOverviewStats(@Param("projectId") String projectId,
                                           @Param("startDate") String startDate,
                                           @Param("endDate") String endDate);

    /**
     * 获取上一期间的概览统计数据（用于计算增长率）
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 上期统计数据
     */
    Map<String, Object> selectPreviousOverviewStats(@Param("projectId") String projectId,
                                                   @Param("startDate") String startDate,
                                                   @Param("endDate") String endDate);

    /**
     * 获取任务状态分布统计
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 状态分布列表
     */
    List<TaskStatisticsVo.StatusDistribution> selectStatusDistribution(@Param("projectId") String projectId,
                                                                       @Param("startDate") String startDate,
                                                                       @Param("endDate") String endDate);

    /**
     * 获取任务优先级分布统计
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 优先级分布列表
     */
    List<TaskStatisticsVo.PriorityDistribution> selectPriorityDistribution(@Param("projectId") String projectId,
                                                                           @Param("startDate") String startDate,
                                                                           @Param("endDate") String endDate);

    /**
     * 获取任务趋势统计数据
     *
     * @param projectId 项目ID（可选）
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 趋势统计数据
     */
    List<Map<String, Object>> selectTaskTrends(@Param("projectId") String projectId,
                                              @Param("startDate") String startDate,
                                              @Param("endDate") String endDate);

    /**
     * 获取项目任务统计列表
     *
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 项目统计列表
     */
    List<TaskStatisticsVo.ProjectStats> selectProjectStats(@Param("startDate") String startDate,
                                                           @Param("endDate") String endDate);

}
