package org.dromara.hit.project.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.io.Serial;
import java.time.LocalDate;
import java.math.BigDecimal;

/**
 * 项目信息对象 hit_project
 *
 * @author HIT
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_project")
public class HitProject extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 项目ID
     */
    @TableId(value = "project_id")
    private Long projectId;

    /**
     * 项目名称
     */
    private String projectName;

    /**
     * 项目描述
     */
    private String projectDescription;

    /**
     * 项目背景
     */
    private String projectBackground;

    /**
     * 项目目标
     */
    private String projectGoals;

    /**
     * 预期成果
     */
    private String expectedOutcome;

    /**
     * 项目封面
     */
    private String coverImage;

    /**
     * 项目类型(academic/competition/practice/graduation/course)
     */
    private String projectType;

    /**
     * 项目分类(computer/electronic/mechanical等)
     */
    private String projectCategory;

    /**
     * 难度等级(1入门 2进阶 3专业 4挑战)
     */
    private Integer difficultyLevel;

    /**
     * 周期类型(short/medium/long)
     */
    private String durationType;

    /**
     * 开始日期
     */
    private LocalDate startDate;

    /**
     * 结束日期
     */
    private LocalDate endDate;

    /**
     * 最小团队规模
     */
    private Integer teamSizeMin;

    /**
     * 最大团队规模
     */
    private Integer teamSizeMax;

    /**
     * 当前成员数
     */
    private Integer currentMembers;

    /**
     * 项目状态(recruiting/ongoing/completed/paused/cancelled)
     */
    private String status;

    /**
     * 招募状态(open/paused/closed)
     */
    private String recruitmentStatus;

    /**
     * 可见性(public/internal/private)
     */
    private String visibility;

    /**
     * 审核模式(auto/manual)
     */
    private String approvalMode;

    /**
     * 浏览次数
     */
    private Integer viewCount;

    /**
     * 点赞次数
     */
    private Integer likeCount;

    /**
     * 收藏次数
     */
    private Integer collectCount;

    /**
     * 申请次数
     */
    private Integer applyCount;

    /**
     * 是否精选(0否 1是)
     */
    private String isFeatured;

    /**
     * 是否紧急招募(0否 1是)
     */
    private String isUrgent;

    /**
     * 是否学分认定(0否 1是)
     */
    private String isCredit;

    /**
     * 创建者ID
     */
    private Long creatorId;

    /**
     * 指导老师ID
     */
    private Long mentorId;

    /**
     * 关联部门id
     */
    private Long deptId;

} 