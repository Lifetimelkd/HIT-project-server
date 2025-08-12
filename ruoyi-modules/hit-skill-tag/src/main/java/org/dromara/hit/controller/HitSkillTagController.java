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
import org.dromara.hit.domain.vo.HitSkillTagVo;
import org.dromara.hit.domain.bo.HitSkillTagBo;
import org.dromara.hit.service.IHitSkillTagService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 技能标签
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/skillTag")
public class HitSkillTagController extends BaseController {

    private final IHitSkillTagService hitSkillTagService;

    /**
     * 查询技能标签列表
     */
    @SaCheckPermission("hit:skillTag:list")
    @GetMapping("/list")
    public TableDataInfo<HitSkillTagVo> list(HitSkillTagBo bo, PageQuery pageQuery) {
        return hitSkillTagService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出技能标签列表
     */
    @SaCheckPermission("hit:skillTag:export")
    @Log(title = "技能标签", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitSkillTagBo bo, HttpServletResponse response) {
        List<HitSkillTagVo> list = hitSkillTagService.queryList(bo);
        ExcelUtil.exportExcel(list, "技能标签", HitSkillTagVo.class, response);
    }

    /**
     * 获取技能标签详细信息
     */
    @SaCheckPermission("hit:skillTag:query")
    @GetMapping("/{tagId}")
    public R<HitSkillTagVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long tagId) {
        return R.ok(hitSkillTagService.queryById(tagId));
    }

    /**
     * 新增技能标签
     */
    @SaCheckPermission("hit:skillTag:add")
    @Log(title = "技能标签", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitSkillTagBo bo) {
        return toAjax(hitSkillTagService.insertByBo(bo));
    }

    /**
     * 修改技能标签
     */
    @SaCheckPermission("hit:skillTag:edit")
    @Log(title = "技能标签", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitSkillTagBo bo) {
        return toAjax(hitSkillTagService.updateByBo(bo));
    }

    /**
     * 删除技能标签
     */
    @SaCheckPermission("hit:skillTag:remove")
    @Log(title = "技能标签", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tagIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] tagIds) {
        return toAjax(hitSkillTagService.deleteWithValidByIds(List.of(tagIds), true));
    }

    /**
     * 查询热门标签
     */
    @GetMapping("/hot")
    public R<List<HitSkillTagVo>> getHotTags() {
        return R.ok(hitSkillTagService.queryHotTags());
    }

    /**
     * 根据分类查询标签
     */
    @GetMapping("/category/{category}")
    public R<List<HitSkillTagVo>> getTagsByCategory(@PathVariable String category) {
        return R.ok(hitSkillTagService.queryByCategory(category));
    }

    /**
     * 增加标签使用次数
     */
    @PostMapping("/useCount/{tagId}")
    public R<Void> increaseUseCount(@PathVariable Long tagId) {
        return toAjax(hitSkillTagService.increaseUseCount(tagId));
    }
} 