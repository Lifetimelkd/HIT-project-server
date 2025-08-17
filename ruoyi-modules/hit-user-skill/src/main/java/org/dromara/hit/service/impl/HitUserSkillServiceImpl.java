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
import org.springframework.transaction.annotation.Transactional;
import org.dromara.hit.domain.bo.HitUserSkillBo;
import org.dromara.hit.domain.vo.HitUserSkillVo;
import org.dromara.hit.domain.HitUserSkill;
import org.dromara.hit.mapper.HitUserSkillMapper;
import org.dromara.hit.service.IHitUserSkillService;

import java.util.List;
import java.util.Map;
import java.util.Collection;
import java.util.Date;

/**
 * 用户技能关联Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@RequiredArgsConstructor
@Service
public class HitUserSkillServiceImpl implements IHitUserSkillService {

    private final HitUserSkillMapper baseMapper;

    /**
     * 查询用户技能关联
     */
    @Override
    public HitUserSkillVo queryById(Long userSkillId){
        return baseMapper.selectVoById(userSkillId);
    }

    /**
     * 查询用户技能关联列表
     */
    @Override
    public TableDataInfo<HitUserSkillVo> queryPageList(HitUserSkillBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitUserSkill> lqw = buildQueryWrapper(bo);
        Page<HitUserSkillVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询用户技能关联列表
     */
    @Override
    public List<HitUserSkillVo> queryList(HitUserSkillBo bo) {
        LambdaQueryWrapper<HitUserSkill> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitUserSkill> buildQueryWrapper(HitUserSkillBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitUserSkill> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, HitUserSkill::getUserId, bo.getUserId());
        lqw.eq(bo.getTagId() != null, HitUserSkill::getTagId, bo.getTagId());
        lqw.eq(bo.getSkillLevel() != null, HitUserSkill::getSkillLevel, bo.getSkillLevel());
        lqw.eq(bo.getIsCertified() != null, HitUserSkill::getIsCertified, bo.getIsCertified());
        lqw.orderByDesc(HitUserSkill::getCreateTime);
        return lqw;
    }

    /**
     * 新增用户技能关联
     */
    @Override
    public Boolean insertByBo(HitUserSkillBo bo) {
        HitUserSkill add = MapstructUtils.convert(bo, HitUserSkill.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setUserSkillId(add.getUserSkillId());
        }
        return flag;
    }

    /**
     * 修改用户技能关联
     */
    @Override
    public Boolean updateByBo(HitUserSkillBo bo) {
        HitUserSkill update = MapstructUtils.convert(bo, HitUserSkill.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitUserSkill entity){
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除用户技能关联
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 查询用户技能列表（包含标签信息）
     */
    @Override
    public List<HitUserSkillVo> queryUserSkillsWithTag(Long userId) {
        return baseMapper.selectUserSkillsWithTag(userId);
    }

    /**
     * 根据标签ID查询用户列表
     */
    @Override
    public List<HitUserSkillVo> queryUsersBySkillTag(Long tagId) {
        return baseMapper.selectUsersBySkillTag(tagId);
    }

    /**
     * 批量保存用户技能
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean batchSaveUserSkills(Long userId, List<HitUserSkillBo> skillList) {
        // 先删除用户原有技能
        deleteByUserId(userId);
        
        // 批量插入新技能
        for (HitUserSkillBo skillBo : skillList) {
            skillBo.setUserId(userId);
            insertByBo(skillBo);
        }
        return true;
    }

    /**
     * 根据用户ID删除技能
     */
    @Override
    public Boolean deleteByUserId(Long userId) {
        LambdaQueryWrapper<HitUserSkill> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitUserSkill::getUserId, userId);
        return baseMapper.delete(lqw) >= 0;
    }

    /**
     * 技能认证
     */
    @Override
    public Boolean certifySkill(Long userSkillId, String certifiedRemark) {
        HitUserSkill userSkill = baseMapper.selectById(userSkillId);
        if (userSkill != null) {
            userSkill.setIsCertified(1);
            userSkill.setCertifiedRemark(certifiedRemark);
            return baseMapper.updateById(userSkill) > 0;
        }
        return false;
    }
} 