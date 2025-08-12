package org.dromara.hit.domain.bo;

import org.dromara.hit.domain.HitUserPortfolio;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;

/**
 * 用户作品集业务对象 hit_user_portfolio
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitUserPortfolio.class, reverseConvertGenerate = false)
public class HitUserPortfolioBo extends BaseEntity {

    /**
     * 作品集ID
     */
    @NotNull(message = "作品集ID不能为空", groups = { EditGroup.class })
    private Long portfolioId;

    /**
     * 用户ID
     */
//    @NotNull(message = "用户ID不能为空", groups = { EditGroup.class })
    private Long userId;

    /**
     * 作品标题
     */
    @NotBlank(message = "作品标题不能为空", groups = { AddGroup.class, EditGroup.class })
    private String portfolioTitle;

    /**
     * 作品描述
     */
    private String portfolioDescription;

    /**
     * 作品类型
     */
    @NotBlank(message = "作品类型不能为空", groups = { AddGroup.class, EditGroup.class })
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
