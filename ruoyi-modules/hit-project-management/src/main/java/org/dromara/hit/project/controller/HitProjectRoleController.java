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
import org.dromara.hit.project.domain.bo.HitProjectRoleBo;
import org.dromara.hit.project.domain.vo.HitProjectRoleVo;
import org.dromara.hit.project.service.IHitProjectRoleService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 项目角色控制器
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/project/role")
public class HitProjectRoleController extends BaseController {

    private final IHitProjectRoleService roleService;

    /**
     * 查询项目角色列表
     */
    @SaCheckPermission("hit:project:role:list")
    @GetMapping("/list")
    public TableDataInfo<HitProjectRoleVo> list(HitProjectRoleBo bo, PageQuery pageQuery) {
        return roleService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出项目角色列表
     */
    @SaCheckPermission("hit:project:role:export")
    @Log(title = "项目角色", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitProjectRoleBo bo, HttpServletResponse response) {
        List<HitProjectRoleVo> list = roleService.queryList(bo);
        ExcelUtil.exportExcel(list, "项目角色", HitProjectRoleVo.class, response);
    }

    /**
     * 获取项目角色详细信息
     */
    @SaCheckPermission("hit:project:role:query")
    @GetMapping("/{roleId}")
    public R<HitProjectRoleVo> getInfo(@PathVariable Long roleId) {
        return R.ok(roleService.queryById(roleId));
    }

    /**
     * 新增项目角色
     */
    @SaCheckPermission("hit:project:role:add")
    @Log(title = "项目角色", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitProjectRoleBo bo) {
        return toAjax(roleService.insertByBo(bo));
    }

    /**
     * 修改项目角色
     */
    @SaCheckPermission("hit:project:role:edit")
    @Log(title = "项目角色", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitProjectRoleBo bo) {
        return toAjax(roleService.updateByBo(bo));
    }

    /**
     * 删除项目角色
     */
    @SaCheckPermission("hit:project:role:remove")
    @Log(title = "项目角色", businessType = BusinessType.DELETE)
    @DeleteMapping("/{roleIds}")
    public R<Void> remove(@PathVariable Long[] roleIds) {
        return toAjax(roleService.deleteWithValidByIds(List.of(roleIds), true));
    }

    // ==================== 业务接口 ====================

    /**
     * 查询项目的所有角色
     */
    @GetMapping("/project/{projectId}")
    public R<List<HitProjectRoleVo>> getRolesByProjectId(@PathVariable Long projectId) {
        List<HitProjectRoleVo> roles = roleService.queryRolesByProjectId(projectId);
        return R.ok(roles);
    }

    /**
     * 查询项目的可申请角色（招募中且未满员）
     */
    @GetMapping("/project/{projectId}/available")
    public R<List<HitProjectRoleVo>> getAvailableRolesByProjectId(@PathVariable Long projectId) {
        List<HitProjectRoleVo> roles = roleService.queryAvailableRolesByProjectId(projectId);
        return R.ok(roles);
    }

    /**
     * 查询项目的领导角色
     */
    @GetMapping("/project/{projectId}/leaders")
    public R<List<HitProjectRoleVo>> getLeaderRolesByProjectId(@PathVariable Long projectId) {
        List<HitProjectRoleVo> roles = roleService.queryLeaderRolesByProjectId(projectId);
        return R.ok(roles);
    }

    /**
     * 根据角色名称查询项目角色
     */
    @GetMapping("/project/{projectId}/name/{roleName}")
    public R<HitProjectRoleVo> getRoleByProjectIdAndName(@PathVariable Long projectId, @PathVariable String roleName) {
        HitProjectRoleVo role = roleService.queryByProjectIdAndRoleName(projectId, roleName);
        return R.ok(role);
    }

    /**
     * 检查项目角色名称是否存在
     */
    @GetMapping("/check-name")
    public R<Boolean> checkRoleNameExists(@RequestParam Long projectId, 
                                         @RequestParam String roleName, 
                                         @RequestParam(required = false) Long excludeRoleId) {
        Boolean exists = roleService.checkRoleNameExists(projectId, roleName, excludeRoleId);
        return R.ok(exists);
    }

    /**
     * 创建项目默认角色
     */
    @SaCheckPermission("hit:project:role:add")
    @PostMapping("/project/{projectId}/default")
    public R<Void> createDefaultRoles(@PathVariable Long projectId, 
                                     @RequestParam(required = false) String projectType,
                                     @RequestParam(required = false) String projectCategory) {
        return toAjax(roleService.createDefaultRoles(projectId, projectType, projectCategory));
    }

    /**
     * 更新项目角色的当前人数统计
     */
    @SaCheckPermission("hit:project:role:edit")
    @PutMapping("/project/{projectId}/update-count")
    public R<Void> updateCurrentCount(@PathVariable Long projectId) {
        return toAjax(roleService.updateCurrentCountByProjectId(projectId));
    }

    /**
     * 统计项目角色数量
     */
    @GetMapping("/project/{projectId}/count")
    public R<Long> countRoles(@PathVariable Long projectId, @RequestParam(required = false) String status) {
        Long count = roleService.countRolesByProjectId(projectId, status);
        return R.ok(count);
    }

    /**
     * 批量设置角色状态
     */
    @SaCheckPermission("hit:project:role:edit")
    @PutMapping("/batch-status")
    public R<Void> batchUpdateStatus(@RequestBody List<Long> roleIds, @RequestParam String status) {
        return toAjax(roleService.batchUpdateRoleStatus(roleIds, status));
    }
} 