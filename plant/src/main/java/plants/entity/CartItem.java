package plants.entity;

public class CartItem {
	private Product product; // Pkey
	private Color color; // Pkey
	private Size size; // Pkey
	// private int quantity;

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Color getColor() {
		return color;
	}

	public void setColor(Color color) {
		this.color = color;
	}

	public Size getSize() {
		return size;
	}

	public void setSize(Size size) {
		this.size = size;
	}

	/* 根據畫面撰寫getter */
	public String getPhotoUrl() {
		if (color != null && color.getPhotoUrl() != null) {
			return color.getPhotoUrl();
		} else {
			return product.getPhotoUrl();
		}
	}

	public String getProductName() {
		return product.getName();
	}

	public String getColorName() {
		return color != null ? color.getName() : "";
	}

	public String getSizeName() {
		if (size != null) {
			return size.getSizeName();
		}
		return "";
	}

	public String getDisplayedColorSizeName() {
		String name = getColorName();
		if (name != null && name.length() > 0) {
			name += (size != null ? "/" : "");
			name += getSizeName();
			return name;
		}
		return "";
	}

	public Double getListPrice() {
		if (size != null) {
			return size.getListPrice();
		} else {
			if (product instanceof Outlet) {
				return ((Outlet) product).getListPrice();
			} else {
				return null;
			}
		}
	}

	public String getDiscountString() {
		if (product instanceof Outlet) {
			return ((Outlet) product).getDiscountString();
		} else {
			return "";
		}
	}

	public double getUnitPrice() {
		if (size != null) {
			return size.getPrice();
		} else {
			return product.getUnitPrice();
		}
	}

	public int getStock() {
		if (size != null) {
			return size.getStock();
		} else if (color != null) {
			return color.getStock();
		} else {
			return product.getStock();
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + ((size == null) ? 0 : size.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;

		CartItem other = (CartItem) obj;

		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;

		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;

		if (size == null) {
			if (other.size != null)
				return false;
		} else if (!size.equals(other.size))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "購物明細 [圖片網址=" + getPhotoUrl() + "\n, 名稱=" + getProductName() + ", 顏色/size=" + getColorName()
				+ getSizeName() + "\n, 定價=" + getListPrice() + "\n, 優惠價=" + getDiscountString() + ", " + getUnitPrice()
				+ "]";
	}
}
