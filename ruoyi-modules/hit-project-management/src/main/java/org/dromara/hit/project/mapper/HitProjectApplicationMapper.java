package org.dromara.hit.project.mapper;

import org.dromara.hit.project.domain.HitProjectApplication;
import org.dromara.hit.project.domain.vo.HitProjectApplicationVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 项目申请Mapper接口
 *
 * @author HIT-project-team
 * @date 2024-12-29
 */
public interface HitProjectApplicationMapper extends BaseMapperPlus<HitProjectApplication, HitProjectApplicationVo> {

    /**
     * 查询项目申请详情（包含关联信息）
     *
     * @param applicationId 申请ID
     * @return 项目申请详情
     */
    HitProjectApplicationVo selectApplicationWithDetails(@Param("applicationId") Long applicationId);

    /**
     * 查询项目的所有申请（包含关联信息）
     *
     * @param projectId 项目ID
     * @return 项目申请列表
     */
    List<HitProjectApplicationVo> selectApplicationsByProjectId(@Param("projectId") Long projectId);

    /**
     * 查询用户的所有申请（包含关联信息）
     *
     * @param userId 用户ID
     * @return 用户申请列表
     */
    List<HitProjectApplicationVo> selectApplicationsByUserId(@Param("userId") Long userId);

    /**
     * 查询待审核的申请数量
     *
     * @param projectId 项目ID
     * @return 待审核申请数量
     */
    Long countPendingApplications(@Param("projectId") Long projectId);

    /**
     * 检查用户是否已申请该项目
     *
     * @param projectId 项目ID
     * @param userId 用户ID
     * @return 申请记录数量
     */
    Long checkUserApplicationExists(@Param("projectId") Long projectId, @Param("userId") Long userId);

    /**
     * 批量更新申请状态
     *
     * @param applicationIds 申请ID列表
     * @param status 新状态
     * @param reviewerId 审核人ID
     * @return 更新记录数
     */
    int batchUpdateApplicationStatus(@Param("applicationIds") List<Long> applicationIds,
                                   @Param("status") String status,
                                   @Param("reviewerId") Long reviewerId);

} 