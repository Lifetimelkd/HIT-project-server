package org.dromara.hit.service;

import org.dromara.hit.domain.vo.HitUserSkillVo;
import org.dromara.hit.domain.bo.HitUserSkillBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 用户技能关联Service接口
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
public interface IHitUserSkillService {

    /**
     * 查询用户技能关联
     */
    HitUserSkillVo queryById(Long userSkillId);

    /**
     * 查询用户技能关联列表
     */
    TableDataInfo<HitUserSkillVo> queryPageList(HitUserSkillBo bo, PageQuery pageQuery);

    /**
     * 查询用户技能关联列表
     */
    List<HitUserSkillVo> queryList(HitUserSkillBo bo);

    /**
     * 新增用户技能关联
     */
    Boolean insertByBo(HitUserSkillBo bo);

    /**
     * 修改用户技能关联
     */
    Boolean updateByBo(HitUserSkillBo bo);

    /**
     * 校验并批量删除用户技能关联信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 查询用户技能列表（包含标签信息）
     */
    List<HitUserSkillVo> queryUserSkillsWithTag(Long userId);

    /**
     * 根据标签ID查询用户列表
     */
    List<HitUserSkillVo> queryUsersBySkillTag(Long tagId);

    /**
     * 批量保存用户技能
     */
    Boolean batchSaveUserSkills(Long userId, List<HitUserSkillBo> skillList);

    /**
     * 根据用户ID删除技能
     */
    Boolean deleteByUserId(Long userId);

    /**
     * 技能认证
     */
    Boolean certifySkill(Long userSkillId, String certifiedRemark);
} 