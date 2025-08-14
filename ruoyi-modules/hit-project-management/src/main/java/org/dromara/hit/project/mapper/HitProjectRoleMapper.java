package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitProjectRole;
import org.dromara.hit.project.domain.vo.HitProjectRoleVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 项目角色Mapper接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface HitProjectRoleMapper extends BaseMapperPlus<HitProjectRole, HitProjectRoleVo> {

    /**
     * 查询项目角色详情（包含关联信息）
     *
     * @param roleId 角色ID
     * @return 项目角色详情
     */
    HitProjectRoleVo selectRoleWithDetails(@Param("roleId") Long roleId);

    /**
     * 查询项目的所有角色（包含关联信息）
     *
     * @param projectId 项目ID
     * @return 项目角色列表
     */
    List<HitProjectRoleVo> selectRolesByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询项目的可申请角色（招募中且未满员）
     *
     * @param projectId 项目ID
     * @return 可申请角色列表
     */
    List<HitProjectRoleVo> selectAvailableRolesByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询项目的领导角色
     *
     * @param projectId 项目ID
     * @return 领导角色列表
     */
    List<HitProjectRoleVo> selectLeaderRolesByProjectId(@Param("projectId") Long projectId);

    /**
     * 检查项目角色名称是否存在
     *
     * @param projectId 项目ID
     * @param roleName 角色名称
     * @param excludeRoleId 排除的角色ID
     * @return 是否存在
     */
    boolean checkRoleNameExists(@Param("projectId") Long projectId, 
                               @Param("roleName") String roleName, 
                               @Param("excludeRoleId") Long excludeRoleId);

    /**
     * 根据角色名称查询项目角色
     *
     * @param projectId 项目ID
     * @param roleName 角色名称
     * @return 项目角色
     */
    HitProjectRole selectByProjectIdAndRoleName(@Param("projectId") Long projectId, 
                                              @Param("roleName") String roleName);

    /**
     * 批量更新角色的当前人数
     *
     * @param projectId 项目ID
     * @return 更新结果
     */
    int updateCurrentCountByProjectId(@Param("projectId") Long projectId);

    /**
     * 统计项目角色数量
     *
     * @param projectId 项目ID
     * @param status 状态（可选）
     * @return 角色数量
     */
    Long countRolesByProjectId(@Param("projectId") Long projectId, @Param("status") String status);

    /**
     * 获取项目角色的优先级范围
     *
     * @param projectId 项目ID
     * @return 最大优先级
     */
    Integer getMaxPriorityByProjectId(@Param("projectId") Long projectId);
} 