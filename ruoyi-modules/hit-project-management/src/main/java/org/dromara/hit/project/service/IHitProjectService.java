package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitProjectVo;
import org.dromara.hit.project.domain.bo.HitProjectBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.hit.project.controller.HitProjectController.AdminStatisticsVo;
import org.dromara.hit.project.controller.HitProjectController.TrendDataVo;
import org.dromara.hit.project.controller.HitProjectController.TypeDistributionVo;

import java.util.Collection;
import java.util.List;

/**
 * 项目信息Service接口
 *
 * @author HIT
 * @date 2025-01-15
 */
public interface IHitProjectService {

    /**
     * 查询项目信息
     */
    HitProjectVo queryById(Long projectId);

    /**
     * 查询项目信息列表
     */
    TableDataInfo<HitProjectVo> queryPageList(HitProjectBo bo, PageQuery pageQuery);

    /**
     * 查询项目信息列表
     */
    List<HitProjectVo> queryList(HitProjectBo bo);

    /**
     * 新增项目信息
     */
    Boolean insertByBo(HitProjectBo bo);

    /**
     * 修改项目信息
     */
    Boolean updateByBo(HitProjectBo bo);

    /**
     * 校验并批量删除项目信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 增加浏览次数
     */
    Boolean incrementViewCount(Long projectId);

    /**
     * 增加点赞次数
     */
    Boolean incrementLikeCount(Long projectId);

    /**
     * 增加收藏次数
     */
    Boolean incrementCollectCount(Long projectId);

    /**
     * 增加申请次数
     */
    Boolean incrementApplyCount(Long projectId);

    /**
     * 查询用户可见的项目列表（包括公开、校内、自己创建的）
     */
    TableDataInfo<HitProjectVo> queryUserVisibleProjects(HitProjectBo bo, PageQuery pageQuery, Long userId);

    /**
     * 获取管理后台统计数据
     */
    AdminStatisticsVo getAdminStatistics();

    /**
     * 获取项目创建趋势数据
     */
    List<TrendDataVo> getProjectTrends(String startDate, String endDate);

    /**
     * 获取项目类型分布数据
     */
    List<TypeDistributionVo> getProjectTypeDistribution();

    /**
     * 检查用户是否点赞了项目
     */
    Boolean checkUserLiked(Long projectId, Long userId);

    /**
     * 检查用户是否收藏了项目
     */
    Boolean checkUserCollected(Long projectId, Long userId);
} 