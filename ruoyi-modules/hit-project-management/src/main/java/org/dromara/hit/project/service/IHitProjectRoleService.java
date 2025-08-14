package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitProjectRoleVo;
import org.dromara.hit.project.domain.bo.HitProjectRoleBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 项目角色Service接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface IHitProjectRoleService {

    /**
     * 查询项目角色
     */
    HitProjectRoleVo queryById(Long roleId);

    /**
     * 查询项目角色列表
     */
    TableDataInfo<HitProjectRoleVo> queryPageList(HitProjectRoleBo bo, PageQuery pageQuery);

    /**
     * 查询项目角色列表
     */
    List<HitProjectRoleVo> queryList(HitProjectRoleBo bo);

    /**
     * 新增项目角色
     */
    Boolean insertByBo(HitProjectRoleBo bo);

    /**
     * 修改项目角色
     */
    Boolean updateByBo(HitProjectRoleBo bo);

    /**
     * 校验并批量删除项目角色信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    // ==================== 业务接口 ====================

    /**
     * 查询项目的所有角色
     *
     * @param projectId 项目ID
     * @return 项目角色列表
     */
    List<HitProjectRoleVo> queryRolesByProjectId(Long projectId);

    /**
     * 查询项目的可申请角色（招募中且未满员）
     *
     * @param projectId 项目ID
     * @return 可申请角色列表
     */
    List<HitProjectRoleVo> queryAvailableRolesByProjectId(Long projectId);

    /**
     * 查询项目的领导角色
     *
     * @param projectId 项目ID
     * @return 领导角色列表
     */
    List<HitProjectRoleVo> queryLeaderRolesByProjectId(Long projectId);

    /**
     * 根据角色名称查询项目角色
     *
     * @param projectId 项目ID
     * @param roleName 角色名称
     * @return 项目角色
     */
    HitProjectRoleVo queryByProjectIdAndRoleName(Long projectId, String roleName);

    /**
     * 检查项目角色名称是否存在
     *
     * @param projectId 项目ID
     * @param roleName 角色名称
     * @param excludeRoleId 排除的角色ID
     * @return 是否存在
     */
    Boolean checkRoleNameExists(Long projectId, String roleName, Long excludeRoleId);

    /**
     * 创建项目默认角色
     *
     * @param projectId 项目ID
     * @param projectType 项目类型
     * @param projectCategory 项目分类
     * @return 创建结果
     */
    Boolean createDefaultRoles(Long projectId, String projectType, String projectCategory);

    /**
     * 更新角色的当前人数统计
     *
     * @param projectId 项目ID
     * @return 更新结果
     */
    Boolean updateCurrentCountByProjectId(Long projectId);

    /**
     * 更新单个角色的当前人数统计
     *
     * @param roleId 角色ID
     * @return 更新结果
     */
    Boolean updateCurrentCountByRoleId(Long roleId);

    /**
     * 统计项目角色数量
     *
     * @param projectId 项目ID
     * @param status 状态（可选）
     * @return 角色数量
     */
    Long countRolesByProjectId(Long projectId, String status);

    /**
     * 获取项目角色的最大优先级
     *
     * @param projectId 项目ID
     * @return 最大优先级
     */
    Integer getMaxPriorityByProjectId(Long projectId);

    /**
     * 批量设置角色状态
     *
     * @param roleIds 角色ID列表
     * @param status 状态
     * @return 更新结果
     */
    Boolean batchUpdateRoleStatus(List<Long> roleIds, String status);
} 