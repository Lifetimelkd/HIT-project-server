package org.dromara.hit.domain.bo;

import org.dromara.hit.domain.HitUserSkill;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;

/**
 * 用户技能关联业务对象 hit_user_skill
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitUserSkill.class, reverseConvertGenerate = false)
public class HitUserSkillBo extends BaseEntity {

    /**
     * 用户技能ID
     */
    @NotNull(message = "用户技能ID不能为空", groups = { EditGroup.class })
    private Long userSkillId;

    /**
     * 用户ID
     */
    @NotNull(message = "用户ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 技能标签ID
     */
    @NotNull(message = "技能标签ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long tagId;

    /**
     * 技能等级(1-5)
     */
    @NotNull(message = "技能等级不能为空", groups = { AddGroup.class, EditGroup.class })
    @Min(value = 1, message = "技能等级最小值为1")
    @Max(value = 5, message = "技能等级最大值为5")
    private Integer skillLevel;

    /**
     * 是否认证
     */
    private Integer isCertified;

    /**
     * 学习时长(小时)
     */
    private Integer learningTime;

    /**
     * 相关项目数量
     */
    private Integer projectCount;

    /**
     * 技能描述
     */
    private String skillDescription;

    /**
     * 认证时间
     */
    private Date certifiedTime;

    /**
     * 认证说明
     */
    private String certifiedRemark;

} 