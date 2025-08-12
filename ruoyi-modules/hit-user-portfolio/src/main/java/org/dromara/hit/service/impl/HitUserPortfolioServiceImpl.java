package org.dromara.hit.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.hit.domain.bo.HitUserPortfolioBo;
import org.dromara.hit.domain.vo.HitUserPortfolioVo;
import org.dromara.hit.domain.HitUserPortfolio;
import org.dromara.hit.mapper.HitUserPortfolioMapper;
import org.dromara.hit.service.IHitUserPortfolioService;
import org.dromara.common.satoken.utils.LoginHelper;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 用户作品集Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@RequiredArgsConstructor
@Service
public class HitUserPortfolioServiceImpl implements IHitUserPortfolioService {

    private final HitUserPortfolioMapper baseMapper;

    /**
     * 查询用户作品集
     */
    @Override
    public HitUserPortfolioVo queryById(Long portfolioId){
        return baseMapper.selectVoById(portfolioId);
    }

    /**
     * 查询用户作品集列表
     */
    @Override
    public TableDataInfo<HitUserPortfolioVo> queryPageList(HitUserPortfolioBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitUserPortfolio> lqw = buildQueryWrapper(bo);
        Page<HitUserPortfolioVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询用户作品集列表
     */
    @Override
    public List<HitUserPortfolioVo> queryList(HitUserPortfolioBo bo) {
        LambdaQueryWrapper<HitUserPortfolio> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitUserPortfolio> buildQueryWrapper(HitUserPortfolioBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitUserPortfolio> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, HitUserPortfolio::getUserId, bo.getUserId());
        lqw.like(StringUtils.isNotBlank(bo.getPortfolioTitle()), HitUserPortfolio::getPortfolioTitle, bo.getPortfolioTitle());
        lqw.eq(StringUtils.isNotBlank(bo.getWorkType()), HitUserPortfolio::getWorkType, bo.getWorkType());
        lqw.like(StringUtils.isNotBlank(bo.getTechStack()), HitUserPortfolio::getTechStack, bo.getTechStack());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitUserPortfolio::getStatus, bo.getStatus());
        lqw.orderByAsc(HitUserPortfolio::getSortOrder);
        lqw.orderByDesc(HitUserPortfolio::getCreateTime);
        return lqw;
    }

    /**
     * 新增用户作品集
     */
    @Override
    public Boolean insertByBo(HitUserPortfolioBo bo) {
        HitUserPortfolio add = MapstructUtils.convert(bo, HitUserPortfolio.class);
        // 自动设置当前登录用户ID
        add.setUserId(LoginHelper.getUserId());
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setPortfolioId(add.getPortfolioId());
        }
        return flag;
    }

    /**
     * 修改用户作品集
     */
    @Override
    public Boolean updateByBo(HitUserPortfolioBo bo) {
        HitUserPortfolio update = MapstructUtils.convert(bo, HitUserPortfolio.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitUserPortfolio entity){
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除用户作品集
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 查询用户作品集列表（公开展示）
     */
    @Override
    public List<HitUserPortfolioVo> queryPublicPortfolios(Long userId) {
        return baseMapper.selectPublicPortfolios(userId);
    }

    /**
     * 根据作品类型查询作品集
     */
    @Override
    public List<HitUserPortfolioVo> queryByWorkType(String workType) {
        return baseMapper.selectByWorkType(workType);
    }

    /**
     * 查询热门作品集（按浏览量排序）
     */
    @Override
    public List<HitUserPortfolioVo> queryHotPortfolios(Integer limit) {
        return baseMapper.selectHotPortfolios(limit);
    }

    /**
     * 增加浏览次数
     */
    @Override
    public Boolean increaseViewCount(Long portfolioId) {
        return baseMapper.increaseViewCount(portfolioId) > 0;
    }

    /**
     * 增加点赞次数
     */
    @Override
    public Boolean increaseLikeCount(Long portfolioId) {
        return baseMapper.increaseLikeCount(portfolioId) > 0;
    }

    /**
     * 设置作品集置顶
     */
    @Override
    public Boolean setTop(Long portfolioId, Integer isTop) {
        HitUserPortfolio portfolio = baseMapper.selectById(portfolioId);
        if (portfolio != null) {
            // 使用sortOrder来实现置顶功能，0表示置顶
            portfolio.setSortOrder(isTop == 1 ? 0 : 999);
            return baseMapper.updateById(portfolio) > 0;
        }
        return false;
    }

    /**
     * 根据用户ID删除作品集
     */
    @Override
    public Boolean deleteByUserId(Long userId) {
        LambdaQueryWrapper<HitUserPortfolio> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitUserPortfolio::getUserId, userId);
        return baseMapper.delete(lqw) >= 0;
    }

    /**
     * 查询当前用户作品集列表
     */
    @Override
    public TableDataInfo<HitUserPortfolioVo> queryCurrentUserPortfolios(PageQuery pageQuery) {
        Long userId = LoginHelper.getUserId();
        if (userId == null) {
            return TableDataInfo.build(new Page<>()); // 未登录用户返回空结果
        }
        LambdaQueryWrapper<HitUserPortfolio> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitUserPortfolio::getUserId, userId);
        lqw.orderByDesc(HitUserPortfolio::getCreateTime);
        Page<HitUserPortfolioVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }
} 