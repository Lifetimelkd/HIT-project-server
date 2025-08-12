package org.dromara.hit.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 用户技能关联对象 hit_user_skill
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_user_skill")
public class HitUserSkill extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户技能ID
     */
    @TableId(value = "id")
    private Long userSkillId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 技能标签ID
     */
    private Long tagId;

    /**
     * 技能等级(1-5)
     */
    private Integer skillLevel;

    /**
     * 是否认证
     */
    private Integer isCertified;

    /**
     * 认证证书地址
     */
    private String certificateUrl;

    /**
     * 学习时长(月)
     */
    private Integer learningTime;

    /**
     * 相关项目数量
     */
    private Integer projectCount;

    /**
     * 自我评价
     */
    @TableField("self_evaluation")
    private String skillDescription;

} 