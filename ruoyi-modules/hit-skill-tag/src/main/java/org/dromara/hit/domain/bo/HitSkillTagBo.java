package org.dromara.hit.domain.bo;

import org.dromara.hit.domain.HitSkillTag;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 技能标签业务对象 hit_skill_tag
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitSkillTag.class, reverseConvertGenerate = false)
public class HitSkillTagBo extends BaseEntity {

    /**
     * 技能标签ID
     */
    @NotNull(message = "技能标签ID不能为空", groups = { EditGroup.class })
    private Long tagId;

    /**
     * 标签名称
     */
    @NotBlank(message = "标签名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String tagName;

    /**
     * 标签分类
     */
    @NotBlank(message = "标签分类不能为空", groups = { AddGroup.class, EditGroup.class })
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

} 