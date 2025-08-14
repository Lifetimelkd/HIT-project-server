package org.dromara.hit.project.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.tenant.core.TenantEntity;

import java.io.Serial;

/**
 * 项目角色对象 hit_project_role
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_project_role")
public class HitProjectRole extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 角色ID
     */
    @TableId(value = "role_id")
    private Long roleId;

    /**
     * 项目ID
     */
    private Long projectId;

    /**
     * 角色名称
     */
    private String roleName;

    /**
     * 角色描述
     */
    private String roleDescription;

    /**
     * 所需技能(JSON格式)
     */
    private String requiredSkills;

    /**
     * 职责描述
     */
    private String responsibilities;

    /**
     * 需要人数
     */
    private Integer requiredCount;

    /**
     * 当前人数
     */
    private Integer currentCount;

    /**
     * 经验要求
     */
    private String experienceRequired;

    /**
     * 时间投入要求
     */
    private String timeCommitment;

    /**
     * 是否领导角色(0否 1是)
     */
    private String isLeader;

    /**
     * 优先级
     */
    private Integer priority;

    /**
     * 状态(0招募中 1已满 2暂停)
     */
    private String status;

} 