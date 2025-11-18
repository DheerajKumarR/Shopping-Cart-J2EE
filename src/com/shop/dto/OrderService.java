package com.shop.dto;

import java.util.List;

import com.shop.dao.OrderDao;
import com.shop.dao.OrderDetails;
import com.shop.dao.TransactionDao;

public interface OrderService {

	public String paymentSuccess(String userName, double paidAmount);

	public boolean addOrder(OrderDao order);

	public boolean addTransaction(TransactionDao transaction);

	public int countSoldItem(String prodId);

	public List<OrderDao> getAllOrders();

	public List<OrderDao> getOrdersByUserId(String emailId);

	public List<OrderDetails> getAllOrderDetails(String userEmailId);

	public String shipNow(String orderId, String prodId);
}
