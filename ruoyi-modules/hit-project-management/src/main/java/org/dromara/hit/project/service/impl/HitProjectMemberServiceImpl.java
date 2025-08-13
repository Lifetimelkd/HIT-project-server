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
import org.dromara.hit.project.domain.HitProject;
import org.dromara.hit.project.domain.HitProjectMember;
import org.dromara.hit.project.domain.bo.HitProjectMemberBo;
import org.dromara.hit.project.domain.vo.HitProjectMemberVo;
import org.dromara.hit.project.mapper.HitProjectMemberMapper;
import org.dromara.hit.project.mapper.HitProjectMapper;
import org.dromara.hit.project.service.IHitProjectMemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

/**
 * 项目成员Service业务层处理
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@RequiredArgsConstructor
@Service
public class HitProjectMemberServiceImpl implements IHitProjectMemberService {

    private final HitProjectMemberMapper baseMapper;
    private final HitProjectMapper projectMapper;

    /**
     * 查询项目成员
     */
    @Override
    public HitProjectMemberVo queryById(Long memberId) {
        return baseMapper.selectMemberWithDetails(memberId);
    }

    /**
     * 查询项目成员列表
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryPageList(HitProjectMemberBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitProjectMember> lqw = buildQueryWrapper(bo);
        Page<HitProjectMemberVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询项目成员列表
     */
    @Override
    public List<HitProjectMemberVo> queryList(HitProjectMemberBo bo) {
        LambdaQueryWrapper<HitProjectMember> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitProjectMember> buildQueryWrapper(HitProjectMemberBo bo) {
        LambdaQueryWrapper<HitProjectMember> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getProjectId() != null, HitProjectMember::getProjectId, bo.getProjectId());
        lqw.eq(bo.getUserId() != null, HitProjectMember::getUserId, bo.getUserId());
        lqw.eq(bo.getRoleId() != null, HitProjectMember::getRoleId, bo.getRoleId());
        lqw.like(StringUtils.isNotBlank(bo.getMemberRole()), HitProjectMember::getMemberRole, bo.getMemberRole());
        lqw.eq(StringUtils.isNotBlank(bo.getMemberStatus()), HitProjectMember::getMemberStatus, bo.getMemberStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getIsLeader()), HitProjectMember::getIsLeader, bo.getIsLeader());
        lqw.between(bo.getParams().get("beginJoinTime") != null && bo.getParams().get("endJoinTime") != null,
            HitProjectMember::getJoinTime, bo.getParams().get("beginJoinTime"), bo.getParams().get("endJoinTime"));
        lqw.orderByDesc(HitProjectMember::getJoinTime);
        return lqw;
    }

    /**
     * 新增项目成员
     */
    @Override
    public Boolean insertByBo(HitProjectMemberBo bo) {
        HitProjectMember add = MapstructUtils.convert(bo, HitProjectMember.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setMemberId(add.getMemberId());
        }
        return flag;
    }

    /**
     * 修改项目成员
     */
    @Override
    public Boolean updateByBo(HitProjectMemberBo bo) {
        HitProjectMember update = MapstructUtils.convert(bo, HitProjectMember.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitProjectMember entity) {
        // 校验项目和用户的唯一性
        if (entity.getProjectId() != null && entity.getUserId() != null) {
            Long existingCount = baseMapper.checkUserIsMember(entity.getProjectId(), entity.getUserId());
            if (existingCount > 0 && (entity.getMemberId() == null)) {
                throw new RuntimeException("用户已是该项目成员");
            }
        }
    }

    /**
     * 批量删除项目成员
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 校验是否可以删除
            for (Long id : ids) {
                HitProjectMember member = baseMapper.selectById(id);
                if (member != null && "1".equals(member.getIsLeader())) {
                    throw new RuntimeException("不能删除项目领导者");
                }
            }
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    // ==================== 业务接口实现 ====================

    /**
     * 添加项目成员（通过申请审核后调用）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean addProjectMember(Long projectId, Long userId, Long roleId, String memberRole) {
        // 检查项目是否存在
        HitProject project = projectMapper.selectById(projectId);
        if (project == null) {
            throw new RuntimeException("项目不存在");
        }

        // 检查用户是否已是成员
        Long existingCount = baseMapper.checkUserIsMember(projectId, userId);
        if (existingCount > 0) {
            throw new RuntimeException("用户已是该项目成员");
        }

        // 创建成员记录
        HitProjectMember member = new HitProjectMember();
        member.setProjectId(projectId);
        member.setUserId(userId);
        member.setRoleId(roleId);
        member.setMemberRole(StringUtils.isNotBlank(memberRole) ? memberRole : "成员");
        member.setJoinTime(LocalDateTime.now());
        member.setMemberStatus("active");
        member.setContributionScore(BigDecimal.ZERO);
        member.setCompletedTasks(0);
        member.setTotalTasks(0);
        member.setWorkHours(BigDecimal.ZERO);
        member.setPerformanceRating(BigDecimal.ZERO);
        member.setIsLeader("0");

        boolean result = baseMapper.insert(member) > 0;

        // 更新项目成员数量（已在申请审核时更新，这里不重复更新）
        // projectMapper.incrementCurrentMembers(projectId);

        return result;
    }

    /**
     * 移除项目成员
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean removeMember(Long memberId, String reason) {
        Long currentUserId = LoginHelper.getUserId();

        HitProjectMember member = baseMapper.selectById(memberId);
        if (member == null) {
            throw new RuntimeException("成员不存在");
        }

        // 检查权限：项目创建者或管理员可以移除成员
        HitProject project = projectMapper.selectById(member.getProjectId());
        if (!currentUserId.equals(project.getCreatorId())) {
            // 检查是否为项目领导者
            Long leaderCount = baseMapper.checkUserIsLeader(member.getProjectId(), currentUserId);
            if (leaderCount == 0) {
                throw new RuntimeException("只有项目创建者或领导者可以移除成员");
            }
        }

        // 不能移除项目创建者
        if (member.getUserId().equals(project.getCreatorId())) {
            throw new RuntimeException("不能移除项目创建者");
        }

        // 更新成员状态
        member.setMemberStatus("left");
        member.setLeaveTime(LocalDateTime.now());
        member.setRemark(StringUtils.isNotBlank(reason) ? "移除原因：" + reason : "被移除");

        boolean result = baseMapper.updateById(member) > 0;

        // 更新项目成员数量
        if (result) {
            projectMapper.decrementCurrentMembers(member.getProjectId());
        }

        return result;
    }

    /**
     * 批量移除项目成员
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean batchRemoveMembers(List<Long> memberIds, String reason) {
        for (Long memberId : memberIds) {
            removeMember(memberId, reason);
        }
        return true;
    }

    /**
     * 成员主动退出项目
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean leaveProject(Long projectId, String reason) {
        Long currentUserId = LoginHelper.getUserId();

        // 查找当前用户在该项目的成员记录
        LambdaQueryWrapper<HitProjectMember> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitProjectMember::getProjectId, projectId);
        lqw.eq(HitProjectMember::getUserId, currentUserId);
        lqw.eq(HitProjectMember::getMemberStatus, "active");

        HitProjectMember member = baseMapper.selectOne(lqw);
        if (member == null) {
            throw new RuntimeException("您不是该项目的成员");
        }

        // 检查是否为项目创建者
        HitProject project = projectMapper.selectById(projectId);
        if (currentUserId.equals(project.getCreatorId())) {
            throw new RuntimeException("项目创建者不能退出项目");
        }

        // 更新成员状态
        member.setMemberStatus("left");
        member.setLeaveTime(LocalDateTime.now());
        member.setRemark(StringUtils.isNotBlank(reason) ? "退出原因：" + reason : "主动退出");

        boolean result = baseMapper.updateById(member) > 0;

        // 更新项目成员数量
        if (result) {
            projectMapper.decrementCurrentMembers(projectId);
        }

        return result;
    }

    /**
     * 更新成员角色
     */
    @Override
    public Boolean updateMemberRole(Long memberId, Long roleId, String memberRole) {
        return baseMapper.updateMemberRole(memberId, roleId, memberRole) > 0;
    }

    /**
     * 设置/取消项目领导者
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean setMemberAsLeader(Long memberId, Boolean isLeader) {
        Long currentUserId = LoginHelper.getUserId();

        HitProjectMember member = baseMapper.selectById(memberId);
        if (member == null) {
            throw new RuntimeException("成员不存在");
        }

        // 检查权限：只有项目创建者可以设置领导者
        HitProject project = projectMapper.selectById(member.getProjectId());
        if (!currentUserId.equals(project.getCreatorId())) {
            throw new RuntimeException("只有项目创建者可以设置领导者");
        }

        String leaderStatus = isLeader ? "1" : "0";
        return baseMapper.updateMemberLeaderStatus(memberId, leaderStatus) > 0;
    }

    /**
     * 更新成员状态
     */
    @Override
    public Boolean updateMemberStatus(Long memberId, String memberStatus) {
        HitProjectMember member = baseMapper.selectById(memberId);
        if (member == null) {
            throw new RuntimeException("成员不存在");
        }

        member.setMemberStatus(memberStatus);
        if ("left".equals(memberStatus)) {
            member.setLeaveTime(LocalDateTime.now());
        }

        return baseMapper.updateById(member) > 0;
    }

    /**
     * 批量更新成员状态
     */
    @Override
    public Boolean batchUpdateMemberStatus(List<Long> memberIds, String memberStatus) {
        return baseMapper.batchUpdateMemberStatus(memberIds, memberStatus) > 0;
    }

    /**
     * 更新成员表现评分
     */
    @Override
    public Boolean updateMemberPerformance(Long memberId, BigDecimal contributionScore, BigDecimal performanceRating) {
        return baseMapper.updateMemberPerformance(memberId, contributionScore, performanceRating) > 0;
    }

    /**
     * 更新成员任务统计
     */
    @Override
    public Boolean updateMemberTaskStats(Long memberId, Integer completedTasks, Integer totalTasks, BigDecimal workHours) {
        return baseMapper.updateMemberTaskStats(memberId, completedTasks, totalTasks, workHours) > 0;
    }

    // ==================== 查询接口实现 ====================

    /**
     * 查询项目的所有成员
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryProjectMembers(Long projectId, PageQuery pageQuery) {
        List<HitProjectMemberVo> list = baseMapper.selectMembersByProjectId(projectId);
        return buildTableDataInfo(list, pageQuery);
    }

    /**
     * 查询项目的活跃成员
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryActiveProjectMembers(Long projectId, PageQuery pageQuery) {
        List<HitProjectMemberVo> list = baseMapper.selectActiveMembersByProjectId(projectId);
        return buildTableDataInfo(list, pageQuery);
    }

    /**
     * 查询用户参与的所有项目
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryUserProjects(Long userId, PageQuery pageQuery) {
        List<HitProjectMemberVo> list = baseMapper.selectMembersByUserId(userId);
        return buildTableDataInfo(list, pageQuery);
    }

    /**
     * 查询用户当前活跃的项目
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryUserActiveProjects(Long userId, PageQuery pageQuery) {
        List<HitProjectMemberVo> list = baseMapper.selectActiveMembersByUserId(userId);
        return buildTableDataInfo(list, pageQuery);
    }

    /**
     * 查询我参与的所有项目
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryMyProjects(PageQuery pageQuery) {
        Long currentUserId = LoginHelper.getUserId();
        return queryUserProjects(currentUserId, pageQuery);
    }

    /**
     * 查询我当前活跃的项目
     */
    @Override
    public TableDataInfo<HitProjectMemberVo> queryMyActiveProjects(PageQuery pageQuery) {
        Long currentUserId = LoginHelper.getUserId();
        return queryUserActiveProjects(currentUserId, pageQuery);
    }

    /**
     * 查询项目的领导者成员
     */
    @Override
    public List<HitProjectMemberVo> queryProjectLeaders(Long projectId) {
        return baseMapper.selectLeadersByProjectId(projectId);
    }

    // ==================== 统计和验证接口实现 ====================

    /**
     * 统计项目成员数量
     */
    @Override
    public Long countProjectMembers(Long projectId, String memberStatus) {
        return baseMapper.countMembersByProject(projectId, memberStatus);
    }

    /**
     * 检查用户是否为项目成员
     */
    @Override
    public Boolean isProjectMember(Long projectId, Long userId) {
        Long count = baseMapper.checkUserIsMember(projectId, userId);
        return count > 0;
    }

    /**
     * 检查用户是否为项目领导者
     */
    @Override
    public Boolean isProjectLeader(Long projectId, Long userId) {
        Long count = baseMapper.checkUserIsLeader(projectId, userId);
        return count > 0;
    }

    /**
     * 检查当前用户是否为项目成员
     */
    @Override
    public Boolean isCurrentUserProjectMember(Long projectId) {
        Long currentUserId = LoginHelper.getUserId();
        return isProjectMember(projectId, currentUserId);
    }

    /**
     * 检查当前用户是否为项目领导者
     */
    @Override
    public Boolean isCurrentUserProjectLeader(Long projectId) {
        Long currentUserId = LoginHelper.getUserId();
        return isProjectLeader(projectId, currentUserId);
    }

    /**
     * 构建分页数据
     */
    private TableDataInfo<HitProjectMemberVo> buildTableDataInfo(List<HitProjectMemberVo> list, PageQuery pageQuery) {
        int total = list.size();
        // 添加null检查，如果pageQuery为null或pageNum为null，则使用默认值
        int pageNum = (pageQuery != null && pageQuery.getPageNum() != null) ? pageQuery.getPageNum() : PageQuery.DEFAULT_PAGE_NUM;
        int pageSize = (pageQuery != null && pageQuery.getPageSize() != null) ? pageQuery.getPageSize() : PageQuery.DEFAULT_PAGE_SIZE;
        
        int start = (pageNum - 1) * pageSize;
        int end = Math.min(start + pageSize, total);

        List<HitProjectMemberVo> pageList = start < total ? list.subList(start, end) : List.of();

        TableDataInfo<HitProjectMemberVo> dataInfo = new TableDataInfo<>();
        dataInfo.setCode(200);
        dataInfo.setMsg("查询成功");
        dataInfo.setRows(pageList);
        dataInfo.setTotal((long) total);
        return dataInfo;
    }

} 