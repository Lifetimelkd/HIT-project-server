package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitProjectMemberVo;
import org.dromara.hit.project.domain.bo.HitProjectMemberBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 * 项目成员Service接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface IHitProjectMemberService {

    /**
     * 查询项目成员
     */
    HitProjectMemberVo queryById(Long memberId);

    /**
     * 查询项目成员列表
     */
    TableDataInfo<HitProjectMemberVo> queryPageList(HitProjectMemberBo bo, PageQuery pageQuery);

    /**
     * 查询项目成员列表
     */
    List<HitProjectMemberVo> queryList(HitProjectMemberBo bo);

    /**
     * 新增项目成员
     */
    Boolean insertByBo(HitProjectMemberBo bo);

    /**
     * 修改项目成员
     */
    Boolean updateByBo(HitProjectMemberBo bo);

    /**
     * 校验并批量删除项目成员信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    // ==================== 业务接口 ====================

    /**
     * 添加项目成员（通过申请审核后调用）
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @param roleId 角色ID（可选）
     * @param memberRole 成员角色
     * @return 添加结果
     */
    Boolean addProjectMember(Long projectId, Long userId, Long roleId, String memberRole);

    /**
     * 移除项目成员
     *
     * @param memberId 成员ID
     * @param reason 移除原因
     * @return 移除结果
     */
    Boolean removeMember(Long memberId, String reason);

    /**
     * 批量移除项目成员
     *
     * @param memberIds 成员ID列表
     * @param reason 移除原因
     * @return 移除结果
     */
    Boolean batchRemoveMembers(List<Long> memberIds, String reason);

    /**
     * 成员主动退出项目
     *
     * @param projectId 项目ID
     * @param reason 退出原因
     * @return 退出结果
     */
    Boolean leaveProject(Long projectId, String reason);

    /**
     * 更新成员角色
     *
     * @param memberId 成员ID
     * @param roleId 角色ID
     * @param memberRole 成员角色
     * @return 更新结果
     */
    Boolean updateMemberRole(Long memberId, Long roleId, String memberRole);

    /**
     * 设置/取消项目领导者
     *
     * @param memberId 成员ID
     * @param isLeader 是否领导者
     * @return 设置结果
     */
    Boolean setMemberAsLeader(Long memberId, Boolean isLeader);

    /**
     * 更新成员状态
     *
     * @param memberId 成员ID
     * @param memberStatus 成员状态
     * @return 更新结果
     */
    Boolean updateMemberStatus(Long memberId, String memberStatus);

    /**
     * 批量更新成员状态
     *
     * @param memberIds 成员ID列表
     * @param memberStatus 成员状态
     * @return 更新结果
     */
    Boolean batchUpdateMemberStatus(List<Long> memberIds, String memberStatus);

    /**
     * 更新成员表现评分
     *
     * @param memberId 成员ID
     * @param contributionScore 贡献度评分
     * @param performanceRating 表现评分
     * @return 更新结果
     */
    Boolean updateMemberPerformance(Long memberId, BigDecimal contributionScore, BigDecimal performanceRating);

    /**
     * 更新成员任务统计
     *
     * @param memberId 成员ID
     * @param completedTasks 完成任务数
     * @param totalTasks 总任务数
     * @param workHours 工作时长
     * @return 更新结果
     */
    Boolean updateMemberTaskStats(Long memberId, Integer completedTasks, Integer totalTasks, BigDecimal workHours);

    // ==================== 查询接口 ====================

    /**
     * 查询项目的所有成员
     *
     * @param projectId 项目ID
     * @param pageQuery 分页查询
     * @return 成员列表
     */
    TableDataInfo<HitProjectMemberVo> queryProjectMembers(Long projectId, PageQuery pageQuery);

    /**
     * 查询项目的活跃成员
     *
     * @param projectId 项目ID
     * @param pageQuery 分页查询
     * @return 活跃成员列表
     */
    TableDataInfo<HitProjectMemberVo> queryActiveProjectMembers(Long projectId, PageQuery pageQuery);

    /**
     * 查询用户参与的所有项目
     *
     * @param userId 用户ID
     * @param pageQuery 分页查询
     * @return 用户项目列表
     */
    TableDataInfo<HitProjectMemberVo> queryUserProjects(Long userId, PageQuery pageQuery);

    /**
     * 查询用户当前活跃的项目
     *
     * @param userId 用户ID
     * @param pageQuery 分页查询
     * @return 用户活跃项目列表
     */
    TableDataInfo<HitProjectMemberVo> queryUserActiveProjects(Long userId, PageQuery pageQuery);

    /**
     * 查询我参与的所有项目
     *
     * @param pageQuery 分页查询
     * @return 我的项目列表
     */
    TableDataInfo<HitProjectMemberVo> queryMyProjects(PageQuery pageQuery);

    /**
     * 查询我当前活跃的项目
     *
     * @param pageQuery 分页查询
     * @return 我的活跃项目列表
     */
    TableDataInfo<HitProjectMemberVo> queryMyActiveProjects(PageQuery pageQuery);

    /**
     * 查询项目的领导者成员
     *
     * @param projectId 项目ID
     * @return 领导者成员列表
     */
    List<HitProjectMemberVo> queryProjectLeaders(Long projectId);

    // ==================== 统计和验证接口 ====================

    /**
     * 统计项目成员数量
     *
     * @param projectId 项目ID
     * @param memberStatus 成员状态（可选）
     * @return 成员数量
     */
    Long countProjectMembers(Long projectId, String memberStatus);

    /**
     * 检查用户是否为项目成员
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 是否为成员
     */
    Boolean isProjectMember(Long projectId, Long userId);

    /**
     * 检查用户是否为项目领导者
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 是否为领导者
     */
    Boolean isProjectLeader(Long projectId, Long userId);

    /**
     * 检查当前用户是否为项目成员
     *
     * @param projectId 项目ID
     * @return 是否为成员
     */
    Boolean isCurrentUserProjectMember(Long projectId);

    /**
     * 检查当前用户是否为项目领导者
     *
     * @param projectId 项目ID
     * @return 是否为领导者
     */
    Boolean isCurrentUserProjectLeader(Long projectId);

} 