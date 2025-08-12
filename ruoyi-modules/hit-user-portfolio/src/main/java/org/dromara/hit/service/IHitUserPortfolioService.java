package org.dromara.hit.service;

import org.dromara.hit.domain.vo.HitUserPortfolioVo;
import org.dromara.hit.domain.bo.HitUserPortfolioBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 用户作品集Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
public interface IHitUserPortfolioService {

    /**
     * 查询用户作品集
     */
    HitUserPortfolioVo queryById(Long portfolioId);

    /**
     * 查询用户作品集列表
     */
    TableDataInfo<HitUserPortfolioVo> queryPageList(HitUserPortfolioBo bo, PageQuery pageQuery);

    /**
     * 查询用户作品集列表
     */
    List<HitUserPortfolioVo> queryList(HitUserPortfolioBo bo);

    /**
     * 新增用户作品集
     */
    Boolean insertByBo(HitUserPortfolioBo bo);

    /**
     * 修改用户作品集
     */
    Boolean updateByBo(HitUserPortfolioBo bo);

    /**
     * 校验并批量删除用户作品集信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 查询用户作品集列表（公开展示）
     */
    List<HitUserPortfolioVo> queryPublicPortfolios(Long userId);

    /**
     * 根据作品类型查询作品集
     */
    List<HitUserPortfolioVo> queryByWorkType(String workType);

    /**
     * 查询热门作品集（按浏览量排序）
     */
    List<HitUserPortfolioVo> queryHotPortfolios(Integer limit);

    /**
     * 增加浏览次数
     */
    Boolean increaseViewCount(Long portfolioId);

    /**
     * 增加点赞次数
     */
    Boolean increaseLikeCount(Long portfolioId);

    /**
     * 设置作品集置顶
     */
    Boolean setTop(Long portfolioId, Integer isTop);

    /**
     * 根据用户ID删除作品集
     */
    Boolean deleteByUserId(Long userId);

    /**
     * 查询当前用户的作品集列表
     */
    TableDataInfo<HitUserPortfolioVo> queryCurrentUserPortfolios(PageQuery pageQuery);

} 