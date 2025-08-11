package org.dromara.hit.domain;

import org.dromara.common.tenant.core.TenantEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 用户扩展档案对象 hit_user_profile
 *
 * @author LKD
 * @date 2025-08-11
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("hit_user_profile")
public class HitUserProfile extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户档案ID
     */
    @TableId(value = "profile_id")
    private Long profileId;

    /**
     * 关联用户id
     */
    private Long userId;

    /**
     * 学号
     */
    private String studentId;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 所属学院
     */
    private String college;

    /**
     * 专业
     */
    private String major;

    /**
     * 年级
     */
    private String grade;

    /**
     * 班级
     */
    private String className;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * QQ号
     */
    private String qq;

    /**
     * 微信号
     */
    private String wechat;

    /**
     * GitHub地址
     */
    private String github;

    /**
     * LinkedIn地址
     */
    private String linkedin;

    /**
     * 个人简介
     */
    private String personalIntro;

    /**
     * 职业规划
     */
    private String careerPlan;

    /**
     * 头像地址
     */
    private String avatarUrl;

    /**
     * 封面地址
     */
    private String coverUrl;

    /**
     * 信誉积分
     */
    private Long reputationScore;

    /**
     * 参与项目总数
     */
    private Long totalProjects;

    /**
     * 完成项目数
     */
    private Long completedProjects;

    /**
     * 状态(0正常 1禁用)
     */
    private String status;

    /**
     * 关联部门id
     */
    private Long deptId;


}
