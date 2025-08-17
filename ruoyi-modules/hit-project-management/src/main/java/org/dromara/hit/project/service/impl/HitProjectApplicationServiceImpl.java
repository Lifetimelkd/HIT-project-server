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
import org.dromara.hit.project.domain.HitProjectApplication;
import org.dromara.hit.project.domain.bo.HitProjectApplicationBo;
import org.dromara.hit.project.domain.vo.HitProjectApplicationVo;
import org.dromara.hit.project.mapper.HitProjectApplicationMapper;
import org.dromara.hit.project.mapper.HitProjectMapper;
import org.dromara.hit.project.service.IHitProjectApplicationService;
import org.dromara.hit.project.service.IHitProjectMemberService;
import org.dromara.hit.project.service.IHitProjectRoleService;
import org.dromara.system.service.ISysNoticeService;
import org.dromara.system.domain.bo.SysNoticeBo;
import org.dromara.common.sse.utils.SseMessageUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Set;

/**
 * 项目申请Service业务层处理
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@RequiredArgsConstructor
@Service
public class HitProjectApplicationServiceImpl implements IHitProjectApplicationService {

    private final HitProjectApplicationMapper baseMapper;
    private final HitProjectMapper projectMapper ;
    private final IHitProjectMemberService memberService;
    private final IHitProjectRoleService roleService;
    private final ISysNoticeService noticeService;

    /**
     * 查询项目申请
     */
    @Override
    public HitProjectApplicationVo queryById(Long applicationId) {
        return baseMapper.selectApplicationWithDetails(applicationId);
    }

    /**
     * 查询项目申请列表
     */
    @Override
    public TableDataInfo<HitProjectApplicationVo> queryPageList(HitProjectApplicationBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitProjectApplication> lqw = buildQueryWrapper(bo);
        Page<HitProjectApplicationVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询项目申请列表
     */
    @Override
    public List<HitProjectApplicationVo> queryList(HitProjectApplicationBo bo) {
        LambdaQueryWrapper<HitProjectApplication> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitProjectApplication> buildQueryWrapper(HitProjectApplicationBo bo) {
        LambdaQueryWrapper<HitProjectApplication> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getProjectId() != null, HitProjectApplication::getProjectId, bo.getProjectId());
        lqw.eq(bo.getUserId() != null, HitProjectApplication::getUserId, bo.getUserId());
        lqw.eq(bo.getRoleId() != null, HitProjectApplication::getRoleId, bo.getRoleId());
        lqw.like(StringUtils.isNotBlank(bo.getApplicationReason()), HitProjectApplication::getApplicationReason, bo.getApplicationReason());
        lqw.eq(StringUtils.isNotBlank(bo.getApplicationStatus()), HitProjectApplication::getApplicationStatus, bo.getApplicationStatus());
        lqw.eq(bo.getReviewerId() != null, HitProjectApplication::getReviewerId, bo.getReviewerId());
        lqw.between(bo.getParams().get("beginCreateTime") != null && bo.getParams().get("endCreateTime") != null,
            HitProjectApplication::getCreateTime, bo.getParams().get("beginCreateTime"), bo.getParams().get("endCreateTime"));
        lqw.orderByDesc(HitProjectApplication::getCreateTime);
        return lqw;
    }

    /**
     * 新增项目申请
     */
    @Override
    public Boolean insertByBo(HitProjectApplicationBo bo) {
        HitProjectApplication add = MapstructUtils.convert(bo, HitProjectApplication.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setApplicationId(add.getApplicationId());
        }
        return flag;
    }

    /**
     * 修改项目申请
     */
    @Override
    public Boolean updateByBo(HitProjectApplicationBo bo) {
        HitProjectApplication update = MapstructUtils.convert(bo, HitProjectApplication.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitProjectApplication entity) {
        // TODO 做一些数据校验，如唯一约束
    }

    /**
     * 批量删除项目申请
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验，判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 申请加入项目
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean applyToProject(HitProjectApplicationBo bo) {
        Long currentUserId = LoginHelper.getUserId();

        // 检查项目是否存在且可申请
        HitProject project = projectMapper.selectById(bo.getProjectId());
        if (project == null) {
            throw new RuntimeException("项目不存在");
        }
        if (!"open".equals(project.getRecruitmentStatus())) {
            throw new RuntimeException("项目暂不接受申请");
        }
        if (currentUserId.equals(project.getCreatorId())) {
            throw new RuntimeException("不能申请自己创建的项目");
        }

        // 检查是否已申请
        Long existingCount = baseMapper.checkUserApplicationExists(bo.getProjectId(), currentUserId);
        if (existingCount > 0) {
            throw new RuntimeException("您已申请过该项目");
        }

        // 创建申请
        bo.setUserId(currentUserId);
        bo.setApplicationStatus("pending");
        bo.setPriorityScore(calculatePriorityScore(bo));

        HitProjectApplication application = MapstructUtils.convert(bo, HitProjectApplication.class);
        boolean result = baseMapper.insert(application) > 0;

        // 更新项目申请数量
        if (result) {
            projectMapper.incrementApplyCount(bo.getProjectId());
        }

        return result;
    }

    /**
     * 撤回申请
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean withdrawApplication(Long applicationId) {
        Long currentUserId = LoginHelper.getUserId();

        HitProjectApplication application = baseMapper.selectById(applicationId);
        if (application == null) {
            throw new RuntimeException("申请不存在");
        }
        if (!currentUserId.equals(application.getUserId())) {
            throw new RuntimeException("只能撤回自己的申请");
        }
        if (!"pending".equals(application.getApplicationStatus()) && !"reviewing".equals(application.getApplicationStatus())) {
            throw new RuntimeException("当前状态不允许撤回");
        }

        application.setApplicationStatus("withdrawn");

        return baseMapper.updateById(application) > 0;
    }

    /**
     * 审核申请
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean reviewApplication(Long applicationId, String status, String reviewResult) {
        Long currentUserId = LoginHelper.getUserId();

        HitProjectApplication application = baseMapper.selectById(applicationId);
        if (application == null) {
            throw new RuntimeException("申请不存在");
        }

        // 检查权限：只有项目创建者可以审核
        HitProject project = projectMapper.selectById(application.getProjectId());
        if (!currentUserId.equals(project.getCreatorId())) {
            throw new RuntimeException("只有项目创建者可以审核申请");
        }

        if (!"pending".equals(application.getApplicationStatus()) && !"reviewing".equals(application.getApplicationStatus())) {
            throw new RuntimeException("当前状态不允许审核");
        }

        application.setApplicationStatus(status);
        application.setReviewResult(reviewResult);
        application.setReviewTime(LocalDateTime.now());
        application.setReviewerId(currentUserId);

        boolean result = baseMapper.updateById(application) > 0;

        // 如果通过申请，添加到项目成员表
        if (result && "approved".equals(status)) {
            try {
                memberService.addProjectMember(
                    application.getProjectId(),
                    application.getUserId(),
                    application.getRoleId(),
                    "成员"
                );

                // 更新项目角色计数
                roleService.updateCurrentCountByProjectId(application.getProjectId());

                // 更新项目当前成员数
                projectMapper.incrementCurrentMembers(application.getProjectId());

            } catch (Exception e) {
                // 如果添加成员失败，记录日志但不影响审核结果
                // 因为成员数量已在申请审核时更新
                throw new RuntimeException("审核通过但添加成员失败：" + e.getMessage());
            }
        }

        // 发送通知
        if (result) {
            try {
                System.out.println("开始发送项目申请审核通知 - 申请ID: " + applicationId + ", 用户ID: " + application.getUserId() + ", 状态: " + status);
                // 为申请人发送个人通知
                sendApplicationNotification(application.getUserId(), project, status, reviewResult, applicationId);
                System.out.println("项目申请审核通知发送完成 - 申请ID: " + applicationId);
            } catch (Exception e) {
                // 通知发送失败不影响主流程
                System.err.println("发送项目申请审核通知失败 - 申请ID: " + applicationId + ", 错误: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return result;
    }

    /**
     * 批量审核申请
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean batchReviewApplications(List<Long> applicationIds, String status, String reviewResult) {
        Long currentUserId = LoginHelper.getUserId();

        // 验证权限和状态
        for (Long applicationId : applicationIds) {
            HitProjectApplication application = baseMapper.selectById(applicationId);
            if (application == null) {
                throw new RuntimeException("申请ID " + applicationId + " 不存在");
            }

            HitProject project = projectMapper.selectById(application.getProjectId());
            if (!currentUserId.equals(project.getCreatorId())) {
                throw new RuntimeException("只有项目创建者可以审核申请");
            }
        }

        // 批量更新
        int updateCount = baseMapper.batchUpdateApplicationStatus(applicationIds, status, currentUserId);

        // 如果通过申请，添加到项目成员表
        if ("approved".equals(status)) {
            for (Long applicationId : applicationIds) {
                HitProjectApplication application = baseMapper.selectById(applicationId);
                try {
                    memberService.addProjectMember(
                        application.getProjectId(),
                        application.getUserId(),
                        application.getRoleId(),
                        "成员"
                    );
                } catch (Exception e) {
                    // 记录失败但继续处理其他申请
                    System.err.println("添加成员失败 - 申请ID: " + applicationId + ", 错误: " + e.getMessage());
                }
            }

            // 批量更新完成后，更新所有相关项目的角色计数和成员数
            Set<Long> projectIds = new HashSet<>();
            for (Long applicationId : applicationIds) {
                HitProjectApplication application = baseMapper.selectById(applicationId);
                projectIds.add(application.getProjectId());
            }

            // 更新每个项目的角色计数和成员数
            for (Long projectId : projectIds) {
                try {
                    roleService.updateCurrentCountByProjectId(projectId);
                    projectMapper.incrementCurrentMembers(projectId);
                } catch (Exception e) {
                    System.err.println("更新项目统计失败 - 项目ID: " + projectId + ", 错误: " + e.getMessage());
                }
            }
        }

        // 发送批量通知
        if (updateCount > 0) {
            System.out.println("开始发送批量项目申请审核通知 - 申请数量: " + applicationIds.size() + ", 状态: " + status);
            for (Long applicationId : applicationIds) {
                try {
                    HitProjectApplication application = baseMapper.selectById(applicationId);
                    HitProject project = projectMapper.selectById(application.getProjectId());

                    System.out.println("发送批量通知 - 申请ID: " + applicationId + ", 用户ID: " + application.getUserId());
                    // 为申请人发送个人通知
                    sendApplicationNotification(application.getUserId(), project, status, reviewResult, applicationId);
                } catch (Exception e) {
                    // 通知发送失败不影响主流程
                    System.err.println("发送批量通知失败 - 申请ID: " + applicationId + ", 错误: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            System.out.println("批量项目申请审核通知发送完成");
        }

        return updateCount > 0;
    }

    /**
     * 查询项目的所有申请
     */
    @Override
    public TableDataInfo<HitProjectApplicationVo> queryProjectApplications(Long projectId, PageQuery pageQuery) {
        List<HitProjectApplicationVo> list = baseMapper.selectApplicationsByProjectId(projectId);
        // 手动分页处理
        int total = list.size();
        int pageNum = pageQuery.getPageNum();
        int pageSize = pageQuery.getPageSize();
        int start = (pageNum - 1) * pageSize;
        int end = Math.min(start + pageSize, total);

        List<HitProjectApplicationVo> pageList = start < total ? list.subList(start, end) : List.of();

        TableDataInfo<HitProjectApplicationVo> dataInfo = new TableDataInfo<>();
        dataInfo.setCode(200);
        dataInfo.setMsg("查询成功");
        dataInfo.setRows(pageList);
        dataInfo.setTotal((long) total);
        return dataInfo;
    }

    /**
     * 查询用户的所有申请
     */
    @Override
    public TableDataInfo<HitProjectApplicationVo> queryUserApplications(Long userId, PageQuery pageQuery) {
        List<HitProjectApplicationVo> list = baseMapper.selectApplicationsByUserId(userId);
        // 手动分页处理
        int total = list.size();
        int pageNum = pageQuery.getPageNum();
        int pageSize = pageQuery.getPageSize();
        int start = (pageNum - 1) * pageSize;
        int end = Math.min(start + pageSize, total);

        List<HitProjectApplicationVo> pageList = start < total ? list.subList(start, end) : List.of();

        TableDataInfo<HitProjectApplicationVo> dataInfo = new TableDataInfo<>();
        dataInfo.setCode(200);
        dataInfo.setMsg("查询成功");
        dataInfo.setRows(pageList);
        dataInfo.setTotal((long) total);
        return dataInfo;
    }

    /**
     * 查询当前用户的所有申请
     */
    @Override
    public TableDataInfo<HitProjectApplicationVo> queryMyApplications(PageQuery pageQuery) {
        Long currentUserId = LoginHelper.getUserId();
        return queryUserApplications(currentUserId, pageQuery);
    }

    /**
     * 查询我创建项目的所有申请
     */
    @Override
    public TableDataInfo<HitProjectApplicationVo> queryMyProjectApplications(PageQuery pageQuery) {
        Long currentUserId = LoginHelper.getUserId();

        LambdaQueryWrapper<HitProjectApplication> lqw = Wrappers.lambdaQuery();
        lqw.inSql(HitProjectApplication::getProjectId,
            "SELECT project_id FROM hit_project WHERE creator_id = " + currentUserId);
        lqw.orderByDesc(HitProjectApplication::getCreateTime);

        Page<HitProjectApplicationVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 检查用户是否已申请该项目
     */
    @Override
    public Boolean hasUserApplied(Long projectId, Long userId) {
        Long count = baseMapper.checkUserApplicationExists(projectId, userId);
        return count > 0;
    }

    /**
     * 统计项目待审核申请数量
     */
    @Override
    public Long countPendingApplications(Long projectId) {
        return baseMapper.countPendingApplications(projectId);
    }

    /**
     * 计算申请优先级评分
     */
    private java.math.BigDecimal calculatePriorityScore(HitProjectApplicationBo bo) {
        // 简单的评分逻辑，可以根据需要扩展
        double score = 0.0;

        // 根据申请理由长度给分
        if (StringUtils.isNotBlank(bo.getApplicationReason())) {
            score += Math.min(bo.getApplicationReason().length() / 100.0, 10.0);
        }

        // 根据相关经验给分
        if (StringUtils.isNotBlank(bo.getRelevantExperience())) {
            score += Math.min(bo.getRelevantExperience().length() / 100.0, 10.0);
        }

        // 有简历或作品集加分
        if (StringUtils.isNotBlank(bo.getResumeUrl())) {
            score += 5.0;
        }
        if (StringUtils.isNotBlank(bo.getPortfolioUrl())) {
            score += 5.0;
        }

        return java.math.BigDecimal.valueOf(Math.min(score, 100.0));
    }

    /**
     * 发送项目申请通知
     */
    private void sendApplicationNotification(Long userId, HitProject project, String status, String reviewResult, Long applicationId) {
        try {
            // 创建系统通知
            SysNoticeBo noticeBo = new SysNoticeBo();
            noticeBo.setNoticeType("1"); // 1通知 2公告
            noticeBo.setStatus("0"); // 0正常 1关闭

            String noticeTitle;
            String noticeContent;
            String sseMessage;

            if ("approved".equals(status)) {
                noticeTitle = "项目申请通过通知";
                noticeContent = String.format("恭喜！您申请加入项目「%s」的申请已通过审核。%s",
                    project.getProjectName(),
                    StringUtils.isNotBlank(reviewResult) ? "\n审核意见：" + reviewResult : "");
                // SSE消息也包含审核意见
                sseMessage = String.format("[项目申请通过] 您申请加入项目「%s」的申请已通过审核%s",
                    project.getProjectName(),
                    StringUtils.isNotBlank(reviewResult) ? "，审核意见：" + reviewResult : "");
            } else if ("rejected".equals(status)) {
                noticeTitle = "项目申请拒绝通知";
                noticeContent = String.format("很遗憾，您申请加入项目「%s」的申请未通过审核。%s",
                    project.getProjectName(),
                    StringUtils.isNotBlank(reviewResult) ? "\n拒绝理由：" + reviewResult : "");
                // SSE消息也包含拒绝理由
                sseMessage = String.format("[项目申请拒绝] 您申请加入项目「%s」的申请未通过审核%s",
                    project.getProjectName(),
                    StringUtils.isNotBlank(reviewResult) ? "，拒绝理由：" + reviewResult : "");
            } else {
                // 其他状态不发送通知
                return;
            }

            noticeBo.setNoticeTitle(noticeTitle);
            noticeBo.setNoticeContent(noticeContent);
            noticeBo.setRemark("项目申请审核通知 - 申请ID:" + applicationId + ", 用户ID:" + userId);

            // 保存系统通知到数据库
            int result = noticeService.insertNotice(noticeBo);

            if (result > 0) {
                // 发送SSE实时通知给指定用户
                try {
                    SseMessageUtils.sendMessage(userId, sseMessage);
                    System.out.println("SSE通知发送成功 - 用户ID: " + userId + ", 消息: " + sseMessage);
                } catch (Exception sseException) {
                    System.err.println("SSE通知发送失败 - 用户ID: " + userId + ", 错误: " + sseException.getMessage());
                }

                System.out.println("项目申请通知发送成功 - 用户ID: " + userId + ", 申请ID: " + applicationId + ", 状态: " + status);
            } else {
                System.err.println("系统通知保存失败 - 用户ID: " + userId + ", 申请ID: " + applicationId);
            }

        } catch (Exception e) {
            System.err.println("发送项目申请通知失败 - 用户ID: " + userId + ", 申请ID: " + applicationId + ", 错误: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
