package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitProjectTask;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 项目任务视图对象 hit_project_task
 *
 * @author HIT-project-team
 * @date 2025-01-18
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitProjectTask.class)
public class HitProjectTaskVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
    @ExcelProperty(value = "任务ID")
    private Long taskId;

    /**
     * 项目ID
     */
    @ExcelProperty(value = "项目ID")
    private Long projectId;

    /**
     * 项目名称
     */
    @ExcelProperty(value = "项目名称")
    private String projectName;

    /**
     * 父任务ID
     */
    @ExcelProperty(value = "父任务ID")
    private Long parentTaskId;

    /**
     * 父任务名称
     */
    @ExcelProperty(value = "父任务名称")
    private String parentTaskName;

    /**
     * 任务名称
     */
    @ExcelProperty(value = "任务名称")
    private String taskName;

    /**
     * 任务描述
     */
    @ExcelProperty(value = "任务描述")
    private String taskDescription;

    /**
     * 任务类型
     */
    @ExcelProperty(value = "任务类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_task_type")
    private String taskType;

    /**
     * 优先级
     */
    @ExcelProperty(value = "优先级", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_task_priority")
    private String priority;

    /**
     * 状态
     */
    @ExcelProperty(value = "状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_task_status")
    private String status;

    /**
     * 进度百分比(0-100)
     */
    @ExcelProperty(value = "进度百分比")
    private Integer progress;

    /**
     * 负责人ID
     */
    @ExcelProperty(value = "负责人ID")
    private Long assigneeId;

    /**
     * 负责人姓名
     */
    @ExcelProperty(value = "负责人姓名")
    private String assigneeName;

    /**
     * 创建人ID
     */
    @ExcelProperty(value = "创建人ID")
    private Long creatorId;

    /**
     * 创建人姓名
     */
    @ExcelProperty(value = "创建人姓名")
    private String creatorName;

    /**
     * 预估工时
     */
    @ExcelProperty(value = "预估工时")
    private BigDecimal estimatedHours;

    /**
     * 实际工时
     */
    @ExcelProperty(value = "实际工时")
    private BigDecimal actualHours;

    /**
     * 开始日期
     */
    @ExcelProperty(value = "开始日期")
    private LocalDate startDate;

    /**
     * 截止日期
     */
    @ExcelProperty(value = "截止日期")
    private LocalDate dueDate;

    /**
     * 完成时间
     */
    @ExcelProperty(value = "完成时间")
    private LocalDateTime completedDate;

    /**
     * 依赖任务ID列表(JSON格式)
     */
    private String dependencies;

    /**
     * 标签
     */
    @ExcelProperty(value = "标签")
    private String tags;

    /**
     * 附件列表(JSON格式)
     */
    private String attachments;

    /**
     * 是否里程碑(0否 1是)
     */
    @ExcelProperty(value = "是否里程碑", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=否,1=是")
    private String isMilestone;

    /**
     * 关联用户id
     */
    private Long userId;

    /**
     * 关联部门id
     */
    private Long deptId;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    /**
     * 子任务数量
     */
    private Integer subTaskCount;

    /**
     * 评论数量
     */
    private Integer commentCount;

}
