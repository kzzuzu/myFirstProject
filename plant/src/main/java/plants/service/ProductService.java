package plants.service;

import java.util.List;

import plants.entity.CartItem;
import plants.entity.Product;
import plants.entity.Size;
import plants.exception.VGBException;

public class ProductService {
	private ProductsDAO dao = new ProductsDAO();

	public List<Product> getAllProducts() throws VGBException {
		return dao.selectAllProducts();
	}

	public List<Product> getProductsByKeywordAndCategory(String keyword, String category) throws VGBException {
		if (keyword == null || category == null)
			throw new IllegalArgumentException("依關鍵字+分類查詢產品時，keyword或category不得為null");
		return dao.selectProductsByKeywordAndCategory(keyword, category);
	}

	public List<Product> getProductsByKeyword(String keyword) throws VGBException {
		if (keyword == null)
			throw new IllegalArgumentException("依關鍵字查詢產品時，keyword不得為null");
		return dao.selectProductsByKeyword(keyword);
	}

	public List<Product> getProductsByCategory(String category) throws VGBException {
		if (category == null)
			throw new IllegalArgumentException("依分類查詢產品時，category不得為null");
		return dao.selectProductsByCategory(category);
	}

	public Product getProductById(String id) throws VGBException {
		if (id == null)
			throw new IllegalArgumentException("查詢產品尺寸時，productId不得為null");
		return dao.selectProductById(id);
	}

	public List<Size> getProductSizeList(String productId, String colorName) throws VGBException {
		if (productId == null)
			throw new IllegalArgumentException("查詢產品尺寸List時，productId不得為null");
		if (colorName == null)
			colorName = "";

		return dao.selectProductSizeList(productId, colorName);
	}

	public Size getProductSize(String productId, String colorName, String sizeName) throws VGBException {
		if (productId == null)
			throw new IllegalArgumentException("查詢產品尺寸時，productId不得為null");
		if (colorName == null)
			colorName = "";

		return dao.selectProductSize(productId, colorName, sizeName);
	}

	public int getStock(CartItem item) throws VGBException {
		if (item == null || item.getProduct() == null)
			throw new IllegalArgumentException("查詢指定CartItem的即時庫存時，item或product物件不得為null!");
		int stock = 0;
		if (item.getSize() != null) {
			stock = dao.selectColorSizeStock(item.getProduct().getId(), item.getColorName(), item.getSizeName());
		} else if (item.getSize() == null && item.getColor() != null) {
			stock = dao.selectColorStock(item.getProduct().getId(), item.getColorName());
		} else if (item.getSize() == null && item.getColor() == null) {
			stock = dao.selectProductStock(item.getProduct().getId());
		}

		return stock;
	}
}
