package org.dromara.hit.domain.bo;

import org.dromara.hit.domain.HitUserProfile;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 用户扩展档案业务对象 hit_user_profile
 *
 * @author LKD
 * @date 2025-08-11
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = HitUserProfile.class, reverseConvertGenerate = false)
public class HitUserProfileBo extends BaseEntity {

    /**
     * 用户档案ID
     */
    private Long profileId;

    /**
     * 关联用户id
     */
    private Long userId;

    /**
     * 学号
     */
    @NotBlank(message = "学号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String studentId;

    /**
     * 真实姓名
     */
    @NotBlank(message = "真实姓名不能为空", groups = { AddGroup.class, EditGroup.class })
    private String realName;

    /**
     * 所属学院
     */
    @NotBlank(message = "所属学院不能为空", groups = { AddGroup.class, EditGroup.class })
    private String college;

    /**
     * 专业
     */
    @NotBlank(message = "专业不能为空", groups = { AddGroup.class, EditGroup.class })
    private String major;

    /**
     * 年级
     */
    @NotBlank(message = "年级不能为空", groups = { AddGroup.class, EditGroup.class })
    private String grade;

    /**
     * 班级
     */
    @NotBlank(message = "班级不能为空", groups = { AddGroup.class, EditGroup.class })
    private String className;

    /**
     * 手机号
     */
    @NotBlank(message = "手机号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String phone;

    /**
     * 邮箱
     */
    @NotBlank(message = "邮箱不能为空", groups = { AddGroup.class, EditGroup.class })
    private String email;

    /**
     * QQ号
     */
//    @NotBlank(message = "QQ号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String qq;

    /**
     * 微信号
     */
//    @NotBlank(message = "微信号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String wechat;

    /**
     * GitHub地址
     */
//    @NotBlank(message = "GitHub地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String github;

    /**
     * LinkedIn地址
     */
//    @NotBlank(message = "LinkedIn地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String linkedin;

    /**
     * 个人简介
     */
//    @NotBlank(message = "个人简介不能为空", groups = { AddGroup.class, EditGroup.class })
    private String personalIntro;

    /**
     * 职业规划
     */
//    @NotBlank(message = "职业规划不能为空", groups = { AddGroup.class, EditGroup.class })
    private String careerPlan;

    /**
     * 头像地址
     */
//    @NotBlank(message = "头像地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String avatarUrl;

    /**
     * 封面地址
     */
//    @NotBlank(message = "封面地址不能为空", groups = { AddGroup.class, EditGroup.class })
    private String coverUrl;

    /**
     * 信誉积分
     */
//    @NotNull(message = "信誉积分不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long reputationScore;

    /**
     * 参与项目总数
     */
//    @NotNull(message = "参与项目总数不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long totalProjects;

    /**
     * 完成项目数
     */
//    @NotNull(message = "完成项目数不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long completedProjects;

    /**
     * 状态(0正常 1禁用)
     */
//    @NotBlank(message = "状态(0正常 1禁用)不能为空", groups = { AddGroup.class, EditGroup.class })
    private String status;

    /**
     * 关联部门id
     */
//    @NotNull(message = "关联部门id不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long deptId;


}
