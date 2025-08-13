package org.dromara.hit.project.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.hit.project.domain.vo.HitProjectVo;
import org.dromara.hit.project.domain.bo.HitProjectBo;
import org.dromara.hit.project.service.IHitProjectService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 项目信息
 *
 * @author HIT
 * @date 2025-01-15
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project")
public class HitProjectController extends BaseController {

    private final IHitProjectService hitProjectService;

    /**
     * 查询项目信息列表
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/list")
    public TableDataInfo<HitProjectVo> list(HitProjectBo bo, PageQuery pageQuery) {
        return hitProjectService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出项目信息列表
     */
    @SaCheckPermission("hit:project:export")
    @Log(title = "项目信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitProjectBo bo, HttpServletResponse response) {
        List<HitProjectVo> list = hitProjectService.queryList(bo);
        ExcelUtil.exportExcel(list, "项目信息", HitProjectVo.class, response);
    }

    /**
     * 获取项目信息详细信息
     */
    @SaCheckPermission("hit:project:query")
    @GetMapping("/{projectId}")
    public R<HitProjectVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long projectId) {
        // 增加浏览次数
        hitProjectService.incrementViewCount(projectId);
        return R.ok(hitProjectService.queryById(projectId));
    }

    /**
     * 新增项目信息
     */
    @SaCheckPermission("hit:project:add")
    @Log(title = "项目信息", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitProjectBo bo) {
        return toAjax(hitProjectService.insertByBo(bo));
    }

    /**
     * 修改项目信息
     */
    @SaCheckPermission("hit:project:edit")
    @Log(title = "项目信息", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitProjectBo bo) {
        return toAjax(hitProjectService.updateByBo(bo));
    }

    /**
     * 删除项目信息
     */
    @SaCheckPermission("hit:project:remove")
    @Log(title = "项目信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{projectIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] projectIds) {
        return toAjax(hitProjectService.deleteWithValidByIds(List.of(projectIds), true));
    }

    /**
     * 项目点赞
     */
    @SaCheckPermission("hit:project:like")
    @Log(title = "项目点赞", businessType = BusinessType.UPDATE)
    @PostMapping("/{projectId}/like")
    public R<Void> like(@NotNull(message = "项目ID不能为空") @PathVariable Long projectId) {
        return toAjax(hitProjectService.incrementLikeCount(projectId));
    }

    /**
     * 项目收藏
     */
    @SaCheckPermission("hit:project:collect")
    @Log(title = "项目收藏", businessType = BusinessType.UPDATE)
    @PostMapping("/{projectId}/collect")
    public R<Void> collect(@NotNull(message = "项目ID不能为空") @PathVariable Long projectId) {
        return toAjax(hitProjectService.incrementCollectCount(projectId));
    }

    /**
     * 公开项目列表（无需权限）
     */
    @GetMapping("/public/list")
    public TableDataInfo<HitProjectVo> publicList(HitProjectBo bo, PageQuery pageQuery) {
        // 只显示公开和校内可见的项目
        bo.setVisibility("public");
        return hitProjectService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取项目详情（无需权限）
     */
    @GetMapping("/public/{projectId}")
    public R<HitProjectVo> publicGetInfo(@NotNull(message = "主键不能为空")
                                        @PathVariable Long projectId) {
        // 增加浏览次数
        hitProjectService.incrementViewCount(projectId);
        HitProjectVo project = hitProjectService.queryById(projectId);
        // 只返回公开项目
        if (project != null && ("public".equals(project.getVisibility()) || "internal".equals(project.getVisibility()))) {
            return R.ok(project);
        }
        return R.fail("项目不存在或无权限访问");
    }

    /**
     * 获取当前用户创建的项目列表
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/my/created")
    public TableDataInfo<HitProjectVo> getMyCreatedProjects(HitProjectBo bo, PageQuery pageQuery) {
        // 设置查询条件为当前用户创建的项目
        bo.setCreatorId(LoginHelper.getUserId());
        return hitProjectService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取当前用户可见的项目列表（包括公开、校内、自己创建的）
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/my/visible")
    public TableDataInfo<HitProjectVo> getMyVisibleProjects(HitProjectBo bo, PageQuery pageQuery) {
        return hitProjectService.queryUserVisibleProjects(bo, pageQuery, LoginHelper.getUserId());
    }

    /**
     * 检查当前用户是否为项目创建者
     */
    @SaCheckPermission("hit:project:query")
    @GetMapping("/{projectId}/check-creator")
    public R<Boolean> checkIsCreator(@NotNull(message = "项目ID不能为空") @PathVariable Long projectId) {
        HitProjectVo project = hitProjectService.queryById(projectId);
        if (project == null) {
            return R.fail("项目不存在");
        }
        boolean isCreator = LoginHelper.getUserId().equals(project.getCreatorId());
        return R.ok(isCreator);
    }

    /**
     * 获取管理后台统计数据
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/admin/statistics/overview")
    public R<AdminStatisticsVo> getAdminStatistics() {
        AdminStatisticsVo statistics = hitProjectService.getAdminStatistics();
        return R.ok(statistics);
    }

    /**
     * 获取项目创建趋势数据
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/admin/statistics/trends")
    public R<List<TrendDataVo>> getProjectTrends(@RequestParam(required = false) String startDate,
                                                @RequestParam(required = false) String endDate) {
        List<TrendDataVo> trends = hitProjectService.getProjectTrends(startDate, endDate);
        return R.ok(trends);
    }

    /**
     * 获取项目类型分布数据
     */
    @SaCheckPermission("hit:project:list")
    @GetMapping("/admin/statistics/types")
    public R<List<TypeDistributionVo>> getProjectTypeDistribution() {
        List<TypeDistributionVo> distribution = hitProjectService.getProjectTypeDistribution();
        return R.ok(distribution);
    }

    /**
     * 检查用户是否点赞了项目
     */
    @GetMapping("/check/liked/{projectId}")
    public R<Boolean> checkUserLiked(@NotNull(message = "项目ID不能为空") @PathVariable Long projectId,
                                   @RequestParam(required = false) Long userId) {
        try {
            Long currentUserId = userId != null ? userId : LoginHelper.getUserId();
            Boolean isLiked = hitProjectService.checkUserLiked(projectId, currentUserId);
            return R.ok(isLiked);
        } catch (Exception e) {
            // 用户未登录或其他异常，返回未点赞状态
            return R.ok(false);
        }
    }

    /**
     * 检查用户是否收藏了项目
     */
    @GetMapping("/check/collected/{projectId}")
    public R<Boolean> checkUserCollected(@NotNull(message = "项目ID不能为空") @PathVariable Long projectId,
                                       @RequestParam(required = false) Long userId) {
        try {
            Long currentUserId = userId != null ? userId : LoginHelper.getUserId();
            Boolean isCollected = hitProjectService.checkUserCollected(projectId, currentUserId);
            return R.ok(isCollected);
        } catch (Exception e) {
            // 用户未登录或其他异常，返回未收藏状态
            return R.ok(false);
        }
    }

    /**
     * 管理后台统计数据VO
     */
    public static class AdminStatisticsVo {
        private Long totalProjects;
        private Long activeProjects;
        private Long completedProjects;
        private Long pendingApplications;
        private Long totalMembers;
        private Long activeMembers;
        private Long projectsIncrease;
        private Long membersIncrease;

        // Getters and Setters
        public Long getTotalProjects() { return totalProjects; }
        public void setTotalProjects(Long totalProjects) { this.totalProjects = totalProjects; }
        
        public Long getActiveProjects() { return activeProjects; }
        public void setActiveProjects(Long activeProjects) { this.activeProjects = activeProjects; }
        
        public Long getCompletedProjects() { return completedProjects; }
        public void setCompletedProjects(Long completedProjects) { this.completedProjects = completedProjects; }
        
        public Long getPendingApplications() { return pendingApplications; }
        public void setPendingApplications(Long pendingApplications) { this.pendingApplications = pendingApplications; }
        
        public Long getTotalMembers() { return totalMembers; }
        public void setTotalMembers(Long totalMembers) { this.totalMembers = totalMembers; }
        
        public Long getActiveMembers() { return activeMembers; }
        public void setActiveMembers(Long activeMembers) { this.activeMembers = activeMembers; }
        
        public Long getProjectsIncrease() { return projectsIncrease; }
        public void setProjectsIncrease(Long projectsIncrease) { this.projectsIncrease = projectsIncrease; }
        
        public Long getMembersIncrease() { return membersIncrease; }
        public void setMembersIncrease(Long membersIncrease) { this.membersIncrease = membersIncrease; }
    }

    /**
     * 趋势数据VO
     */
    public static class TrendDataVo {
        private String date;
        private Long count;

        public TrendDataVo(String date, Long count) {
            this.date = date;
            this.count = count;
        }

        public String getDate() { return date; }
        public void setDate(String date) { this.date = date; }
        
        public Long getCount() { return count; }
        public void setCount(Long count) { this.count = count; }
    }

    /**
     * 类型分布数据VO
     */
    public static class TypeDistributionVo {
        private String type;
        private String typeName;
        private Long count;

        public TypeDistributionVo(String type, String typeName, Long count) {
            this.type = type;
            this.typeName = typeName;
            this.count = count;
        }

        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        
        public String getTypeName() { return typeName; }
        public void setTypeName(String typeName) { this.typeName = typeName; }
        
        public Long getCount() { return count; }
        public void setCount(Long count) { this.count = count; }
    }
} 