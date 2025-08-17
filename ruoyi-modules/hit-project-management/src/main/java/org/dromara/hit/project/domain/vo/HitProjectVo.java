package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitProject;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 项目信息视图对象 hit_project
 *
 * @author HIT
 * @date 2025-01-15
 */
@Data
@AutoMapper(target = HitProject.class)
public class HitProjectVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 项目ID
     */
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
     * 项目类型
     */
    private String projectType;

    /**
     * 项目分类
     */
    private String projectCategory;

    /**
     * 难度等级
     */
    private Integer difficultyLevel;

    /**
     * 周期类型
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
     * 项目状态
     */
    private String status;

    /**
     * 招募状态
     */
    private String recruitmentStatus;

    /**
     * 可见性
     */
    private String visibility;

    /**
     * 审核模式
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
     * 是否精选
     */
    private String isFeatured;

    /**
     * 是否紧急招募
     */
    private String isUrgent;

    /**
     * 是否学分认定
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
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 项目负责人
     */
    private String creatorName;

}
