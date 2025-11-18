package com.shop.dto;

import java.io.InputStream;
import java.util.List;

import com.shop.dao.ProductDao;

public interface ProductService {

	public String addProduct(String prodName, String prodType, String prodInfo, double prodPrice, int prodQuantity,
			InputStream prodImage);

	public String addProduct(ProductDao product);

	public String removeProduct(String prodId);

	public String updateProduct(ProductDao prevProduct, ProductDao updatedProduct);

	public String updateProductPrice(String prodId, double updatedPrice);

	public List<ProductDao> getAllProducts();

	public List<ProductDao> getAllProductsByType(String type);

	public List<ProductDao> searchAllProducts(String search);

	public byte[] getImage(String prodId);

	public ProductDao getProductDetails(String prodId);

	public String updateProductWithoutImage(String prevProductId, ProductDao updatedProduct);

	public double getProductPrice(String prodId);

	public boolean sellNProduct(String prodId, int n);

	public int getProductQuantity(String prodId);
}
