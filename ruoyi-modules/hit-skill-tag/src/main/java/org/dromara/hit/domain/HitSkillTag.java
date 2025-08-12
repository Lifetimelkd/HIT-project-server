package org.dromara.hit.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 技能标签对象 hit_skill_tag
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_skill_tag")
public class HitSkillTag extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 技能标签ID
     */
    @TableId(value = "tag_id")
    private Long tagId;

    /**
     * 标签名称
     */
    private String tagName;

    /**
     * 标签分类
     */
    private String tagCategory;

    /**
     * 标签描述
     */
    private String tagDescription;

    /**
     * 父级标签ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    @TableField("sort_order")
    private Integer orderNum;

    /**
     * 是否热门标签
     */
    private Integer isHot;

    /**
     * 使用次数
     */
    private Integer useCount;

    /**
     * 状态
     */
    private String status;

} 