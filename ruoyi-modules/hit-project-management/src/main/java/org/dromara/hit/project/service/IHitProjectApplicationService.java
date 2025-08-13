package org.dromara.hit.project.service;

import org.dromara.hit.project.domain.vo.HitProjectApplicationVo;
import org.dromara.hit.project.domain.bo.HitProjectApplicationBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 项目申请Service接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface IHitProjectApplicationService {

    /**
     * 查询项目申请
     */
    HitProjectApplicationVo queryById(Long applicationId);

    /**
     * 查询项目申请列表
     */
    TableDataInfo<HitProjectApplicationVo> queryPageList(HitProjectApplicationBo bo, PageQuery pageQuery);

    /**
     * 查询项目申请列表
     */
    List<HitProjectApplicationVo> queryList(HitProjectApplicationBo bo);

    /**
     * 新增项目申请
     */
    Boolean insertByBo(HitProjectApplicationBo bo);

    /**
     * 修改项目申请
     */
    Boolean updateByBo(HitProjectApplicationBo bo);

    /**
     * 校验并批量删除项目申请信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 申请加入项目
     *
     * @param bo 申请信息
     * @return 申请结果
     */
    Boolean applyToProject(HitProjectApplicationBo bo);

    /**
     * 撤回申请
     *
     * @param applicationId 申请ID
     * @return 撤回结果
     */
    Boolean withdrawApplication(Long applicationId);

    /**
     * 审核申请（通过/拒绝）
     *
     * @param applicationId 申请ID
     * @param status 审核状态（approved/rejected）
     * @param reviewResult 审核结果
     * @return 审核结果
     */
    Boolean reviewApplication(Long applicationId, String status, String reviewResult);

    /**
     * 批量审核申请
     *
     * @param applicationIds 申请ID列表
     * @param status 审核状态
     * @param reviewResult 审核结果
     * @return 审核结果
     */
    Boolean batchReviewApplications(List<Long> applicationIds, String status, String reviewResult);

    /**
     * 查询项目的所有申请
     *
     * @param projectId 项目ID
     * @param pageQuery 分页查询
     * @return 申请列表
     */
    TableDataInfo<HitProjectApplicationVo> queryProjectApplications(Long projectId, PageQuery pageQuery);

    /**
     * 查询用户的所有申请
     *
     * @param userId 用户ID
     * @param pageQuery 分页查询
     * @return 申请列表
     */
    TableDataInfo<HitProjectApplicationVo> queryUserApplications(Long userId, PageQuery pageQuery);

    /**
     * 查询当前用户的所有申请
     *
     * @param pageQuery 分页查询
     * @return 申请列表
     */
    TableDataInfo<HitProjectApplicationVo> queryMyApplications(PageQuery pageQuery);

    /**
     * 查询我创建项目的所有申请
     *
     * @param pageQuery 分页查询
     * @return 申请列表
     */
    TableDataInfo<HitProjectApplicationVo> queryMyProjectApplications(PageQuery pageQuery);

    /**
     * 检查用户是否已申请该项目
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 是否已申请
     */
    Boolean hasUserApplied(Long projectId, Long userId);

    /**
     * 统计项目待审核申请数量
     *
     * @param projectId 项目ID
     * @return 待审核申请数量
     */
    Long countPendingApplications(Long projectId);

} 