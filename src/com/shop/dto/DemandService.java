package com.shop.dto;

import java.util.List;

import com.shop.dao.DemandDao;

public interface DemandService {

	public boolean addProduct(String userId, String prodId, int demandQty);

	public boolean addProduct(DemandDao userDemandBean);

	public boolean removeProduct(String userId, String prodId);

	public List<DemandDao> haveDemanded(String prodId);

}
