package org.dromara.hit.project.domain.vo;

import org.dromara.hit.project.domain.HitProjectMember;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 项目成员视图对象 hit_project_member
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitProjectMember.class)
public class HitProjectMemberVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 成员ID
     */
    @ExcelProperty(value = "成员ID")
    private Long memberId;

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
     * 用户ID
     */
    @ExcelProperty(value = "用户ID")
    private Long userId;

    /**
     * 用户姓名
     */
    @ExcelProperty(value = "用户姓名")
    private String userName;

    /**
     * 学号
     */
    @ExcelProperty(value = "学号")
    private String studentId;

    /**
     * 真实姓名
     */
    @ExcelProperty(value = "真实姓名")
    private String realName;

    /**
     * 学院
     */
    @ExcelProperty(value = "学院")
    private String college;

    /**
     * 专业
     */
    @ExcelProperty(value = "专业")
    private String major;

    /**
     * 年级
     */
    @ExcelProperty(value = "年级")
    private String grade;

    /**
     * 角色ID
     */
    @ExcelProperty(value = "角色ID")
    private Long roleId;

    /**
     * 角色名称
     */
    @ExcelProperty(value = "角色名称")
    private String roleName;

    /**
     * 成员角色
     */
    @ExcelProperty(value = "成员角色")
    private String memberRole;

    /**
     * 加入时间
     */
    @ExcelProperty(value = "加入时间")
    private LocalDateTime joinTime;

    /**
     * 离开时间
     */
    @ExcelProperty(value = "离开时间")
    private LocalDateTime leaveTime;

    /**
     * 成员状态(active/inactive/left)
     */
    @ExcelProperty(value = "成员状态")
    private String memberStatus;

    /**
     * 贡献度评分
     */
    @ExcelProperty(value = "贡献度评分")
    private BigDecimal contributionScore;

    /**
     * 完成任务数
     */
    @ExcelProperty(value = "完成任务数")
    private Integer completedTasks;

    /**
     * 总任务数
     */
    @ExcelProperty(value = "总任务数")
    private Integer totalTasks;

    /**
     * 任务完成率
     */
    @ExcelProperty(value = "任务完成率")
    private BigDecimal taskCompletionRate;

    /**
     * 工作时长
     */
    @ExcelProperty(value = "工作时长")
    private BigDecimal workHours;

    /**
     * 表现评分
     */
    @ExcelProperty(value = "表现评分")
    private BigDecimal performanceRating;

    /**
     * 是否组长(0否 1是)
     */
    @ExcelProperty(value = "是否组长")
    private String isLeader;

    /**
     * 权限列表(JSON格式)
     */
    @ExcelProperty(value = "权限列表")
    private String permissions;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    /**
     * 联系方式
     */
    @ExcelProperty(value = "联系方式")
    private String contactInfo;

    /**
     * 头像地址
     */
    @ExcelProperty(value = "头像地址")
    private String avatarUrl;

} 