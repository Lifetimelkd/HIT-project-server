package org.dromara.hit.service;

import org.dromara.hit.domain.vo.HitUserProfileVo;
import org.dromara.hit.domain.bo.HitUserProfileBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 用户扩展档案Service接口
 *
 * @author LKD
 * @date 2025-08-11
 */
public interface IHitUserProfileService {

    /**
     * 查询用户扩展档案
     *
     * @param profileId 主键
     * @return 用户扩展档案
     */
    HitUserProfileVo queryById(Long profileId);

    /**
     * 分页查询用户扩展档案列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 用户扩展档案分页列表
     */
    TableDataInfo<HitUserProfileVo> queryPageList(HitUserProfileBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的用户扩展档案列表
     *
     * @param bo 查询条件
     * @return 用户扩展档案列表
     */
    List<HitUserProfileVo> queryList(HitUserProfileBo bo);

    /**
     * 新增用户扩展档案
     *
     * @param bo 用户扩展档案
     * @return 是否新增成功
     */
    Boolean insertByBo(HitUserProfileBo bo);

    /**
     * 修改用户扩展档案
     *
     * @param bo 用户扩展档案
     * @return 是否修改成功
     */
    Boolean updateByBo(HitUserProfileBo bo);

    /**
     * 校验并批量删除用户扩展档案信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
