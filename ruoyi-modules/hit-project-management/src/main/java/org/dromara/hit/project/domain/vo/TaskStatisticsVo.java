package org.dromara.hit.project.domain.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.util.List;

/**
 * 任务统计数据VO
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
public class TaskStatisticsVo {

    /**
     * 概览统计数据
     */
    @Data
    public static class OverviewStats {
        /**
         * 总任务数
         */
        private Integer totalTasks;

        /**
         * 已完成任务数
         */
        private Integer completedTasks;

        /**
         * 平均进度
         */
        private Double avgProgress;

        /**
         * 逾期任务数
         */
        private Integer overdueTasks;

        /**
         * 任务增长率
         */
        private Double taskGrowth;

        /**
         * 完成增长率
         */
        private Double completionGrowth;

        /**
         * 进度增长率
         */
        private Double progressGrowth;

        /**
         * 逾期率
         */
        private Double overdueRate;
    }

    /**
     * 分布统计数据
     */
    @Data
    public static class DistributionStats {
        /**
         * 状态分布
         */
        private List<StatusDistribution> statusDistribution;

        /**
         * 优先级分布
         */
        private List<PriorityDistribution> priorityDistribution;
    }

    /**
     * 状态分布
     */
    @Data
    public static class StatusDistribution {
        /**
         * 状态
         */
        private String status;

        /**
         * 状态名称
         */
        private String statusName;

        /**
         * 数量
         */
        private Integer count;
    }

    /**
     * 优先级分布
     */
    @Data
    public static class PriorityDistribution {
        /**
         * 优先级
         */
        private String priority;

        /**
         * 优先级名称
         */
        private String priorityName;

        /**
         * 数量
         */
        private Integer count;
    }

    /**
     * 趋势统计数据
     */
    @Data
    public static class TrendStats {
        /**
         * 日期列表
         */
        private List<String> dates;

        /**
         * 新建任务数量列表
         */
        private List<Integer> newTasks;

        /**
         * 完成任务数量列表
         */
        private List<Integer> completedTasks;
    }

    /**
     * 项目任务统计
     */
    @Data
    public static class ProjectStats {
        /**
         * 项目ID
         */
        private String projectId;

        /**
         * 项目名称
         */
        private String projectName;

        /**
         * 总任务数
         */
        private Integer totalTasks;

        /**
         * 已完成任务数
         */
        private Integer completedTasks;

        /**
         * 进行中任务数
         */
        private Integer inProgressTasks;

        /**
         * 待处理任务数
         */
        private Integer pendingTasks;

        /**
         * 逾期任务数
         */
        private Integer overdueTasks;

        /**
         * 完成率
         */
        private Integer completionRate;

        /**
         * 平均进度
         */
        private Integer avgProgress;
    }
} 