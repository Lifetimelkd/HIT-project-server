package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitProjectMember;
import org.dromara.hit.project.domain.vo.HitProjectMemberVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 项目成员Mapper接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface HitProjectMemberMapper extends BaseMapperPlus<HitProjectMember, HitProjectMemberVo> {

    /**
     * 查询项目成员详情（包含关联信息）
     *
     * @param memberId 成员ID
     * @return 项目成员详情
     */
    HitProjectMemberVo selectMemberWithDetails(@Param("memberId") Long memberId);

    /**
     * 查询项目的所有成员（包含关联信息）
     *
     * @param projectId 项目ID
     * @return 项目成员列表
     */
    List<HitProjectMemberVo> selectMembersByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询项目的活跃成员
     *
     * @param projectId 项目ID
     * @return 活跃成员列表
     */
    List<HitProjectMemberVo> selectActiveMembersByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询用户参与的所有项目成员记录
     *
     * @param userId 用户ID
     * @return 用户成员记录列表
     */
    List<HitProjectMemberVo> selectMembersByUserId(@Param("userId") Long userId);

    /**
     * 查询用户当前活跃的项目成员记录
     *
     * @param userId 用户ID
     * @return 用户活跃成员记录列表
     */
    List<HitProjectMemberVo> selectActiveMembersByUserId(@Param("userId") Long userId);

    /**
     * 统计项目成员数量
     *
     * @param projectId 项目ID
     * @param memberStatus 成员状态（可选）
     * @return 成员数量
     */
    Long countMembersByProject(@Param("projectId") Long projectId, @Param("memberStatus") String memberStatus);

    /**
     * 检查用户是否为项目成员
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 成员记录数量
     */
    Long checkUserIsMember(@Param("projectId") Long projectId, @Param("userId") Long userId);

    /**
     * 检查用户是否为项目领导者
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 领导者记录数量
     */
    Long checkUserIsLeader(@Param("projectId") Long projectId, @Param("userId") Long userId);

    /**
     * 查询项目的领导者成员
     *
     * @param projectId 项目ID
     * @return 领导者成员列表
     */
    List<HitProjectMemberVo> selectLeadersByProjectId(@Param("projectId") Long projectId);

    /**
     * 批量更新成员状态
     *
     * @param memberIds 成员ID列表
     * @param memberStatus 新状态
     * @return 更新记录数
     */
    int batchUpdateMemberStatus(@Param("memberIds") List<Long> memberIds, @Param("memberStatus") String memberStatus);

    /**
     * 更新成员角色
     *
     * @param memberId 成员ID
     * @param roleId 角色ID
     * @param memberRole 成员角色
     * @return 更新记录数
     */
    int updateMemberRole(@Param("memberId") Long memberId, @Param("roleId") Long roleId, @Param("memberRole") String memberRole);

    /**
     * 更新成员领导者状态
     *
     * @param memberId 成员ID
     * @param isLeader 是否领导者
     * @return 更新记录数
     */
    int updateMemberLeaderStatus(@Param("memberId") Long memberId, @Param("isLeader") String isLeader);

    /**
     * 更新成员表现评分
     *
     * @param memberId 成员ID
     * @param contributionScore 贡献度评分
     * @param performanceRating 表现评分
     * @return 更新记录数
     */
    int updateMemberPerformance(@Param("memberId") Long memberId, 
                               @Param("contributionScore") java.math.BigDecimal contributionScore,
                               @Param("performanceRating") java.math.BigDecimal performanceRating);

    /**
     * 更新成员任务统计
     *
     * @param memberId 成员ID
     * @param completedTasks 完成任务数
     * @param totalTasks 总任务数
     * @param workHours 工作时长
     * @return 更新记录数
     */
    int updateMemberTaskStats(@Param("memberId") Long memberId,
                             @Param("completedTasks") Integer completedTasks,
                             @Param("totalTasks") Integer totalTasks,
                             @Param("workHours") java.math.BigDecimal workHours);

} 