package org.dromara.hit.project.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.tenant.core.TenantEntity;

import java.io.Serial;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目申请对象 hit_project_application
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_project_application")
public class HitProjectApplication extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @TableId(value = "application_id")
    private Long applicationId;

    /**
     * 项目ID
     */
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
    private String applicationReason;

    /**
     * 自我介绍
     */
    private String selfIntroduction;

    /**
     * 相关经验
     */
    private String relevantExperience;

    /**
     * 预期贡献
     */
    private String expectedContribution;

    /**
     * 可投入时间
     */
    private String availableTime;

    /**
     * 联系方式
     */
    private String contactInfo;

    /**
     * 简历附件
     */
    private String resumeUrl;

    /**
     * 作品集地址
     */
    private String portfolioUrl;

    /**
     * 申请状态(pending/reviewing/approved/rejected/withdrawn)
     */
    private String applicationStatus;

    /**
     * 审核结果
     */
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
    private String interviewNotes;

    /**
     * 优先级评分
     */
    private BigDecimal priorityScore;

} 