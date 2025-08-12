package org.dromara.hit.mapper;

import org.dromara.hit.domain.HitUserSkill;
import org.dromara.hit.domain.vo.HitUserSkillVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户技能关联Mapper接口
 *
 * @author HIT-project-team
 * @date 2025-01-15
 */
public interface HitUserSkillMapper extends BaseMapperPlus<HitUserSkill, HitUserSkillVo> {

    /**
     * 查询用户技能列表（包含标签信息）
     */
    List<HitUserSkillVo> selectUserSkillsWithTag(@Param("userId") Long userId);

    /**
     * 根据标签ID查询用户列表
     */
    List<HitUserSkillVo> selectUsersBySkillTag(@Param("tagId") Long tagId);

} 