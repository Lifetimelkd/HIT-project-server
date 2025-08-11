package org.dromara.hit.domain.vo;

import org.dromara.hit.domain.HitUserProfile;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;



/**
 * 用户扩展档案视图对象 hit_user_profile
 *
 * @author LKD
 * @date 2025-08-11
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = HitUserProfile.class)
public class HitUserProfileVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户档案ID
     */
    @ExcelProperty(value = "用户档案ID")
    private Long profileId;

    /**
     * 关联用户id
     */
    @ExcelProperty(value = "关联用户id")
    private Long userId;

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
     * 所属学院
     */
    @ExcelProperty(value = "所属学院", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_college")
    private String college;

    /**
     * 专业
     */
    @ExcelProperty(value = "专业")
    private String major;

    /**
     * 年级
     */
    @ExcelProperty(value = "年级", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "hit_grade")
    private String grade;

    /**
     * 班级
     */
    @ExcelProperty(value = "班级")
    private String className;

    /**
     * 手机号
     */
    @ExcelProperty(value = "手机号")
    private String phone;

    /**
     * 邮箱
     */
    @ExcelProperty(value = "邮箱")
    private String email;

    /**
     * QQ号
     */
    @ExcelProperty(value = "QQ号")
    private String qq;

    /**
     * 微信号
     */
    @ExcelProperty(value = "微信号")
    private String wechat;

    /**
     * GitHub地址
     */
    @ExcelProperty(value = "GitHub地址")
    private String github;

    /**
     * LinkedIn地址
     */
    @ExcelProperty(value = "LinkedIn地址")
    private String linkedin;

    /**
     * 个人简介
     */
    @ExcelProperty(value = "个人简介")
    private String personalIntro;

    /**
     * 职业规划
     */
    @ExcelProperty(value = "职业规划")
    private String careerPlan;

    /**
     * 头像地址
     */
    @ExcelProperty(value = "头像地址")
    private String avatarUrl;

    /**
     * 封面地址
     */
    @ExcelProperty(value = "封面地址")
    private String coverUrl;

    /**
     * 信誉积分
     */
    @ExcelProperty(value = "信誉积分")
    private Long reputationScore;

    /**
     * 参与项目总数
     */
    @ExcelProperty(value = "参与项目总数")
    private Long totalProjects;

    /**
     * 完成项目数
     */
    @ExcelProperty(value = "完成项目数")
    private Long completedProjects;

    /**
     * 状态(0正常 1禁用)
     */
    @ExcelProperty(value = "状态(0正常 1禁用)")
    private String status;

    /**
     * 关联部门id
     */
    @ExcelProperty(value = "关联部门id")
    private Long deptId;


}
