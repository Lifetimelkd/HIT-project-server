package org.dromara.hit.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.util.Date;

/**
 * 用户作品集对象 hit_user_portfolio
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_user_portfolio")
public class HitUserPortfolio extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 作品集ID
     */
    @TableId(value = "portfolio_id")
    private Long portfolioId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 作品标题
     */
    @TableField("title")
    private String portfolioTitle;

    /**
     * 作品描述
     */
    @TableField("description")
    private String portfolioDescription;

    /**
     * 作品类型
     */
    private String workType;

    /**
     * 封面图片
     */
    private String coverImage;

    /**
     * 演示地址
     */
    private String demoUrl;

    /**
     * 代码仓库地址
     */
    private String repositoryUrl;

    /**
     * 下载地址
     */
    private String downloadUrl;

    /**
     * 技术栈(JSON格式)
     */
    private String techStack;

    /**
     * 我的角色
     */
    private String myRole;

    /**
     * 团队规模
     */
    private Integer teamSize;

    /**
     * 开始日期
     */
    private Date startDate;

    /**
     * 结束日期
     */
    private Date endDate;

    /**
     * 浏览次数
     */
    private Integer viewCount;

    /**
     * 点赞次数
     */
    private Integer likeCount;

    /**
     * 是否精选(0否 1是)
     */
    private String isFeatured;

    /**
     * 是否公开(0否 1是)
     */
    private String isPublic;

    /**
     * 排序
     */
    private Integer sortOrder;

    /**
     * 状态(0正常 1隐藏)
     */
    private String status;

} 