package org.dromara.hit.project.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.satoken.utils.LoginHelper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.dromara.hit.project.domain.bo.HitProjectBo;
import org.dromara.hit.project.domain.vo.HitProjectVo;
import org.dromara.hit.project.domain.HitProject;
import org.dromara.hit.project.mapper.HitProjectMapper;
import org.dromara.hit.project.service.IHitProjectService;
import org.dromara.hit.project.controller.HitProjectController.AdminStatisticsVo;
import org.dromara.hit.project.controller.HitProjectController.TrendDataVo;
import org.dromara.hit.project.controller.HitProjectController.TypeDistributionVo;

import java.util.List;
import java.util.Map;
import java.util.Collection;
import java.util.ArrayList;

/**
 * 项目信息Service业务层处理
 *
 * @author HIT
 * @date 2025-01-15
 */
@RequiredArgsConstructor
@Service
public class HitProjectServiceImpl implements IHitProjectService {

    private final HitProjectMapper baseMapper;

    /**
     * 查询项目信息
     */
    @Override
    public HitProjectVo queryById(Long projectId){
        return baseMapper.selectVoById(projectId);
    }

    /**
     * 查询项目信息列表
     */
    @Override
    public TableDataInfo<HitProjectVo> queryPageList(HitProjectBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitProject> lqw = buildQueryWrapper(bo);
        Page<HitProjectVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询项目信息列表
     */
    @Override
    public List<HitProjectVo> queryList(HitProjectBo bo) {
        LambdaQueryWrapper<HitProject> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitProject> buildQueryWrapper(HitProjectBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitProject> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getProjectName()), HitProject::getProjectName, bo.getProjectName());
        lqw.eq(StringUtils.isNotBlank(bo.getProjectType()), HitProject::getProjectType, bo.getProjectType());
        lqw.eq(StringUtils.isNotBlank(bo.getProjectCategory()), HitProject::getProjectCategory, bo.getProjectCategory());
        lqw.eq(bo.getDifficultyLevel() != null, HitProject::getDifficultyLevel, bo.getDifficultyLevel());
        lqw.eq(StringUtils.isNotBlank(bo.getDurationType()), HitProject::getDurationType, bo.getDurationType());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitProject::getStatus, bo.getStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getRecruitmentStatus()), HitProject::getRecruitmentStatus, bo.getRecruitmentStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getVisibility()), HitProject::getVisibility, bo.getVisibility());
        lqw.eq(bo.getCreatorId() != null, HitProject::getCreatorId, bo.getCreatorId());
        lqw.eq(bo.getMentorId() != null, HitProject::getMentorId, bo.getMentorId());
        lqw.orderByDesc(HitProject::getCreateTime);
        return lqw;
    }

    /**
     * 新增项目信息
     */
    @Override
    public Boolean insertByBo(HitProjectBo bo) {
        HitProject add = MapstructUtils.convert(bo, HitProject.class);
        // 设置创建者ID为当前登录用户
        if (add.getCreatorId() == null) {
            add.setCreatorId(LoginHelper.getUserId());
        }
        // 设置默认值
        if (add.getCurrentMembers() == null) {
            add.setCurrentMembers(1);
        }
        if (add.getViewCount() == null) {
            add.setViewCount(0);
        }
        if (add.getLikeCount() == null) {
            add.setLikeCount(0);
        }
        if (add.getCollectCount() == null) {
            add.setCollectCount(0);
        }
        if (add.getApplyCount() == null) {
            add.setApplyCount(0);
        }
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setProjectId(add.getProjectId());
        }
        return flag;
    }

    /**
     * 修改项目信息
     */
    @Override
    public Boolean updateByBo(HitProjectBo bo) {
        HitProject update = MapstructUtils.convert(bo, HitProject.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitProject entity){
        // 校验团队规模
        if (entity.getTeamSizeMin() != null && entity.getTeamSizeMax() != null) {
            if (entity.getTeamSizeMin() > entity.getTeamSizeMax()) {
                throw new RuntimeException("最小团队规模不能大于最大团队规模");
            }
        }
        // 校验日期
        if (entity.getStartDate() != null && entity.getEndDate() != null) {
            if (entity.getStartDate().isAfter(entity.getEndDate())) {
                throw new RuntimeException("开始日期不能晚于结束日期");
            }
        }
    }

    /**
     * 批量删除项目信息
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 增加浏览次数
     */
    @Override
    public Boolean incrementViewCount(Long projectId) {
        return baseMapper.update(null, 
            Wrappers.lambdaUpdate(HitProject.class)
                .setSql("view_count = view_count + 1")
                .eq(HitProject::getProjectId, projectId)) > 0;
    }

    /**
     * 增加点赞次数
     */
    @Override
    public Boolean incrementLikeCount(Long projectId) {
        return baseMapper.update(null,
            Wrappers.lambdaUpdate(HitProject.class)
                .setSql("like_count = like_count + 1")
                .eq(HitProject::getProjectId, projectId)) > 0;
    }

    /**
     * 增加收藏次数
     */
    @Override
    public Boolean incrementCollectCount(Long projectId) {
        return baseMapper.update(null,
            Wrappers.lambdaUpdate(HitProject.class)
                .setSql("collect_count = collect_count + 1")
                .eq(HitProject::getProjectId, projectId)) > 0;
    }

    /**
     * 增加申请次数
     */
    @Override
    public Boolean incrementApplyCount(Long projectId) {
        return baseMapper.update(null,
            Wrappers.lambdaUpdate(HitProject.class)
                .setSql("apply_count = apply_count + 1")
                .eq(HitProject::getProjectId, projectId)) > 0;
    }

    /**
     * 查询用户可见的项目列表（包括公开、校内、自己创建的）
     */
    @Override
    public TableDataInfo<HitProjectVo> queryUserVisibleProjects(HitProjectBo bo, PageQuery pageQuery, Long userId) {
        LambdaQueryWrapper<HitProject> lqw = buildQueryWrapper(bo);
        // 添加可见性条件：公开项目 OR 校内项目 OR 用户创建的项目
        lqw.and(wrapper -> wrapper
            .eq(HitProject::getVisibility, "public")
            .or()
            .eq(HitProject::getVisibility, "internal")
            .or()
            .eq(HitProject::getCreatorId, userId)
        );
        Page<HitProjectVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public AdminStatisticsVo getAdminStatistics() {
        AdminStatisticsVo statistics = new AdminStatisticsVo();
        
        // 统计项目数据
        Long totalProjects = baseMapper.selectCount(new LambdaQueryWrapper<HitProject>());
        Long activeProjects = baseMapper.selectCount(new LambdaQueryWrapper<HitProject>()
            .eq(HitProject::getStatus, "active"));
        Long completedProjects = baseMapper.selectCount(new LambdaQueryWrapper<HitProject>()
            .eq(HitProject::getStatus, "completed"));
        
        statistics.setTotalProjects(totalProjects);
        statistics.setActiveProjects(activeProjects);
        statistics.setCompletedProjects(completedProjects);
        
        // TODO: 这里需要集成成员管理和申请管理的统计数据
        // 暂时设置为0，等待相关模块完善
        statistics.setTotalMembers(0L);
        statistics.setActiveMembers(0L);
        statistics.setPendingApplications(0L);
        statistics.setProjectsIncrease(0L);
        statistics.setMembersIncrease(0L);
        
        return statistics;
    }

    @Override
    public List<TrendDataVo> getProjectTrends(String startDate, String endDate) {
        // TODO: 实现项目创建趋势统计
        List<TrendDataVo> trends = new ArrayList<>();
        
        // 暂时返回空列表，需要根据实际需求实现复杂的统计查询
        return trends;
    }

    @Override
    public List<TypeDistributionVo> getProjectTypeDistribution() {
        List<TypeDistributionVo> distribution = new ArrayList<>();
        
        // 统计各种项目类型的数量
        String[] types = {"academic", "competition", "practice", "graduation", "course"};
        String[] typeNames = {"学术研究", "竞赛项目", "实践项目", "毕业设计", "课程项目"};
        
        for (int i = 0; i < types.length; i++) {
            String type = types[i];
            String typeName = typeNames[i];
            
            Long count = baseMapper.selectCount(new LambdaQueryWrapper<HitProject>()
                .eq(HitProject::getProjectType, type));
                
            distribution.add(new TypeDistributionVo(type, typeName, count));
        }
        
        return distribution;
    }

    @Override
    public Boolean checkUserLiked(Long projectId, Long userId) {
        // TODO: 目前没有专门的点赞记录表，暂时返回false
        // 后续可以创建 hit_project_like 表来记录用户点赞记录
        // 或者使用其他方式（如Redis缓存）来记录用户点赞状态
        return false;
    }

    @Override
    public Boolean checkUserCollected(Long projectId, Long userId) {
        if (projectId == null || userId == null) {
            return false;
        }
        Long count = baseMapper.checkUserCollected(projectId, userId);
        return count != null && count > 0;
    }
} 