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
import org.dromara.hit.domain.vo.HitUserPortfolioVo;
import org.dromara.hit.domain.bo.HitUserPortfolioBo;
import org.dromara.hit.service.IHitUserPortfolioService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 用户作品集
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/hit/userPortfolio")
public class HitUserPortfolioController extends BaseController {

    private final IHitUserPortfolioService hitUserPortfolioService;

    /**
     * 查询用户作品集列表
     */
    @SaCheckPermission("hit:userPortfolio:list")
    @GetMapping("/list")
    public TableDataInfo<HitUserPortfolioVo> list(HitUserPortfolioBo bo, PageQuery pageQuery) {
        return hitUserPortfolioService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出用户作品集列表
     */
    @SaCheckPermission("hit:userPortfolio:export")
    @Log(title = "用户作品集", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HitUserPortfolioBo bo, HttpServletResponse response) {
        List<HitUserPortfolioVo> list = hitUserPortfolioService.queryList(bo);
        ExcelUtil.exportExcel(list, "用户作品集", HitUserPortfolioVo.class, response);
    }

    /**
     * 获取用户作品集详细信息
     */
    @SaCheckPermission("hit:userPortfolio:query")
    @GetMapping("/{portfolioId}")
    public R<HitUserPortfolioVo> getInfo(@NotNull(message = "主键不能为空")
                                         @PathVariable Long portfolioId) {
        return R.ok(hitUserPortfolioService.queryById(portfolioId));
    }

    /**
     * 新增用户作品集
     */
    @SaCheckPermission("hit:userPortfolio:add")
    @Log(title = "用户作品集", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody HitUserPortfolioBo bo) {
        return toAjax(hitUserPortfolioService.insertByBo(bo));
    }

    /**
     * 修改用户作品集
     */
    @SaCheckPermission("hit:userPortfolio:edit")
    @Log(title = "用户作品集", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody HitUserPortfolioBo bo) {
        return toAjax(hitUserPortfolioService.updateByBo(bo));
    }

    /**
     * 删除用户作品集
     */
    @SaCheckPermission("hit:userPortfolio:remove")
    @Log(title = "用户作品集", businessType = BusinessType.DELETE)
    @DeleteMapping("/{portfolioIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] portfolioIds) {
        return toAjax(hitUserPortfolioService.deleteWithValidByIds(List.of(portfolioIds), true));
    }

    /**
     * 查询用户作品集列表（公开展示）
     */
    @GetMapping("/public/{userId}")
    public R<List<HitUserPortfolioVo>> getPublicPortfolios(@PathVariable Long userId) {
        return R.ok(hitUserPortfolioService.queryPublicPortfolios(userId));
    }

    /**
     * 根据作品类型查询作品集
     */
    @GetMapping("/workType/{workType}")
    public R<List<HitUserPortfolioVo>> getByWorkType(@PathVariable String workType) {
        return R.ok(hitUserPortfolioService.queryByWorkType(workType));
    }

    /**
     * 查询热门作品集（按浏览量排序）
     */
    @GetMapping("/hot")
    public R<List<HitUserPortfolioVo>> getHotPortfolios(@RequestParam(defaultValue = "10") Integer limit) {
        return R.ok(hitUserPortfolioService.queryHotPortfolios(limit));
    }

    /**
     * 增加浏览次数
     */
    @PostMapping("/view/{portfolioId}")
    public R<Void> increaseViewCount(@PathVariable Long portfolioId) {
        return toAjax(hitUserPortfolioService.increaseViewCount(portfolioId));
    }

    /**
     * 增加点赞次数
     */
    @PostMapping("/like/{portfolioId}")
    public R<Void> increaseLikeCount(@PathVariable Long portfolioId) {
        return toAjax(hitUserPortfolioService.increaseLikeCount(portfolioId));
    }

    /**
     * 获取当前用户的作品集列表
     */
    @SaCheckPermission("hit:userPortfolio:list")
    @GetMapping("/current")
    public TableDataInfo<HitUserPortfolioVo> getCurrentUserPortfolios(PageQuery pageQuery) {
        return hitUserPortfolioService.queryCurrentUserPortfolios(pageQuery);
    }

    /**
     * 设置作品集置顶
     */
    @SaCheckPermission("hit:userPortfolio:edit")
    @Log(title = "设置作品集置顶", businessType = BusinessType.UPDATE)
    @PostMapping("/setTop/{portfolioId}")
    public R<Void> setTop(@PathVariable Long portfolioId, @RequestParam Integer isTop) {
        return toAjax(hitUserPortfolioService.setTop(portfolioId, isTop));
    }
} 