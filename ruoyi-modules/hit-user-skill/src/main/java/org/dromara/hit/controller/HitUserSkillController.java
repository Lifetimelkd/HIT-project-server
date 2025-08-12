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
import org.dromara.hit.domain.vo.HitUserSkillVo;
import org.dromara.hit.domain.bo.HitUserSkillBo;
import org.dromara.hit.service.IHitUserSkillService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户技能关联
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/userSkill")
public class HitUserSkillController extends BaseController {

    private final IHitUserSkillService hitUserSkillService;

    /**
     * 查询用户技能关联列表
     */
    @SaCheckPermission("hit:userSkill:list")
    @GetMapping("/list")
    public TableDataInfo<HitUserSkillVo> list(HitUserSkillBo bo, PageQuery pageQuery) {
        return hitUserSkillService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户技能关联列表
     */
    @SaCheckPermission("hit:userSkill:export")
    @Log(title = "用户技能关联", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitUserSkillBo bo, HttpServletResponse response) {
        List<HitUserSkillVo> list = hitUserSkillService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户技能关联", HitUserSkillVo.class, response);
    }

    /**
     * 获取用户技能关联详细信息
     */
    @SaCheckPermission("hit:userSkill:query")
    @GetMapping("/{userSkillId}")
    public R<HitUserSkillVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long userSkillId) {
        return R.ok(hitUserSkillService.queryById(userSkillId));
    }

    /**
     * 新增用户技能关联
     */
    @SaCheckPermission("hit:userSkill:add")
    @Log(title = "用户技能关联", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitUserSkillBo bo) {
        return toAjax(hitUserSkillService.insertByBo(bo));
    }

    /**
     * 修改用户技能关联
     */
    @SaCheckPermission("hit:userSkill:edit")
    @Log(title = "用户技能关联", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitUserSkillBo bo) {
        return toAjax(hitUserSkillService.updateByBo(bo));
    }

    /**
     * 删除用户技能关联
     */
    @SaCheckPermission("hit:userSkill:remove")
    @Log(title = "用户技能关联", businessType = BusinessType.DELETE)
    @DeleteMapping("/{userSkillIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] userSkillIds) {
        return toAjax(hitUserSkillService.deleteWithValidByIds(List.of(userSkillIds), true));
    }

    /**
     * 查询用户技能列表（包含标签信息）
     */
    @GetMapping("/user/{userId}")
    public R<List<HitUserSkillVo>> getUserSkillsWithTag(@PathVariable Long userId) {
        return R.ok(hitUserSkillService.queryUserSkillsWithTag(userId));
    }

    /**
     * 根据标签ID查询用户列表
     */
    @GetMapping("/tag/{tagId}")
    public R<List<HitUserSkillVo>> getUsersBySkillTag(@PathVariable Long tagId) {
        return R.ok(hitUserSkillService.queryUsersBySkillTag(tagId));
    }

    /**
     * 批量保存用户技能
     */
    @SaCheckPermission("hit:userSkill:edit")
    @Log(title = "批量保存用户技能", businessType = BusinessType.UPDATE)
    @PostMapping("/batch/{userId}")
    public R<Void> batchSaveUserSkills(@PathVariable Long userId, 
                                       @RequestBody List<HitUserSkillBo> skillList) {
        return toAjax(hitUserSkillService.batchSaveUserSkills(userId, skillList));
    }

    /**
     * 技能认证
     */
    @SaCheckPermission("hit:userSkill:edit")
    @Log(title = "技能认证", businessType = BusinessType.UPDATE)
    @PostMapping("/certify/{userSkillId}")
    public R<Void> certifySkill(@PathVariable Long userSkillId, 
                                @RequestParam String certifiedRemark) {
        return toAjax(hitUserSkillService.certifySkill(userSkillId, certifiedRemark));
    }
} 