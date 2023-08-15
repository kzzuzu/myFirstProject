package plants.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import plants.exception.VGBInvalidDataException;

public class Product extends Object {
	private int id; // 必要,PKey, Auto-Increment
	private String name; // 必要, 1~個字元
	private double unitPrice; // 必要, >0, 售價(即定價)
	private int stock = 5; // 必要, >=0
	private String description = "";
	private String photoUrl;
	private LocalDate launchDate;
	private String category; // 必要, 書籍/文具
	private Map<String, Color> colorsMap = new HashMap<>();
	private boolean hasSize;

	public boolean hasSize() {
		return hasSize;
	}

	public void setHasSize(boolean hasSize) {
		this.hasSize = hasSize;
	}

	// 集合型態的attribute，getter不可直接回傳正本
	public List<Color> getColorsList() {
		if (colorsMap.size() > 0) {
			List<Color> list = new ArrayList<>(colorsMap.values()); // 產生複本
			Collections.sort(list); // 依照Color的ordinal排序
			return list;
		} else {
			return null;
		}
	}

	public int getColorCount() {
		return colorsMap.size();
	}

	public Color findColor(String colorName) {
		if (colorName == null)
			throw new IllegalArgumentException("查顏色物件，名稱不得為null");
		Color color = colorsMap.get(colorName);
		return color;
	}

	// 集合型態的attribute，setter必須改為addColor(mutatter)
	public void addColor(Color color) {
		if (color == null)
			throw new IllegalArgumentException("加入顏色集合的color物件不得為null");
		colorsMap.put(color.getName(), color);
	}

	public Product() {
	}

	public Product(int id, String name, double price) {
		// super();
		this.setId(id);
		this.setName(name);
		this.setUnitPrice(price);
	}

	public Product(int id, String name, double unitPrice, int stock, String category) {
		this(id, name, unitPrice);
		this.setStock(stock);
		this.setCategory(category);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		if (id > 0) {
			this.id = id;
		} else {
			// System.err.printf("產品編號必須>0: %d 不正確", id);
			// 第13章後要改成throw RuntimeException
			String msg = String.format("產品編號必須>0: %d 不正確", id);
			throw new VGBInvalidDataException(msg);
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (name != null && name.length() > 0) {
			this.name = name;
		} else {
			System.err.println("產品名稱必須有1個~的字元: " + name + "不正確");
			// TODO: 第13章後要改成throw RuntimeException
		}
	}

	/**
	 * 查詢售價(即定價)
	 * 
	 * @return double型態的售價(即定價)
	 */
	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		if (unitPrice > 0) {
			this.unitPrice = unitPrice;
		} else {
			System.err.println("產品定價必須>0: " + unitPrice + "不正確");
			// TODO: 第13章後要改成throw RuntimeException
		}
	}

	public int getStock() {
		if (colorsMap != null && colorsMap.size() > 0) {
			int sum = 0;
			Collection<Color> collection = colorsMap.values();
			for (Color color : collection) {
				if (color != null) {
					sum = sum + color.getStock();
				}
			}

			return sum;
		}
		return stock;
	}

	public void setStock(int stock) {
		if (stock >= 0) {
			this.stock = stock;
		} else {
			System.err.println("產品庫存必須>=0: " + stock + "不正確");
			// TODO: 第13章後要改成throw RuntimeException
		}
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public LocalDate getLaunchDate() {
		return launchDate;
	}

	public void setLaunchDate(LocalDate launchDate) {
		this.launchDate = launchDate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return this.getClass().getSimpleName() + " [id=" + id + ", 名稱=" + name + ",\n 定價=" + unitPrice + ", 庫存=" + stock
				+ ",\n 說明=" + description + ",\n 圖片網址=" + photoUrl + ",\n 上架日期=" + launchDate + ", 分類=" + category
				+ ",\n colorsMap=" + this.getColorsList() + ",\n 有size:" + hasSize() + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (obj.getClass() != getClass())
			return false;
		Product other = (Product) obj;
		if (id != other.id)
			return false;
		return true;
	}

//	@Override
//	public boolean equals(Object obj) {
//		if(this == obj) return true;
////		if (obj == null) return false;	//已由instance來判斷null	
//		if(obj instanceof Product) {
//			if(this.id == ((Product)obj).id ) {
//				return true;
//			}
//		}		
//		return false;		
//	}

}
