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
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.hit.project.domain.bo.HitProjectApplicationBo;
import org.dromara.hit.project.domain.vo.HitProjectApplicationVo;
import org.dromara.hit.project.service.IHitProjectApplicationService;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 项目申请控制器
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project/application")
public class HitProjectApplicationController extends BaseController {

    private final IHitProjectApplicationService applicationService;

    /**
     * 查询项目申请列表
     */
    @SaCheckPermission("hit:project:application:list")
    @GetMapping("/list")
    public TableDataInfo<HitProjectApplicationVo> list(HitProjectApplicationBo bo, PageQuery pageQuery) {
        return applicationService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出项目申请列表
     */
    @SaCheckPermission("hit:project:application:export")
    @Log(title = "项目申请", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitProjectApplicationBo bo, HttpServletResponse response) {
        List<HitProjectApplicationVo> list = applicationService.queryList(bo);
        ExcelUtil.exportExcel(list, "项目申请", HitProjectApplicationVo.class, response);
    }

    /**
     * 获取项目申请详细信息
     */
    @SaCheckPermission("hit:project:application:query")
    @GetMapping("/{applicationId}")
    public R<HitProjectApplicationVo> getInfo(@PathVariable Long applicationId) {
        return R.ok(applicationService.queryById(applicationId));
    }

    /**
     * 新增项目申请
     */
    @SaCheckPermission("hit:project:application:add")
    @Log(title = "项目申请", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitProjectApplicationBo bo) {
        return toAjax(applicationService.insertByBo(bo));
    }

    /**
     * 修改项目申请
     */
    @SaCheckPermission("hit:project:application:edit")
    @Log(title = "项目申请", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitProjectApplicationBo bo) {
        return toAjax(applicationService.updateByBo(bo));
    }

    /**
     * 删除项目申请
     */
    @SaCheckPermission("hit:project:application:remove")
    @Log(title = "项目申请", businessType = BusinessType.DELETE)
    @DeleteMapping("/{applicationIds}")
    public R<Void> remove(@PathVariable Long[] applicationIds) {
        return toAjax(applicationService.deleteWithValidByIds(List.of(applicationIds), true));
    }

    // ==================== 业务接口 ====================

    /**
     * 申请加入项目
     */
    @Log(title = "申请加入项目", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping("/apply")
    public R<Void> applyToProject(@Validated(AddGroup.class) @RequestBody HitProjectApplicationBo bo) {
        return toAjax(applicationService.applyToProject(bo));
    }

    /**
     * 撤回申请
     */
    @Log(title = "撤回申请", businessType = BusinessType.UPDATE)
    @PutMapping("/withdraw/{applicationId}")
    public R<Void> withdrawApplication(@PathVariable Long applicationId) {
        return toAjax(applicationService.withdrawApplication(applicationId));
    }

    /**
     * 审核申请
     */
    @SaCheckPermission("hit:project:application:review")
    @Log(title = "审核申请", businessType = BusinessType.UPDATE)
    @PutMapping("/review/{applicationId}")
    public R<Void> reviewApplication(@PathVariable Long applicationId,
                                   @RequestParam String status,
                                   @RequestParam(required = false) String reviewResult) {
        return toAjax(applicationService.reviewApplication(applicationId, status, reviewResult));
    }

    /**
     * 批量审核申请
     */
    @SaCheckPermission("hit:project:application:review")
    @Log(title = "批量审核申请", businessType = BusinessType.UPDATE)
    @PutMapping("/batch-review")
    public R<Void> batchReviewApplications(@RequestParam List<Long> applicationIds,
                                         @RequestParam String status,
                                         @RequestParam(required = false) String reviewResult) {
        return toAjax(applicationService.batchReviewApplications(applicationIds, status, reviewResult));
    }

    /**
     * 查询项目的所有申请
     */
    @GetMapping("/project/{projectId}")
    public TableDataInfo<HitProjectApplicationVo> getProjectApplications(@PathVariable Long projectId, PageQuery pageQuery) {
        return applicationService.queryProjectApplications(projectId, pageQuery);
    }

    /**
     * 查询用户的所有申请
     */
    @GetMapping("/user/{userId}")
    public TableDataInfo<HitProjectApplicationVo> getUserApplications(@PathVariable Long userId, PageQuery pageQuery) {
        return applicationService.queryUserApplications(userId, pageQuery);
    }

    /**
     * 查询我的所有申请
     */
    @GetMapping("/my")
    public TableDataInfo<HitProjectApplicationVo> getMyApplications(PageQuery pageQuery) {
        return applicationService.queryMyApplications(pageQuery);
    }

    /**
     * 查询我创建项目的所有申请
     */
    @GetMapping("/my-projects")
    public TableDataInfo<HitProjectApplicationVo> getMyProjectApplications(PageQuery pageQuery) {
        return applicationService.queryMyProjectApplications(pageQuery);
    }

    /**
     * 检查用户是否已申请该项目
     */
    @GetMapping("/check/{projectId}")
    public R<Boolean> checkUserApplied(@PathVariable Long projectId, @RequestParam(required = false) Long userId) {
        if (userId == null) {
            // 检查当前用户
            return R.ok(applicationService.hasUserApplied(projectId, LoginHelper.getUserId()));
        } else {
            return R.ok(applicationService.hasUserApplied(projectId, userId));
        }
    }

    /**
     * 统计项目待审核申请数量
     */
    @GetMapping("/pending-count/{projectId}")
    public R<Long> countPendingApplications(@PathVariable Long projectId) {
        return R.ok(applicationService.countPendingApplications(projectId));
    }

    // ==================== 公开接口（无需权限）====================

    /**
     * 公开接口：查询项目申请统计信息
     */
    @GetMapping("/public/stats/{projectId}")
    public R<ApplicationStatsVo> getApplicationStats(@PathVariable Long projectId) {
        Long pendingCount = applicationService.countPendingApplications(projectId);
        ApplicationStatsVo stats = new ApplicationStatsVo();
        stats.setPendingCount(pendingCount);
        return R.ok(stats);
    }

    /**
     * 申请统计信息VO
     */
    public static class ApplicationStatsVo {
        private Long pendingCount;
        
        public Long getPendingCount() {
            return pendingCount;
        }
        
        public void setPendingCount(Long pendingCount) {
            this.pendingCount = pendingCount;
        }
    }

} 