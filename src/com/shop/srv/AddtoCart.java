package com.shop.srv;

import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shop.dao.DemandDao;
import com.shop.dao.ProductDao;
import com.shop.dto.impl.CartServiceImpl;
import com.shop.dto.impl.DemandServiceImpl;
import com.shop.dto.impl.ProductServiceImpl;

@WebServlet("/AddtoCart")
public class AddtoCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("username");
		String password = (String) session.getAttribute("password");
		String usertype = (String) session.getAttribute("usertype");

		if (userName == null || password == null || usertype == null || !usertype.equalsIgnoreCase("customer")) {
			response.sendRedirect("login.jsp?message=Session Expired, Login Again to Continue!");
			return;
		}

		String userId = userName;
		String prodId = request.getParameter("pid");
		int pQty = Integer.parseInt(request.getParameter("pqty"));

		CartServiceImpl cart = new CartServiceImpl();
		ProductServiceImpl productDao = new ProductServiceImpl();
		ProductDao product = productDao.getProductDetails(prodId);

		int availableQty = product.getProdQuantity();
		int cartQty = cart.getProductCount(userId, prodId);
		pQty += cartQty;

		String status = "";

		if (pQty == cartQty) {
			status = cart.removeProductFromCart(userId, prodId);
		} else if (availableQty < pQty) {
			if (availableQty == 0) {
				status = "Product is Out of Stock!";
			} else {
				cart.updateProductToCart(userId, prodId, availableQty);
				status = "Only " + availableQty + " " + product.getProdName()
						+ "(s) are available. Added all available items.";
			}

			DemandDao demandDao = new DemandDao(userName, product.getProdId(), pQty - availableQty);
			DemandServiceImpl demand = new DemandServiceImpl();
			boolean flag = demand.addProduct(demandDao);
			if (flag) {
				status += " You’ll be notified when more stock arrives.";
			}
		} else {
			status = cart.updateProductToCart(userId, prodId, pQty);
		}

		// ✅ Update session cart count
		int newCartCount = cart.getCartCount(userId);
		session.setAttribute("cartCount", newCartCount);
		System.out.println("🛒 Updated cart count in session: " + newCartCount);

		// ✅ Redirect properly (important!)
		response.sendRedirect("userHome.jsp?message=" + URLEncoder.encode(status, "UTF-8"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
