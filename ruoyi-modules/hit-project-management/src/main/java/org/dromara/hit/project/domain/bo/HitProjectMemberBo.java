package org.dromara.hit.project.domain.bo;

import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.hit.project.domain.HitProjectMember;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目成员业务对象 hit_project_member
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitProjectMember.class, reverseConvertGenerate = false)
public class HitProjectMemberBo extends BaseEntity {

    /**
     * 成员ID
     */
    @NotNull(message = "成员ID不能为空", groups = { EditGroup.class })
    private Long memberId;

    /**
     * 项目ID
     */
    @NotNull(message = "项目ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long projectId;

    /**
     * 用户ID
     */
    @NotNull(message = "用户ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 角色ID
     */
    private Long roleId;

    /**
     * 成员角色
     */
    @Size(max = 50, message = "成员角色长度不能超过50个字符")
    private String memberRole;

    /**
     * 加入时间
     */
    private LocalDateTime joinTime;

    /**
     * 离开时间
     */
    private LocalDateTime leaveTime;

    /**
     * 成员状态(active/inactive/left)
     */
    private String memberStatus;

    /**
     * 贡献度评分
     */
    @DecimalMin(value = "0.00", message = "贡献度评分不能小于0")
    @DecimalMax(value = "999.99", message = "贡献度评分不能大于999.99")
    private BigDecimal contributionScore;

    /**
     * 完成任务数
     */
    @Min(value = 0, message = "完成任务数不能小于0")
    private Integer completedTasks;

    /**
     * 总任务数
     */
    @Min(value = 0, message = "总任务数不能小于0")
    private Integer totalTasks;

    /**
     * 工作时长
     */
    @DecimalMin(value = "0.00", message = "工作时长不能小于0")
    @DecimalMax(value = "99999999.99", message = "工作时长不能超过最大值")
    private BigDecimal workHours;

    /**
     * 表现评分
     */
    @DecimalMin(value = "0.00", message = "表现评分不能小于0")
    @DecimalMax(value = "5.00", message = "表现评分不能大于5.00")
    private BigDecimal performanceRating;

    /**
     * 是否组长(0否 1是)
     */
    private String isLeader;

    /**
     * 权限列表(JSON格式)
     */
    private String permissions;

    /**
     * 备注
     */
    @Size(max = 500, message = "备注长度不能超过500个字符")
    private String remark;

} 