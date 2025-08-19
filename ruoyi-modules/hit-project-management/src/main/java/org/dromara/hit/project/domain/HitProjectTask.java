package org.dromara.hit.project.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.tenant.core.TenantEntity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 项目任务对象 hit_project_task
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_project_task")
public class HitProjectTask extends TenantEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
    @TableId(value = "task_id")
    private Long taskId;

    /**
     * 项目ID
     */
    private Long projectId;

    /**
     * 父任务ID
     */
    private Long parentTaskId;

    /**
     * 任务名称
     */
    private String taskName;

    /**
     * 任务描述
     */
    private String taskDescription;

    /**
     * 任务类型(feature/bug/optimization/test)
     */
    private String taskType;

    /**
     * 优先级(low/medium/high/urgent)
     */
    private String priority;

    /**
     * 状态(todo/doing/testing/done/cancelled)
     */
    private String status;

    /**
     * 进度百分比(0-100)
     */
    private Integer progress;

    /**
     * 负责人ID
     */
    private Long assigneeId;

    /**
     * 创建人ID
     */
    private Long creatorId;

    /**
     * 预估工时
     */
    private BigDecimal estimatedHours;

    /**
     * 实际工时
     */
    private BigDecimal actualHours;

    /**
     * 开始日期
     */
    private LocalDate startDate;

    /**
     * 截止日期
     */
    private LocalDate dueDate;

    /**
     * 完成时间
     */
    private LocalDateTime completedDate;

    /**
     * 依赖任务ID列表(JSON格式)
     */
    private String dependencies;

    /**
     * 标签
     */
    private String tags;

    /**
     * 附件列表(JSON格式)
     */
    private String attachments;

    /**
     * 是否里程碑(0否 1是)
     */
    private String isMilestone;

    /**
     * 关联用户id
     */
    private Long userId;

    /**
     * 关联部门id
     */
    private Long deptId;

}
