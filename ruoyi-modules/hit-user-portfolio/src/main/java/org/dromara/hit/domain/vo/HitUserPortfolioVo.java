package org.dromara.hit.domain.vo;

import org.dromara.hit.domain.HitUserPortfolio;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户作品集视图对象 hit_user_portfolio
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@AutoMapper(target = HitUserPortfolio.class)
public class HitUserPortfolioVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 作品集ID
     */
    private Long portfolioId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 作品标题
     */
    private String portfolioTitle;

    /**
     * 作品描述
     */
    private String portfolioDescription;

    /**
     * 作品类型
     */
    private String workType;

    /**
     * 技术栈
     */
    private String techStack;

    /**
     * 项目链接
     */
    private String projectUrl;

    /**
     * 代码仓库链接
     */
    private String repositoryUrl;

    /**
     * 演示视频链接
     */
    private String videoUrl;

    /**
     * 作品封面图
     */
    private String coverImage;

    /**
     * 作品图片集(JSON数组)
     */
    private String portfolioImages;

    /**
     * 项目开始时间
     */
    private Date startDate;

    /**
     * 项目结束时间
     */
    private Date endDate;

    /**
     * 团队成员数量
     */
    private Integer teamSize;

    /**
     * 个人角色
     */
    private String personalRole;

    /**
     * 项目难度(1-5)
     */
    private Integer difficulty;

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
     * 是否置顶
     */
    private Integer isTop;

    /**
     * 显示顺序
     */
    private Integer orderNum;

    /**
     * 是否精选(0否 1是)
     */
    private String isFeatured;

    /**
     * 是否公开(0否 1是)
     */
    private String isPublic;

    /**
     * 状态
     */
    private String status;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 用户昵称（关联查询）
     */
    private String nickName;

    /**
     * 作品类型字典标签（关联查询）
     */
    private String workTypeLabel;

} 