package net.pingfang.iot.core.service.impl;

import static net.pingfang.iot.common.utils.SecurityUtils.getLoginUser;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.pingfang.iot.common.constant.HttpStatus;
import net.pingfang.iot.common.core.domain.entity.SysUser;
import net.pingfang.iot.common.exception.ServiceException;
import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.common.utils.StringUtils;
import net.pingfang.iot.common.utils.uuid.IdUtils;
import net.pingfang.iot.core.domain.ProductAuthorize;
import net.pingfang.iot.core.mapper.ProductAuthorizeMapper;
import net.pingfang.iot.core.model.ProductAuthorizeVO;
import net.pingfang.iot.core.service.IProductAuthorizeService;

/**
 * 产品授权码Service业务层处理
 *
 * @author kami
 * @date 2022-04-11
 */
@Service
public class ProductAuthorizeServiceImpl implements IProductAuthorizeService {
	@Autowired
	private ProductAuthorizeMapper productAuthorizeMapper;

	/**
	 * 查询产品授权码
	 *
	 * @param authorizeId 产品授权码主键
	 * @return 产品授权码
	 */
	@Override
	public ProductAuthorize selectProductAuthorizeByAuthorizeId(Long authorizeId) {
		return productAuthorizeMapper.selectProductAuthorizeByAuthorizeId(authorizeId);
	}

	/**
	 * 查询产品授权码列表
	 *
	 * @param productAuthorize 产品授权码
	 * @return 产品授权码
	 */
	@Override
	public List<ProductAuthorize> selectProductAuthorizeList(ProductAuthorize productAuthorize) {
		return productAuthorizeMapper.selectProductAuthorizeList(productAuthorize);
	}

	/**
	 * 新增产品授权码
	 *
	 * @param productAuthorize 产品授权码
	 * @return 结果
	 */
	@Override
	public int insertProductAuthorize(ProductAuthorize productAuthorize) {
		productAuthorize.setCreateTime(DateUtils.getNowDate());
		return productAuthorizeMapper.insertProductAuthorize(productAuthorize);
	}

	/**
	 * 修改产品授权码
	 *
	 * @param productAuthorize 产品授权码
	 * @return 结果
	 */
	@Override
	public int updateProductAuthorize(ProductAuthorize productAuthorize) {
		productAuthorize.setUpdateTime(DateUtils.getNowDate());
		return productAuthorizeMapper.updateProductAuthorize(productAuthorize);
	}

	/**
	 * 批量删除产品授权码
	 *
	 * @param authorizeIds 需要删除的产品授权码主键
	 * @return 结果
	 */
	@Override
	public int deleteProductAuthorizeByAuthorizeIds(Long[] authorizeIds) {
		return productAuthorizeMapper.deleteProductAuthorizeByAuthorizeIds(authorizeIds);
	}

	/**
	 * 删除产品授权码信息
	 *
	 * @param authorizeId 产品授权码主键
	 * @return 结果
	 */
	@Override
	public int deleteProductAuthorizeByAuthorizeId(Long authorizeId) {
		return productAuthorizeMapper.deleteProductAuthorizeByAuthorizeId(authorizeId);
	}

	/**
	 * 根据数量批量新增产品授权码
	 *
	 * @param productAuthorizeVO
	 * @return
	 */
	@Override
	@Transactional
	public int addProductAuthorizeByNum(ProductAuthorizeVO productAuthorizeVO) {
		Long productId = productAuthorizeVO.getProductId();
		int createNum = productAuthorizeVO.getCreateNum();
		List<ProductAuthorize> list = new ArrayList<>(createNum);
		SysUser user = getLoginUser().getUser();
		for (int i = 0; i < createNum; i++) {
			ProductAuthorize authorize = new ProductAuthorize();
			authorize.setProductId(productId);
			authorize.setCreateBy(user.getUserName());
			authorize.setCreateTime(DateUtils.getNowDate());
			authorize.setAuthorizeCode(IdUtils.fastSimpleUUID().toUpperCase());
			list.add(authorize);
		}
		return productAuthorizeMapper.insertBatchAuthorize(list);
	}

	/**
	 * 根据产品id和设备序列号绑定授权码
	 *
	 * @param productAuthorize
	 * @return
	 */
	@Override
	@Transactional
	public int boundProductAuthorize(ProductAuthorize productAuthorize) {
		ProductAuthorize authorize = null;
		if (StringUtils.isEmpty(productAuthorize.getAuthorizeCode())) {
			// TODO-kami: 2022/4/11 13:34 后期无需查询，硬件调用直接传入参数，可以删除
			authorize = productAuthorizeMapper.selectOneUnboundAuthorizeByProductId(productAuthorize);
			productAuthorize.setAuthorizeCode(authorize.getAuthorizeCode());
		} else {
			authorize = productAuthorizeMapper.selectOneUnboundAuthorizeByAuthorizeCode(productAuthorize);
		}
		if (authorize == null) {
			throw new ServiceException("授权码数据异常", HttpStatus.BAD_REQUEST);
		}
		productAuthorize.setAuthorizeId(authorize.getAuthorizeId());
		productAuthorize.setUpdateTime(DateUtils.getNowDate());
		return productAuthorizeMapper.updateProductAuthorize(productAuthorize);
	}

}
