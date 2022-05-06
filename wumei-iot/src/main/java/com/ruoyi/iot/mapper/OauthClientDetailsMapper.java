package com.ruoyi.iot.mapper;

import java.util.List;
import com.ruoyi.iot.domain.OauthClientDetails;
import org.springframework.stereotype.Repository;

/**
 * 云云对接Mapper接口
 * 
 * @author kerwincui
 * @date 2022-02-07
 */
@Repository
public interface OauthClientDetailsMapper 
{
    /**
     * 查询云云对接
     * 
     * @param clientId 云云对接主键
     * @return 云云对接
     */
    public OauthClientDetails selectOauthClientDetailsByClientId(String clientId);

    /**
     * 查询云云对接列表
     * 
     * @param oauthClientDetails 云云对接
     * @return 云云对接集合
     */
    public List<OauthClientDetails> selectOauthClientDetailsList(OauthClientDetails oauthClientDetails);

    /**
     * 新增云云对接
     * 
     * @param oauthClientDetails 云云对接
     * @return 结果
     */
    public int insertOauthClientDetails(OauthClientDetails oauthClientDetails);

    /**
     * 修改云云对接
     * 
     * @param oauthClientDetails 云云对接
     * @return 结果
     */
    public int updateOauthClientDetails(OauthClientDetails oauthClientDetails);

    /**
     * 删除云云对接
     * 
     * @param clientId 云云对接主键
     * @return 结果
     */
    public int deleteOauthClientDetailsByClientId(String clientId);

    /**
     * 批量删除云云对接
     * 
     * @param clientIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteOauthClientDetailsByClientIds(String[] clientIds);
}
