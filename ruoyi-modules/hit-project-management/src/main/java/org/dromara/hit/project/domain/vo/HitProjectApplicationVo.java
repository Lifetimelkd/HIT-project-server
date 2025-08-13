package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitProjectApplication;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目申请视图对象 hit_project_application
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitProjectApplication.class)
public class HitProjectApplicationVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @ExcelProperty(value = "申请ID")
    private Long applicationId;

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
     * 申请人ID
     */
    @ExcelProperty(value = "申请人ID")
    private Long userId;

    /**
     * 申请人姓名
     */
    @ExcelProperty(value = "申请人姓名")
    private String userName;

    /**
     * 申请人学号
     */
    @ExcelProperty(value = "申请人学号")
    private String studentId;

    /**
     * 申请角色ID
     */
    @ExcelProperty(value = "申请角色ID")
    private Long roleId;

    /**
     * 申请角色名称
     */
    @ExcelProperty(value = "申请角色名称")
    private String roleName;

    /**
     * 申请理由
     */
    @ExcelProperty(value = "申请理由")
    private String applicationReason;

    /**
     * 自我介绍
     */
    @ExcelProperty(value = "自我介绍")
    private String selfIntroduction;

    /**
     * 相关经验
     */
    @ExcelProperty(value = "相关经验")
    private String relevantExperience;

    /**
     * 预期贡献
     */
    @ExcelProperty(value = "预期贡献")
    private String expectedContribution;

    /**
     * 可投入时间
     */
    @ExcelProperty(value = "可投入时间")
    private String availableTime;

    /**
     * 联系方式
     */
    @ExcelProperty(value = "联系方式")
    private String contactInfo;

    /**
     * 简历附件
     */
    @ExcelProperty(value = "简历附件")
    private String resumeUrl;

    /**
     * 作品集地址
     */
    @ExcelProperty(value = "作品集地址")
    private String portfolioUrl;

    /**
     * 申请状态(pending/reviewing/approved/rejected/withdrawn)
     */
    @ExcelProperty(value = "申请状态")
    private String applicationStatus;

    /**
     * 审核结果
     */
    @ExcelProperty(value = "审核结果")
    private String reviewResult;

    /**
     * 审核时间
     */
    @ExcelProperty(value = "审核时间")
    private LocalDateTime reviewTime;

    /**
     * 审核人ID
     */
    @ExcelProperty(value = "审核人ID")
    private Long reviewerId;

    /**
     * 审核人姓名
     */
    @ExcelProperty(value = "审核人姓名")
    private String reviewerName;

    /**
     * 面试时间
     */
    @ExcelProperty(value = "面试时间")
    private LocalDateTime interviewTime;

    /**
     * 面试记录
     */
    @ExcelProperty(value = "面试记录")
    private String interviewNotes;

    /**
     * 优先级评分
     */
    @ExcelProperty(value = "优先级评分")
    private BigDecimal priorityScore;

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

} 