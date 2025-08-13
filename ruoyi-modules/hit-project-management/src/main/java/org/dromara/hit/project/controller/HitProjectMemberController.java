package org.dromara.hit.project.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.hit.project.domain.bo.HitProjectMemberBo;
import org.dromara.hit.project.domain.vo.HitProjectMemberVo;
import org.dromara.hit.project.service.IHitProjectMemberService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

/**
 * 项目成员控制器
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project/member")
public class HitProjectMemberController extends BaseController {

    private final IHitProjectMemberService memberService;

    /**
     * 查询项目成员列表
     */
    @SaCheckPermission("hit:project:member:list")
    @GetMapping("/list")
    public TableDataInfo<HitProjectMemberVo> list(HitProjectMemberBo bo, PageQuery pageQuery) {
        return memberService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出项目成员列表
     */
    @SaCheckPermission("hit:project:member:export")
    @Log(title = "项目成员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitProjectMemberBo bo, HttpServletResponse response) {
        List<HitProjectMemberVo> list = memberService.queryList(bo);
        ExcelUtil.exportExcel(list, "项目成员", HitProjectMemberVo.class, response);
    }

    /**
     * 获取项目成员详细信息
     */
    @SaCheckPermission("hit:project:member:query")
    @GetMapping("/{memberId}")
    public R<HitProjectMemberVo> getInfo(@PathVariable Long memberId) {
        return R.ok(memberService.queryById(memberId));
    }

    /**
     * 新增项目成员
     */
    @SaCheckPermission("hit:project:member:add")
    @Log(title = "项目成员", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitProjectMemberBo bo) {
        return toAjax(memberService.insertByBo(bo));
    }

    /**
     * 修改项目成员
     */
    @SaCheckPermission("hit:project:member:edit")
    @Log(title = "项目成员", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitProjectMemberBo bo) {
        return toAjax(memberService.updateByBo(bo));
    }

    /**
     * 删除项目成员
     */
    @SaCheckPermission("hit:project:member:remove")
    @Log(title = "项目成员", businessType = BusinessType.DELETE)
    @DeleteMapping("/{memberIds}")
    public R<Void> remove(@PathVariable Long[] memberIds) {
        return toAjax(memberService.deleteWithValidByIds(List.of(memberIds), true));
    }

    // ==================== 业务接口 ====================

    /**
     * 添加项目成员
     */
    @SaCheckPermission("hit:project:member:add")
    @Log(title = "添加项目成员", businessType = BusinessType.INSERT)
    @PostMapping("/add-member")
    public R<Void> addProjectMember(@RequestParam Long projectId,
                                  @RequestParam Long userId,
                                  @RequestParam(required = false) Long roleId,
                                  @RequestParam(required = false) String memberRole) {
        return toAjax(memberService.addProjectMember(projectId, userId, roleId, memberRole));
    }

    /**
     * 移除项目成员
     */
    @SaCheckPermission("hit:project:member:remove")
    @Log(title = "移除项目成员", businessType = BusinessType.UPDATE)
    @PutMapping("/remove/{memberId}")
    public R<Void> removeMember(@PathVariable Long memberId, 
                               @RequestParam(required = false) String reason) {
        return toAjax(memberService.removeMember(memberId, reason));
    }

    /**
     * 批量移除项目成员
     */
    @SaCheckPermission("hit:project:member:remove")
    @Log(title = "批量移除项目成员", businessType = BusinessType.UPDATE)
    @PutMapping("/batch-remove")
    public R<Void> batchRemoveMembers(@RequestParam List<Long> memberIds,
                                    @RequestParam(required = false) String reason) {
        return toAjax(memberService.batchRemoveMembers(memberIds, reason));
    }

    /**
     * 退出项目
     */
    @Log(title = "退出项目", businessType = BusinessType.UPDATE)
    @PutMapping("/leave/{projectId}")
    public R<Void> leaveProject(@PathVariable Long projectId,
                               @RequestParam(required = false) String reason) {
        return toAjax(memberService.leaveProject(projectId, reason));
    }

    /**
     * 更新成员角色
     */
    @SaCheckPermission("hit:project:member:edit")
    @Log(title = "更新成员角色", businessType = BusinessType.UPDATE)
    @PutMapping("/role/{memberId}")
    public R<Void> updateMemberRole(@PathVariable Long memberId,
                                   @RequestParam(required = false) Long roleId,
                                   @RequestParam String memberRole) {
        return toAjax(memberService.updateMemberRole(memberId, roleId, memberRole));
    }

    /**
     * 设置/取消项目领导者
     */
    @SaCheckPermission("hit:project:member:leader")
    @Log(title = "设置项目领导者", businessType = BusinessType.UPDATE)
    @PutMapping("/leader/{memberId}")
    public R<Void> setMemberAsLeader(@PathVariable Long memberId,
                                    @RequestParam Boolean isLeader) {
        return toAjax(memberService.setMemberAsLeader(memberId, isLeader));
    }

    /**
     * 更新成员状态
     */
    @SaCheckPermission("hit:project:member:edit")
    @Log(title = "更新成员状态", businessType = BusinessType.UPDATE)
    @PutMapping("/status/{memberId}")
    public R<Void> updateMemberStatus(@PathVariable Long memberId,
                                     @RequestParam String memberStatus) {
        return toAjax(memberService.updateMemberStatus(memberId, memberStatus));
    }

    /**
     * 批量更新成员状态
     */
    @SaCheckPermission("hit:project:member:edit")
    @Log(title = "批量更新成员状态", businessType = BusinessType.UPDATE)
    @PutMapping("/batch-status")
    public R<Void> batchUpdateMemberStatus(@RequestParam List<Long> memberIds,
                                          @RequestParam String memberStatus) {
        return toAjax(memberService.batchUpdateMemberStatus(memberIds, memberStatus));
    }

    /**
     * 更新成员表现评分
     */
    @SaCheckPermission("hit:project:member:evaluate")
    @Log(title = "更新成员表现评分", businessType = BusinessType.UPDATE)
    @PutMapping("/performance/{memberId}")
    public R<Void> updateMemberPerformance(@PathVariable Long memberId,
                                          @RequestParam BigDecimal contributionScore,
                                          @RequestParam BigDecimal performanceRating) {
        return toAjax(memberService.updateMemberPerformance(memberId, contributionScore, performanceRating));
    }

    /**
     * 更新成员任务统计
     */
    @SaCheckPermission("hit:project:member:edit")
    @Log(title = "更新成员任务统计", businessType = BusinessType.UPDATE)
    @PutMapping("/task-stats/{memberId}")
    public R<Void> updateMemberTaskStats(@PathVariable Long memberId,
                                        @RequestParam Integer completedTasks,
                                        @RequestParam Integer totalTasks,
                                        @RequestParam BigDecimal workHours) {
        return toAjax(memberService.updateMemberTaskStats(memberId, completedTasks, totalTasks, workHours));
    }

    // ==================== 查询接口 ====================

    /**
     * 查询项目的所有成员
     */
    @GetMapping("/project/{projectId}")
    public TableDataInfo<HitProjectMemberVo> getProjectMembers(@PathVariable Long projectId, PageQuery pageQuery) {
        return memberService.queryProjectMembers(projectId, pageQuery);
    }

    /**
     * 查询项目的活跃成员
     */
    @GetMapping("/project/{projectId}/active")
    public TableDataInfo<HitProjectMemberVo> getActiveProjectMembers(@PathVariable Long projectId, PageQuery pageQuery) {
        return memberService.queryActiveProjectMembers(projectId, pageQuery);
    }

    /**
     * 查询用户参与的所有项目
     */
    @GetMapping("/user/{userId}")
    public TableDataInfo<HitProjectMemberVo> getUserProjects(@PathVariable Long userId, PageQuery pageQuery) {
        return memberService.queryUserProjects(userId, pageQuery);
    }

    /**
     * 查询用户当前活跃的项目
     */
    @GetMapping("/user/{userId}/active")
    public TableDataInfo<HitProjectMemberVo> getUserActiveProjects(@PathVariable Long userId, PageQuery pageQuery) {
        return memberService.queryUserActiveProjects(userId, pageQuery);
    }

    /**
     * 查询我参与的所有项目
     */
    @GetMapping("/my")
    public TableDataInfo<HitProjectMemberVo> getMyProjects(PageQuery pageQuery) {
        return memberService.queryMyProjects(pageQuery);
    }

    /**
     * 查询我当前活跃的项目
     */
    @GetMapping("/my/active")
    public TableDataInfo<HitProjectMemberVo> getMyActiveProjects(PageQuery pageQuery) {
        return memberService.queryMyActiveProjects(pageQuery);
    }

    /**
     * 查询项目的领导者成员
     */
    @GetMapping("/project/{projectId}/leaders")
    public R<List<HitProjectMemberVo>> getProjectLeaders(@PathVariable Long projectId) {
        return R.ok(memberService.queryProjectLeaders(projectId));
    }

    // ==================== 统计和验证接口 ====================

    /**
     * 统计项目成员数量
     */
    @GetMapping("/count/{projectId}")
    public R<Long> countProjectMembers(@PathVariable Long projectId,
                                      @RequestParam(required = false) String memberStatus) {
        return R.ok(memberService.countProjectMembers(projectId, memberStatus));
    }

    /**
     * 检查用户是否为项目成员
     */
    @GetMapping("/check-member/{projectId}")
    public R<Boolean> isProjectMember(@PathVariable Long projectId,
                                     @RequestParam(required = false) Long userId) {
        if (userId != null) {
            return R.ok(memberService.isProjectMember(projectId, userId));
        } else {
            return R.ok(memberService.isCurrentUserProjectMember(projectId));
        }
    }

    /**
     * 检查用户是否为项目领导者
     */
    @GetMapping("/check-leader/{projectId}")
    public R<Boolean> isProjectLeader(@PathVariable Long projectId,
                                     @RequestParam(required = false) Long userId) {
        if (userId != null) {
            return R.ok(memberService.isProjectLeader(projectId, userId));
        } else {
            return R.ok(memberService.isCurrentUserProjectLeader(projectId));
        }
    }

    // ==================== 公开接口（无需权限）====================

    /**
     * 公开接口：查询项目成员统计信息
     */
    @GetMapping("/public/stats/{projectId}")
    public R<MemberStatsVo> getMemberStats(@PathVariable Long projectId) {
        Long totalMembers = memberService.countProjectMembers(projectId, null);
        Long activeMembers = memberService.countProjectMembers(projectId, "active");
        List<HitProjectMemberVo> leaders = memberService.queryProjectLeaders(projectId);

        MemberStatsVo stats = new MemberStatsVo();
        stats.setTotalMembers(totalMembers);
        stats.setActiveMembers(activeMembers);
        stats.setLeaderCount((long) leaders.size());
        return R.ok(stats);
    }

    /**
     * 成员统计信息VO
     */
    public static class MemberStatsVo {
        private Long totalMembers;
        private Long activeMembers;
        private Long leaderCount;

        public Long getTotalMembers() {
            return totalMembers;
        }

        public void setTotalMembers(Long totalMembers) {
            this.totalMembers = totalMembers;
        }

        public Long getActiveMembers() {
            return activeMembers;
        }

        public void setActiveMembers(Long activeMembers) {
            this.activeMembers = activeMembers;
        }

        public Long getLeaderCount() {
            return leaderCount;
        }

        public void setLeaderCount(Long leaderCount) {
            this.leaderCount = leaderCount;
        }
    }

} 