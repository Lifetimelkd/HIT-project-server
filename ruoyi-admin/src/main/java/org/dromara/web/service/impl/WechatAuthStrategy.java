package org.dromara.web.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.stp.parameter.SaLoginParameter;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthToken;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.request.AuthWeChatOpenRequest;
import me.zhyd.oauth.request.AuthWechatMiniProgramRequest;

import org.dromara.common.core.domain.model.LoginUser;
import org.dromara.common.core.domain.model.WechatLoginBody;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.ValidatorUtils;
import org.dromara.common.json.utils.JsonUtils;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.common.social.config.properties.SocialProperties;
import org.dromara.system.domain.vo.SysClientVo;
import org.dromara.system.domain.vo.SysSocialVo;
import org.dromara.system.domain.vo.SysUserVo;
import org.dromara.system.domain.bo.SysUserBo;
import org.dromara.system.domain.bo.SysSocialBo;
import org.dromara.system.service.ISysSocialService;
import org.dromara.system.service.ISysUserService;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.tenant.helper.TenantHelper;
import org.dromara.common.core.enums.UserType;
import cn.hutool.crypto.digest.BCrypt;
import cn.hutool.core.util.IdUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;

import java.util.Map;
import org.dromara.web.domain.vo.LoginVo;
import org.dromara.web.service.IAuthStrategy;
import org.dromara.web.service.SysLoginService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 微信一键登录认证策略
 *
 * @author weijing
 */
@Slf4j
@Service("wechat" + IAuthStrategy.BASE_NAME)
@RequiredArgsConstructor
public class WechatAuthStrategy implements IAuthStrategy {

    private final SysLoginService loginService;
    private final ISysSocialService socialService;
    private final ISysUserService userService;
    private final SocialProperties socialProperties;

    @Override
    public LoginVo login(String body, SysClientVo client) {
        WechatLoginBody loginBody = JsonUtils.parseObject(body, WechatLoginBody.class);
        ValidatorUtils.validate(loginBody);
        
        String code = loginBody.getCode();
        String phoneCode = loginBody.getPhoneCode();
        String wechatType = loginBody.getWechatType();
        String appId = loginBody.getAppId();
        String state = loginBody.getState();

        // 根据微信类型创建对应的认证请求
        AuthRequest authRequest = createAuthRequest(wechatType, appId);
        
        // 构建回调参数
        AuthCallback authCallback = new AuthCallback();
        authCallback.setCode(code);
        authCallback.setState(state);
        
        // 调用微信接口获取用户信息
        AuthResponse<AuthUser> resp = authRequest.login(authCallback);
        String openId;
        AuthUser authUser;
        
        if (resp.ok()) {
            authUser = resp.getData();
            AuthToken token = authUser.getToken();
            openId = token.getOpenId();
        } else {
            throw new ServiceException("微信授权失败: " + resp.getMsg());
        }

        // 获取微信手机号
        String phoneNumber = null;
        if (StringUtils.isNotBlank(phoneCode)) {
            phoneNumber = getPhoneNumber(phoneCode, appId);
            log.info("获取到微信手机号: {}", phoneNumber);
        }

        // 优先根据手机号查找用户，如果没有手机号再根据openId查找
        SysUserVo user = null;
        if (StringUtils.isNotBlank(phoneNumber)) {
            user = userService.selectUserByPhonenumber(phoneNumber);
            log.info("根据手机号查找用户结果: {}", user != null ? user.getUserName() : "未找到");
        }
        
        // 如果根据手机号没找到用户，再根据openId查找
        if (ObjectUtil.isNull(user)) {
            user = loadUserByOpenid(openId, wechatType);
            log.info("根据openId查找用户结果: {}", user != null ? user.getUserName() : "未找到");
        }
        
        // 如果用户不存在，则自动创建用户并绑定
        if (ObjectUtil.isNull(user)) {
            user = createUserAndBind(authUser, wechatType, phoneNumber);
        }

        // 使用SysLoginService构建登录用户
        LoginUser loginUser = loginService.buildLoginUser(user);
        loginUser.setClientKey(client.getClientKey());
        loginUser.setDeviceType(client.getDeviceType());

        // 配置登录参数
        SaLoginParameter model = new SaLoginParameter();
        model.setDeviceType(client.getDeviceType());
        model.setTimeout(client.getTimeout());
        model.setActiveTimeout(client.getActiveTimeout());
        model.setExtra(LoginHelper.CLIENT_KEY, client.getClientId());
        
        // 生成token
        LoginHelper.login(loginUser, model);

        // 构建返回结果
        LoginVo loginVo = new LoginVo();
        loginVo.setAccessToken(StpUtil.getTokenValue());
        loginVo.setExpireIn(StpUtil.getTokenTimeout());
        loginVo.setClientId(client.getClientId());
        return loginVo;
    }

    /**
     * 根据微信类型创建对应的认证请求
     */
    private AuthRequest createAuthRequest(String wechatType, String appId) {
        AuthConfig.AuthConfigBuilder builder = AuthConfig.builder()
            .ignoreCheckRedirectUri(true)
            .ignoreCheckState(true);

        return switch (wechatType.toLowerCase()) {
            case "miniprogram" -> {
                // 小程序登录
                if (StrUtil.isBlank(appId)) {
                    throw new ServiceException("小程序登录需要提供appId");
                }
                yield new AuthWechatMiniProgramRequest(builder
                    .clientId(appId)
                    .clientSecret(getAppSecret(appId, "miniprogram"))
                    .build());
            }
            case "mp" -> {
                // 公众号登录
                var mpConfig = socialProperties.getType().get("wechat_mp");
                if (ObjectUtil.isNull(mpConfig)) {
                    throw new ServiceException("微信公众号配置不存在");
                }
                // 注意：这里应该使用正确的公众号登录请求类
                // AuthWechatMpRequest 可能不存在，需要使用合适的实现
                yield new AuthWeChatOpenRequest(builder
                    .clientId(mpConfig.getClientId())
                    .clientSecret(mpConfig.getClientSecret())
                    .redirectUri(mpConfig.getRedirectUri())
                    .build());
            }
            case "open" -> {
                // 开放平台登录
                var openConfig = socialProperties.getType().get("wechat_open");
                if (ObjectUtil.isNull(openConfig)) {
                    throw new ServiceException("微信开放平台配置不存在");
                }
                yield new AuthWeChatOpenRequest(builder
                    .clientId(openConfig.getClientId())
                    .clientSecret(openConfig.getClientSecret())
                    .redirectUri(openConfig.getRedirectUri())
                    .build());
            }
            default -> throw new ServiceException("不支持的微信登录类型: " + wechatType);
        };
    }

    /**
     * 获取应用密钥
     */
    private String getAppSecret(String appId, String type) {
        // 优先从配置中根据appId获取对应的secret
        if ("miniprogram".equals(type)) {
            var miniprogramConfig = socialProperties.getType().get("wechat_miniprogram");
            if (ObjectUtil.isNotNull(miniprogramConfig) && appId.equals(miniprogramConfig.getClientId())) {
                return miniprogramConfig.getClientSecret();
            }
        }
        
        // TODO: 如果有多个小程序，可以在这里根据appId从数据库或其他配置中获取对应的secret
        // 这里返回一个占位符，实际使用时需要配置真实的secret
        throw new ServiceException("未找到对应appId的配置，请检查微信小程序配置: " + appId);
    }

    /**
     * 获取微信手机号
     */
    private String getPhoneNumber(String phoneCode, String appId) {
        try {
            String appSecret = getAppSecret(appId, "miniprogram");
            
            // 调用微信接口获取手机号
            String url = "https://api.weixin.qq.com/wxa/business/getuserphonenumber";
            
            // 先获取access_token
            String accessToken = getAccessToken(appId, appSecret);
            
            // 构建请求参数
            String requestBody = JsonUtils.toJsonString(Map.of("code", phoneCode));
            
            // 发送请求
            HttpResponse response = HttpRequest.post(url + "?access_token=" + accessToken)
                .header("Content-Type", "application/json")
                .body(requestBody)
                .execute();
            
            if (response.isOk()) {
                String responseBody = response.body();
                log.info("微信手机号接口返回: {}", responseBody);
                
                // 解析响应
                Map<String, Object> result = JsonUtils.parseMap(responseBody);
                Integer errcode = (Integer) result.get("errcode");
                
                if (errcode != null && errcode == 0) {
                    Map<String, Object> phoneInfo = (Map<String, Object>) result.get("phone_info");
                    if (phoneInfo != null) {
                        return (String) phoneInfo.get("phoneNumber");
                    }
                } else {
                    log.error("获取微信手机号失败: errcode={}, errmsg={}", errcode, result.get("errmsg"));
                }
            } else {
                log.error("调用微信手机号接口失败: {}", response.body());
            }
        } catch (Exception e) {
            log.error("获取微信手机号异常", e);
        }
        return null;
    }

    /**
     * 获取微信access_token
     */
    private String getAccessToken(String appId, String appSecret) {
        String url = "https://api.weixin.qq.com/cgi-bin/token";
        String params = String.format("grant_type=client_credential&appid=%s&secret=%s", appId, appSecret);
        
        HttpResponse response = HttpRequest.get(url + "?" + params).execute();
        
        if (response.isOk()) {
            String responseBody = response.body();
            Map<String, Object> result = JsonUtils.parseMap(responseBody);
            return (String) result.get("access_token");
        } else {
            throw new ServiceException("获取微信access_token失败");
        }
    }

    /**
     * 根据openId查找绑定的用户
     */
    private SysUserVo loadUserByOpenid(String openId, String wechatType) {
        try {
            // 构建查询条件
            String authId = "wechat_" + wechatType + "_" + openId;
            
            // 查询社交用户绑定信息
            List<SysSocialVo> socialList = socialService.selectByAuthId(authId);
            
            if (ObjectUtil.isEmpty(socialList)) {
                return null;
            }
            
            SysSocialVo social = socialList.get(0);
            
            // 根据社交绑定信息查询用户详情
            return userService.selectUserById(social.getUserId());
            
        } catch (Exception e) {
            log.error("根据openId查询用户失败: {}", e.getMessage());
            return null;
        }
    }

    /**
     * 创建用户并绑定微信账号
     */
    private SysUserVo createUserAndBind(AuthUser authUser, String wechatType, String phoneNumber) {
        log.info("微信用户首次登录，开始创建用户: openId={}, phone={}", 
            authUser.getUuid(), phoneNumber);
        
        try {
            // 1. 创建系统用户
            SysUserBo newUser = new SysUserBo();
            
            String openId = authUser.getUuid();
            
            // 设置用户名：优先使用手机号，如果没有手机号则使用wx_openid前缀
            String username;
            if (StringUtils.isNotBlank(phoneNumber)) {
                username = phoneNumber;
            } else {
                username = "wx_" + openId.substring(0, Math.min(8, openId.length()));
                
                // 确保用户名唯一
                int suffix = 1;
                String originalUsername = username;
                newUser.setUserName(username);
                while (!userService.checkUserNameUnique(newUser)) {
                    username = originalUsername + "_" + suffix++;
                    newUser.setUserName(username);
                }
            }
            
            newUser.setUserName(username);
            
            // 设置随机昵称
            String nickname = "用户" + IdUtil.fastUUID().substring(0, 6);
            newUser.setNickName(nickname);
            
            // 设置默认密码（随机生成）
            String defaultPassword = IdUtil.fastUUID().substring(0, 12);
            newUser.setPassword(BCrypt.hashpw(defaultPassword));
            
            // 设置用户类型和状态
            newUser.setUserType(UserType.APP_USER.getUserType()); // 移动客户端用户
            newUser.setStatus("0");    // 正常状态
            
            // 设置手机号
            if (StringUtils.isNotBlank(phoneNumber)) {
                newUser.setPhonenumber(phoneNumber);
            }
            
            // 设置租户信息
            String tenantId = TenantHelper.getTenantId();
            if (StringUtils.isBlank(tenantId)) {
                tenantId = "000000"; // 默认租户
            }
            
            // 使用TenantHelper动态设置租户，然后创建用户
            int insertResult = TenantHelper.dynamic(tenantId, () -> {
                return userService.insertUser(newUser);
            });
            
            if (insertResult <= 0) {
                throw new ServiceException("用户创建失败");
            }
            
            log.info("用户创建成功: userId={}, username={}, phone={}", 
                newUser.getUserId(), newUser.getUserName(), phoneNumber);
            
            // 2. 创建社交账号绑定关系
            SysSocialBo socialBo = new SysSocialBo();
            socialBo.setUserId(newUser.getUserId());
            socialBo.setAuthId("wechat_" + wechatType + "_" + openId);
            socialBo.setSource("wechat_" + wechatType);
            socialBo.setOpenId(openId);
            socialBo.setUserName(authUser.getUsername());
            socialBo.setNickName(authUser.getNickname());
            
            // 设置token信息
            if (authUser.getToken() != null) {
                socialBo.setAccessToken(authUser.getToken().getAccessToken());
                socialBo.setRefreshToken(authUser.getToken().getRefreshToken());
                socialBo.setExpireIn(authUser.getToken().getExpireIn());
                socialBo.setUnionId(authUser.getToken().getUnionId());
            }
            
            // 保存社交绑定信息
            boolean socialResult = socialService.insertByBo(socialBo);
            if (!socialResult) {
                log.error("社交账号绑定失败，但用户已创建: userId={}", newUser.getUserId());
            } else {
                log.info("社交账号绑定成功: userId={}, authId={}", newUser.getUserId(), socialBo.getAuthId());
            }
            
            // 3. 返回创建的用户信息
            return userService.selectUserById(newUser.getUserId());
            
        } catch (Exception e) {
            log.error("创建用户并绑定微信账号失败", e);
            throw new ServiceException("用户创建失败: " + e.getMessage());
        }
    }
}