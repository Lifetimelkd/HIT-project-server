package org.dromara.hit.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.dromara.hit.domain.bo.HitUserProfileBo;
import org.dromara.hit.domain.vo.HitUserProfileVo;
import org.dromara.hit.domain.HitUserProfile;
import org.dromara.hit.mapper.HitUserProfileMapper;
import org.dromara.hit.service.IHitUserProfileService;
import org.dromara.common.satoken.utils.LoginHelper;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 用户扩展档案Service业务层处理
 *
 * @author LKD
 * @date 2025-08-11
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class HitUserProfileServiceImpl implements IHitUserProfileService {

    private final HitUserProfileMapper baseMapper;

    /**
     * 查询用户扩展档案
     *
     * @param profileId 主键
     * @return 用户扩展档案
     */
    @Override
    public HitUserProfileVo queryById(Long profileId){
        return baseMapper.selectVoById(profileId);
    }

    /**
     * 分页查询用户扩展档案列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户扩展档案分页列表
     */
    @Override
    public TableDataInfo<HitUserProfileVo> queryPageList(HitUserProfileBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitUserProfile> lqw = buildQueryWrapper(bo);
        Page<HitUserProfileVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的用户扩展档案列表
     *
     * @param bo 查询条件
     * @return 用户扩展档案列表
     */
    @Override
    public List<HitUserProfileVo> queryList(HitUserProfileBo bo) {
        LambdaQueryWrapper<HitUserProfile> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitUserProfile> buildQueryWrapper(HitUserProfileBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitUserProfile> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(HitUserProfile::getProfileId);
        lqw.eq(bo.getUserId() != null, HitUserProfile::getUserId, bo.getUserId());
        lqw.eq(StringUtils.isNotBlank(bo.getStudentId()), HitUserProfile::getStudentId, bo.getStudentId());
        lqw.like(StringUtils.isNotBlank(bo.getRealName()), HitUserProfile::getRealName, bo.getRealName());
        lqw.eq(StringUtils.isNotBlank(bo.getCollege()), HitUserProfile::getCollege, bo.getCollege());
        lqw.eq(StringUtils.isNotBlank(bo.getMajor()), HitUserProfile::getMajor, bo.getMajor());
        lqw.eq(StringUtils.isNotBlank(bo.getGrade()), HitUserProfile::getGrade, bo.getGrade());
        lqw.like(StringUtils.isNotBlank(bo.getClassName()), HitUserProfile::getClassName, bo.getClassName());
        lqw.eq(StringUtils.isNotBlank(bo.getPhone()), HitUserProfile::getPhone, bo.getPhone());
        lqw.eq(StringUtils.isNotBlank(bo.getEmail()), HitUserProfile::getEmail, bo.getEmail());
        lqw.eq(StringUtils.isNotBlank(bo.getQq()), HitUserProfile::getQq, bo.getQq());
        lqw.eq(StringUtils.isNotBlank(bo.getWechat()), HitUserProfile::getWechat, bo.getWechat());
        lqw.eq(StringUtils.isNotBlank(bo.getGithub()), HitUserProfile::getGithub, bo.getGithub());
        lqw.eq(StringUtils.isNotBlank(bo.getLinkedin()), HitUserProfile::getLinkedin, bo.getLinkedin());
        lqw.eq(StringUtils.isNotBlank(bo.getPersonalIntro()), HitUserProfile::getPersonalIntro, bo.getPersonalIntro());
        lqw.eq(StringUtils.isNotBlank(bo.getCareerPlan()), HitUserProfile::getCareerPlan, bo.getCareerPlan());
        lqw.eq(StringUtils.isNotBlank(bo.getAvatarUrl()), HitUserProfile::getAvatarUrl, bo.getAvatarUrl());
        lqw.eq(StringUtils.isNotBlank(bo.getCoverUrl()), HitUserProfile::getCoverUrl, bo.getCoverUrl());
        lqw.eq(bo.getReputationScore() != null, HitUserProfile::getReputationScore, bo.getReputationScore());
        lqw.eq(bo.getTotalProjects() != null, HitUserProfile::getTotalProjects, bo.getTotalProjects());
        lqw.eq(bo.getCompletedProjects() != null, HitUserProfile::getCompletedProjects, bo.getCompletedProjects());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitUserProfile::getStatus, bo.getStatus());
        lqw.eq(bo.getDeptId() != null, HitUserProfile::getDeptId, bo.getDeptId());
        return lqw;
    }

    /**
     * 新增用户扩展档案
     *
     * @param bo 用户扩展档案
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(HitUserProfileBo bo) {
        HitUserProfile add = MapstructUtils.convert(bo, HitUserProfile.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setProfileId(add.getProfileId());
        }
        return flag;
    }

    /**
     * 修改用户扩展档案
     *
     * @param bo 用户扩展档案
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(HitUserProfileBo bo) {
        HitUserProfile update = MapstructUtils.convert(bo, HitUserProfile.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitUserProfile entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除用户扩展档案信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    /**
     * 查询当前用户的档案信息
     *
     * @return 当前用户档案
     */
    @Override
    public HitUserProfileVo queryCurrentUserProfile() {
        Long currentUserId = LoginHelper.getUserId();
        LambdaQueryWrapper<HitUserProfile> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitUserProfile::getUserId, currentUserId);
        return baseMapper.selectVoOne(lqw);
    }
}
