package org.dromara.hit.project.domain.bo;

import org.dromara.hit.project.domain.HitProjectTask;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 项目任务业务对象 hit_project_task
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitProjectTask.class, reverseConvertGenerate = false)
public class HitProjectTaskBo extends BaseEntity {

    /**
     * 任务ID
     */
    @NotNull(message = "任务ID不能为空", groups = { EditGroup.class })
    private Long taskId;

    /**
     * 项目ID
     */
    @NotNull(message = "项目ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long projectId;

    /**
     * 父任务ID
     */
    private Long parentTaskId;

    /**
     * 任务名称
     */
    @NotBlank(message = "任务名称不能为空", groups = { AddGroup.class, EditGroup.class })
    @Size(max = 100, message = "任务名称长度不能超过100个字符")
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
    @Min(value = 0, message = "进度不能小于0")
    @Max(value = 100, message = "进度不能大于100")
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
    @DecimalMin(value = "0.0", message = "预估工时不能小于0")
    private BigDecimal estimatedHours;

    /**
     * 实际工时
     */
    @DecimalMin(value = "0.0", message = "实际工时不能小于0")
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
    @Size(max = 500, message = "标签长度不能超过500个字符")
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
