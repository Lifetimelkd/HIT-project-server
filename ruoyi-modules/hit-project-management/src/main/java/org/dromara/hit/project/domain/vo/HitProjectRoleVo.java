package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitProjectRole;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 项目角色视图对象 hit_project_role
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitProjectRole.class)
public class HitProjectRoleVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 角色ID
     */
    @ExcelProperty(value = "角色ID")
    private Long roleId;

    /**
     * 项目ID
     */
    @ExcelProperty(value = "项目ID")
    private Long projectId;

    /**
     * 项目名称
     */
    @ExcelProperty(value = "项目名称")
    private String projectName;

    /**
     * 角色名称
     */
    @ExcelProperty(value = "角色名称")
    private String roleName;

    /**
     * 角色描述
     */
    @ExcelProperty(value = "角色描述")
    private String roleDescription;

    /**
     * 所需技能(JSON格式)
     */
    @ExcelProperty(value = "所需技能")
    private String requiredSkills;

    /**
     * 职责描述
     */
    @ExcelProperty(value = "职责描述")
    private String responsibilities;

    /**
     * 需要人数
     */
    @ExcelProperty(value = "需要人数")
    private Integer requiredCount;

    /**
     * 当前人数
     */
    @ExcelProperty(value = "当前人数")
    private Integer currentCount;

    /**
     * 经验要求
     */
    @ExcelProperty(value = "经验要求")
    private String experienceRequired;

    /**
     * 时间投入要求
     */
    @ExcelProperty(value = "时间投入要求")
    private String timeCommitment;

    /**
     * 是否领导角色
     */
    @ExcelProperty(value = "是否领导角色")
    private String isLeader;

    /**
     * 优先级
     */
    @ExcelProperty(value = "优先级")
    private Integer priority;

    /**
     * 状态(0招募中 1已满 2暂停)
     */
    private String status;

    /**
     * 状态文本描述
     */
    private String statusText;

    /**
     * 是否可申请(1可申请 0不可申请)
     */
    private Integer available;

    /**
     * 剩余名额
     */
    private Integer remainingCount;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

} 