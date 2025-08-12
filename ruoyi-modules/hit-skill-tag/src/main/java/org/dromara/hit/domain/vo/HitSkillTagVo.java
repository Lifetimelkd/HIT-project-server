package org.dromara.hit.domain.vo;

import org.dromara.hit.domain.HitSkillTag;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 技能标签视图对象 hit_skill_tag
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@AutoMapper(target = HitSkillTag.class)
public class HitSkillTagVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 技能标签ID
     */
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

    /**
     * 创建时间
     */
    private Date createTime;

} 