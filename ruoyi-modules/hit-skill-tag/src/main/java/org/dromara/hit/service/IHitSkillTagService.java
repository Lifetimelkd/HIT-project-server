package org.dromara.hit.service;

import org.dromara.hit.domain.vo.HitSkillTagVo;
import org.dromara.hit.domain.bo.HitSkillTagBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 技能标签Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
public interface IHitSkillTagService {

    /**
     * 查询技能标签
     */
    HitSkillTagVo queryById(Long tagId);

    /**
     * 查询技能标签列表
     */
    TableDataInfo<HitSkillTagVo> queryPageList(HitSkillTagBo bo, PageQuery pageQuery);

    /**
     * 查询技能标签列表
     */
    List<HitSkillTagVo> queryList(HitSkillTagBo bo);

    /**
     * 新增技能标签
     */
    Boolean insertByBo(HitSkillTagBo bo);

    /**
     * 修改技能标签
     */
    Boolean updateByBo(HitSkillTagBo bo);

    /**
     * 校验并批量删除技能标签信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 查询热门标签
     */
    List<HitSkillTagVo> queryHotTags();

    /**
     * 根据分类查询标签
     */
    List<HitSkillTagVo> queryByCategory(String category);

    /**
     * 增加使用次数
     */
    Boolean increaseUseCount(Long tagId);
} 