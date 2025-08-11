package org.dromara.common.core.domain.model;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 微信一键登录对象
 *
 * @author weijing
 */

@Data
@EqualsAndHashCode(callSuper = true)
public class WechatLoginBody extends LoginBody {

    /**
     * 微信授权码
     */
    @NotBlank(message = "{wechat.code.not.blank}")
    private String code;

    /**
     * 微信小程序/公众号AppId
     */
    private String appId;

    /**
     * 微信授权类型 (miniprogram: 小程序, mp: 公众号, open: 开放平台)
     */
    @NotBlank(message = "{wechat.type.not.blank}")
    private String wechatType;

    /**
     * 微信授权后的state参数
     */
    private String state;

    /**
     * 加密数据（小程序授权时使用）
     */
    private String encryptedData;

    /**
     * 加密向量（小程序授权时使用）
     */
    private String iv;

    /**
     * 微信手机号授权码（小程序getPhoneNumber接口返回）
     */
    private String phoneCode;

}