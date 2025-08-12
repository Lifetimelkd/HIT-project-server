package org.dromara.hit.domain.vo;

import org.dromara.hit.domain.HitUserSkill;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户技能关联视图对象 hit_user_skill
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Data
@AutoMapper(target = HitUserSkill.class)
public class HitUserSkillVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户技能ID
     */
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

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 技能标签名称（关联查询）
     */
    private String tagName;

    /**
     * 技能标签分类（关联查询）
     */
    private String tagCategory;

} 