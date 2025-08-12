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
import org.dromara.hit.domain.bo.HitSkillTagBo;
import org.dromara.hit.domain.vo.HitSkillTagVo;
import org.dromara.hit.domain.HitSkillTag;
import org.dromara.hit.mapper.HitSkillTagMapper;
import org.dromara.hit.service.IHitSkillTagService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 技能标签Service业务层处理
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
@RequiredArgsConstructor
@Service
public class HitSkillTagServiceImpl implements IHitSkillTagService {

    private final HitSkillTagMapper baseMapper;

    /**
     * 查询技能标签
     */
    @Override
    public HitSkillTagVo queryById(Long tagId){
        return baseMapper.selectVoById(tagId);
    }

    /**
     * 查询技能标签列表
     */
    @Override
    public TableDataInfo<HitSkillTagVo> queryPageList(HitSkillTagBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<HitSkillTag> lqw = buildQueryWrapper(bo);
        Page<HitSkillTagVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询技能标签列表
     */
    @Override
    public List<HitSkillTagVo> queryList(HitSkillTagBo bo) {
        LambdaQueryWrapper<HitSkillTag> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<HitSkillTag> buildQueryWrapper(HitSkillTagBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<HitSkillTag> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getTagName()), HitSkillTag::getTagName, bo.getTagName());
        lqw.eq(StringUtils.isNotBlank(bo.getTagCategory()), HitSkillTag::getTagCategory, bo.getTagCategory());
        lqw.eq(bo.getParentId() != null, HitSkillTag::getParentId, bo.getParentId());
        lqw.eq(bo.getIsHot() != null, HitSkillTag::getIsHot, bo.getIsHot());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), HitSkillTag::getStatus, bo.getStatus());
        lqw.orderByAsc(HitSkillTag::getOrderNum);
        return lqw;
    }

    /**
     * 新增技能标签
     */
    @Override
    public Boolean insertByBo(HitSkillTagBo bo) {
        HitSkillTag add = MapstructUtils.convert(bo, HitSkillTag.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setTagId(add.getTagId());
        }
        return flag;
    }

    /**
     * 修改技能标签
     */
    @Override
    public Boolean updateByBo(HitSkillTagBo bo) {
        HitSkillTag update = MapstructUtils.convert(bo, HitSkillTag.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(HitSkillTag entity){
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除技能标签
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 查询热门标签
     */
    @Override
    public List<HitSkillTagVo> queryHotTags() {
        LambdaQueryWrapper<HitSkillTag> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitSkillTag::getIsHot, 1);
        lqw.eq(HitSkillTag::getStatus, "0");
        lqw.orderByDesc(HitSkillTag::getUseCount);
        return baseMapper.selectVoList(lqw);
    }

    /**
     * 根据分类查询标签
     */
    @Override
    public List<HitSkillTagVo> queryByCategory(String category) {
        LambdaQueryWrapper<HitSkillTag> lqw = Wrappers.lambdaQuery();
        lqw.eq(HitSkillTag::getTagCategory, category);
        lqw.eq(HitSkillTag::getStatus, "0");
        lqw.orderByAsc(HitSkillTag::getOrderNum);
        return baseMapper.selectVoList(lqw);
    }

    /**
     * 增加使用次数
     */
    @Override
    public Boolean increaseUseCount(Long tagId) {
        HitSkillTag tag = baseMapper.selectById(tagId);
        if (tag != null) {
            tag.setUseCount(tag.getUseCount() + 1);
            return baseMapper.updateById(tag) > 0;
        }
        return false;
    }
} 