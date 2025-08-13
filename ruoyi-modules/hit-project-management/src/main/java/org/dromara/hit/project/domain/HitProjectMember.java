package org.dromara.hit.project.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.tenant.core.TenantEntity;

import java.io.Serial;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目成员对象 hit_project_member
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_project_member")
public class HitProjectMember extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 成员ID
     */
    @TableId(value = "member_id")
    private Long memberId;

    /**
     * 项目ID
     */
    private Long projectId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 角色ID
     */
    private Long roleId;

    /**
     * 成员角色
     */
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
    private BigDecimal contributionScore;

    /**
     * 完成任务数
     */
    private Integer completedTasks;

    /**
     * 总任务数
     */
    private Integer totalTasks;

    /**
     * 工作时长
     */
    private BigDecimal workHours;

    /**
     * 表现评分
     */
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
    private String remark;

} 