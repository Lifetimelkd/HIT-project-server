package org.dromara.hit.project.domain.bo;

import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.hit.project.domain.HitProjectRole;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 项目角色业务对象 hit_project_role
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitProjectRole.class, reverseConvertGenerate = false)
public class HitProjectRoleBo extends BaseEntity {

    /**
     * 角色ID
     */
    @NotNull(message = "角色ID不能为空", groups = { EditGroup.class })
    private Long roleId;

    /**
     * 项目ID
     */
    @NotNull(message = "项目ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long projectId;

    /**
     * 角色名称
     */
    @NotBlank(message = "角色名称不能为空", groups = { AddGroup.class, EditGroup.class })
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
    @NotNull(message = "需要人数不能为空", groups = { AddGroup.class, EditGroup.class })
    @Min(value = 1, message = "需要人数至少为1", groups = { AddGroup.class, EditGroup.class })
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