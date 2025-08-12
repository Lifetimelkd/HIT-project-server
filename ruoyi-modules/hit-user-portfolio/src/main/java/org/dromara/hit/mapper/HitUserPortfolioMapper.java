package org.dromara.hit.mapper;

import org.dromara.hit.domain.HitUserPortfolio;
import org.dromara.hit.domain.vo.HitUserPortfolioVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户作品集Mapper接口
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
public interface HitUserPortfolioMapper extends BaseMapperPlus<HitUserPortfolio, HitUserPortfolioVo> {

    /**
     * 查询用户作品集列表（公开展示）
     */
    List<HitUserPortfolioVo> selectPublicPortfolios(@Param("userId") Long userId);

    /**
     * 根据作品类型查询作品集
     */
    List<HitUserPortfolioVo> selectByWorkType(@Param("workType") String workType);

    /**
     * 查询热门作品集（按浏览量排序）
     */
    List<HitUserPortfolioVo> selectHotPortfolios(@Param("limit") Integer limit);

    /**
     * 增加浏览次数
     */
    int increaseViewCount(@Param("portfolioId") Long portfolioId);

    /**
     * 增加点赞次数
     */
    int increaseLikeCount(@Param("portfolioId") Long portfolioId);

    /**
     * 增加收藏次数
     */
    int increaseCollectCount(@Param("portfolioId") Long portfolioId);

} 