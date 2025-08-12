package org.dromara.hit.controller;

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
import org.dromara.hit.domain.vo.HitUserProfileVo;
import org.dromara.hit.domain.bo.HitUserProfileBo;
import org.dromara.hit.service.IHitUserProfileService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户扩展档案
 *
 * @author LKD
 * @date 2025-08-11
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hitUserProfile/userProfile")
public class HitUserProfileController extends BaseController {

    private final IHitUserProfileService hitUserProfileService;

    /**
     * 查询用户扩展档案列表
     */
    @SaCheckPermission("hitUserProfile:userProfile:list")
    @GetMapping("/list")
    public TableDataInfo<HitUserProfileVo> list(HitUserProfileBo bo, PageQuery pageQuery) {
        return hitUserProfileService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户扩展档案列表
     */
    @SaCheckPermission("hitUserProfile:userProfile:export")
    @Log(title = "用户扩展档案", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitUserProfileBo bo, HttpServletResponse response) {
        List<HitUserProfileVo> list = hitUserProfileService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户扩展档案", HitUserProfileVo.class, response);
    }

    /**
     * 获取用户扩展档案详细信息
     *
     * @param profileId 主键
     */
    @SaCheckPermission("hitUserProfile:userProfile:query")
    @GetMapping("/{profileId}")
    public R<HitUserProfileVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long profileId) {
        return R.ok(hitUserProfileService.queryById(profileId));
    }

    /**
     * 获取当前用户的档案信息
     */
    @SaCheckPermission("hitUserProfile:userProfile:query")
    @GetMapping("/current")
    public R<HitUserProfileVo> getCurrentUserProfile() {
        return R.ok(hitUserProfileService.queryCurrentUserProfile());
    }

    /**
     * 新增用户扩展档案
     */
    @SaCheckPermission("hitUserProfile:userProfile:add")
    @Log(title = "用户扩展档案", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitUserProfileBo bo) {
        return toAjax(hitUserProfileService.insertByBo(bo));
    }

    /**
     * 修改用户扩展档案
     */
    @SaCheckPermission("hitUserProfile:userProfile:edit")
    @Log(title = "用户扩展档案", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitUserProfileBo bo) {
        return toAjax(hitUserProfileService.updateByBo(bo));
    }

    /**
     * 删除用户扩展档案
     *
     * @param profileIds 主键串
     */
    @SaCheckPermission("hitUserProfile:userProfile:remove")
    @Log(title = "用户扩展档案", businessType = BusinessType.DELETE)
    @DeleteMapping("/{profileIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] profileIds) {
        return toAjax(hitUserProfileService.deleteWithValidByIds(List.of(profileIds), true));
    }
}
