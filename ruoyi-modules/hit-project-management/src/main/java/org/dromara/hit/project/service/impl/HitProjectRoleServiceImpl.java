package org.dromara.hit.project.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.hit.project.domain.HitProjectRole;
import org.dromara.hit.project.domain.bo.HitProjectRoleBo;
import org.dromara.hit.project.domain.vo.HitProjectRoleVo;
import org.dromara.hit.project.mapper.HitProjectRoleMapper;
import org.dromara.hit.project.service.IHitProjectRoleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

/**
 * 项目角色Service业务层处理
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@RequiredArgsConstructor
@Service
public class HitProjectRoleServiceImpl implements IHitProjectRoleService {

    private final HitProjectRoleMapper baseMapper;

    /**
     * 查询项目角色
     */
    @Override
    public HitProjectRoleVo queryById(Long roleId) {
        return baseMapper.selectRoleWithDetails(roleId);
    }

    /**
     * 查询项目角色列表
     */
    @Override
    public TableDataInfo<HitProjectRoleVo> queryPageList(HitProjectRoleBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitProjectRole> lqw = buildQueryWrapper(bo);
        Page<HitProjectRoleVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询项目角色列表
     */
    @Override
    public List<HitProjectRoleVo> queryList(HitProjectRoleBo bo) {
        LambdaQueryWrapper<HitProjectRole> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitProjectRole> buildQueryWrapper(HitProjectRoleBo bo) {
        LambdaQueryWrapper<HitProjectRole> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getProjectId() != null, HitProjectRole::getProjectId, bo.getProjectId());
        lqw.like(StringUtils.isNotBlank(bo.getRoleName()), HitProjectRole::getRoleName, bo.getRoleName());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitProjectRole::getStatus, bo.getStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getIsLeader()), HitProjectRole::getIsLeader, bo.getIsLeader());
        lqw.orderByAsc(HitProjectRole::getPriority);
        lqw.orderByAsc(HitProjectRole::getCreateTime);
        return lqw;
    }

    /**
     * 新增项目角色
     */
    @Override
    public Boolean insertByBo(HitProjectRoleBo bo) {
        HitProjectRole add = MapstructUtils.convert(bo, HitProjectRole.class);
        validEntityBeforeSave(add);
        
        // 设置默认值
        if (add.getCurrentCount() == null) {
            add.setCurrentCount(0);
        }
        if (add.getStatus() == null) {
            add.setStatus("0"); // 默认招募中
        }
        if (add.getIsLeader() == null) {
            add.setIsLeader("0"); // 默认非领导
        }
        if (add.getPriority() == null) {
            Integer maxPriority = baseMapper.getMaxPriorityByProjectId(add.getProjectId());
            add.setPriority(maxPriority + 1);
        }
        
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setRoleId(add.getRoleId());
        }
        return flag;
    }

    /**
     * 修改项目角色
     */
    @Override
    public Boolean updateByBo(HitProjectRoleBo bo) {
        HitProjectRole update = MapstructUtils.convert(bo, HitProjectRole.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitProjectRole entity) {
        // 检查角色名称是否重复
        Boolean exists = checkRoleNameExists(entity.getProjectId(), entity.getRoleName(), entity.getRoleId());
        if (exists) {
            throw new RuntimeException("项目中已存在相同的角色名称");
        }
    }

    /**
     * 批量删除项目角色
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO: 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    // ==================== 业务接口实现 ====================

    /**
     * 查询项目的所有角色
     */
    @Override
    public List<HitProjectRoleVo> queryRolesByProjectId(Long projectId) {
        return baseMapper.selectRolesByProjectId(projectId);
    }

    /**
     * 查询项目的可申请角色
     */
    @Override
    public List<HitProjectRoleVo> queryAvailableRolesByProjectId(Long projectId) {
        return baseMapper.selectAvailableRolesByProjectId(projectId);
    }

    /**
     * 查询项目的领导角色
     */
    @Override
    public List<HitProjectRoleVo> queryLeaderRolesByProjectId(Long projectId) {
        return baseMapper.selectLeaderRolesByProjectId(projectId);
    }

    /**
     * 根据角色名称查询项目角色
     */
    @Override
    public HitProjectRoleVo queryByProjectIdAndRoleName(Long projectId, String roleName) {
        HitProjectRole role = baseMapper.selectByProjectIdAndRoleName(projectId, roleName);
        return role != null ? MapstructUtils.convert(role, HitProjectRoleVo.class) : null;
    }

    /**
     * 检查项目角色名称是否存在
     */
    @Override
    public Boolean checkRoleNameExists(Long projectId, String roleName, Long excludeRoleId) {
        return baseMapper.checkRoleNameExists(projectId, roleName, excludeRoleId);
    }

    /**
     * 更新角色的当前人数统计
     */
    @Override
    public Boolean updateCurrentCountByProjectId(Long projectId) {
        return baseMapper.updateCurrentCountByProjectId(projectId) >= 0;
    }

    /**
     * 更新单个角色的当前人数统计
     */
    @Override
    public Boolean updateCurrentCountByRoleId(Long roleId) {
        // 通过角色ID查询项目ID，然后更新整个项目的角色统计
        HitProjectRole role = baseMapper.selectById(roleId);
        if (role != null) {
            return updateCurrentCountByProjectId(role.getProjectId());
        }
        return false;
    }

    /**
     * 统计项目角色数量
     */
    @Override
    public Long countRolesByProjectId(Long projectId, String status) {
        return baseMapper.countRolesByProjectId(projectId, status);
    }

    /**
     * 获取项目角色的最大优先级
     */
    @Override
    public Integer getMaxPriorityByProjectId(Long projectId) {
        return baseMapper.getMaxPriorityByProjectId(projectId);
    }

    /**
     * 批量设置角色状态
     */
    @Override
    @Transactional
    public Boolean batchUpdateRoleStatus(List<Long> roleIds, String status) {
        if (roleIds == null || roleIds.isEmpty()) {
            return false;
        }
        
        LambdaQueryWrapper<HitProjectRole> wrapper = Wrappers.lambdaQuery();
        wrapper.in(HitProjectRole::getRoleId, roleIds);
        
        HitProjectRole updateEntity = new HitProjectRole();
        updateEntity.setStatus(status);
        
        return baseMapper.update(updateEntity, wrapper) > 0;
    }

    /**
     * 创建项目默认角色
     */
    @Override
    @Transactional
    public Boolean createDefaultRoles(Long projectId, String projectType, String projectCategory) {
        // 根据项目类型和分类创建不同的默认角色
        // 这里简化处理，创建通用角色
        
        // 项目负责人角色
        createRole(projectId, "项目负责人", "负责项目整体规划和团队管理", 
                   "[\"项目管理\", \"团队协作\", \"技术架构\"]", 
                   "制定项目计划、协调团队工作、把控项目进度", 
                   1, "1", 1);
        
        // 核心成员角色
        createRole(projectId, "核心成员", "项目核心贡献者", 
                   "[\"专业技能\", \"责任心强\"]", 
                   "承担重要模块开发、参与技术决策", 
                   2, "0", 2);
        
        // 普通成员角色
        createRole(projectId, "普通成员", "项目一般参与者", 
                   "[\"基础技能\", \"学习能力\"]", 
                   "参与具体功能开发、学习提升", 
                   3, "0", 3);
        
        // 观察者角色
        createRole(projectId, "观察者", "项目观察学习者", 
                   "[\"学习意愿\"]", 
                   "观察项目进展、学习经验", 
                   5, "0", 4);
        
        return true;
    }

    private void createRole(Long projectId, String roleName, String description, 
                           String skills, String responsibilities, 
                           Integer requiredCount, String isLeader, Integer priority) {
        HitProjectRole role = new HitProjectRole();
        role.setProjectId(projectId);
        role.setRoleName(roleName);
        role.setRoleDescription(description);
        role.setRequiredSkills(skills);
        role.setResponsibilities(responsibilities);
        role.setRequiredCount(requiredCount);
        role.setCurrentCount(0);
        role.setIsLeader(isLeader);
        role.setPriority(priority);
        role.setStatus("0"); // 招募中
        
        baseMapper.insert(role);
    }
} 