package org.dromara.hit.project.domain.bo;

import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.hit.project.domain.HitProjectApplication;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目申请业务对象 hit_project_application
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitProjectApplication.class, reverseConvertGenerate = false)
public class HitProjectApplicationBo extends BaseEntity {

    /**
     * 申请ID
     */
    @NotNull(message = "申请ID不能为空", groups = { EditGroup.class })
    private Long applicationId;

    /**
     * 项目ID
     */
    @NotNull(message = "项目ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long projectId;

    /**
     * 申请人ID
     */
    private Long userId;

    /**
     * 申请角色ID
     */
    private Long roleId;

    /**
     * 申请理由
     */
    @NotBlank(message = "申请理由不能为空", groups = { AddGroup.class })
    @Size(max = 2000, message = "申请理由长度不能超过2000个字符")
    private String applicationReason;

    /**
     * 自我介绍
     */
    @Size(max = 2000, message = "自我介绍长度不能超过2000个字符")
    private String selfIntroduction;

    /**
     * 相关经验
     */
    @Size(max = 2000, message = "相关经验长度不能超过2000个字符")
    private String relevantExperience;

    /**
     * 预期贡献
     */
    @Size(max = 2000, message = "预期贡献长度不能超过2000个字符")
    private String expectedContribution;

    /**
     * 可投入时间
     */
    @Size(max = 200, message = "可投入时间长度不能超过200个字符")
    private String availableTime;

    /**
     * 联系方式
     */
    @Size(max = 200, message = "联系方式长度不能超过200个字符")
    private String contactInfo;

    /**
     * 简历附件
     */
    @Size(max = 500, message = "简历附件地址长度不能超过500个字符")
    private String resumeUrl;

    /**
     * 作品集地址
     */
    @Size(max = 500, message = "作品集地址长度不能超过500个字符")
    private String portfolioUrl;

    /**
     * 申请状态(pending/reviewing/approved/rejected/withdrawn)
     */
    private String applicationStatus;

    /**
     * 审核结果
     */
    @Size(max = 2000, message = "审核结果长度不能超过2000个字符")
    private String reviewResult;

    /**
     * 审核时间
     */
    private LocalDateTime reviewTime;

    /**
     * 审核人ID
     */
    private Long reviewerId;

    /**
     * 面试时间
     */
    private LocalDateTime interviewTime;

    /**
     * 面试记录
     */
    @Size(max = 2000, message = "面试记录长度不能超过2000个字符")
    private String interviewNotes;

    /**
     * 优先级评分
     */
    @DecimalMin(value = "0.00", message = "优先级评分不能小于0")
    @DecimalMax(value = "999.99", message = "优先级评分不能大于999.99")
    private BigDecimal priorityScore;

} 