package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitProject;
import org.dromara.hit.project.domain.vo.HitProjectVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * 项目信息Mapper接口
 *
 * @author HIT
 * @date 2025-01-15
 */
public interface HitProjectMapper extends BaseMapperPlus<HitProject, HitProjectVo> {

    /**
     * 增加项目申请数量
     *
     * @param projectId 项目ID
     * @return 更新记录数
     */
    @Update("UPDATE hit_project SET apply_count = apply_count + 1 WHERE project_id = #{projectId}")
    int incrementApplyCount(@Param("projectId") Long projectId);

    /**
     * 增加项目当前成员数量
     *
     * @param projectId 项目ID
     * @return 更新记录数
     */
    @Update("UPDATE hit_project SET current_members = current_members + 1 WHERE project_id = #{projectId}")
    int incrementCurrentMembers(@Param("projectId") Long projectId);

    /**
     * 减少项目当前成员数量
     *
     * @param projectId 项目ID
     * @return 更新记录数
     */
    @Update("UPDATE hit_project SET current_members = current_members - 1 WHERE project_id = #{projectId} AND current_members > 0")
    int decrementCurrentMembers(@Param("projectId") Long projectId);

    /**
     * 检查用户是否收藏了项目
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 收藏记录数量，> 0 表示已收藏
     */
    @org.apache.ibatis.annotations.Select("SELECT COUNT(*) FROM hit_project_collection WHERE project_id = #{projectId} AND user_id = #{userId}")
    Long checkUserCollected(@Param("projectId") Long projectId, @Param("userId") Long userId);

} 