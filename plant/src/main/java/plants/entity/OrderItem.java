package plants.entity;

public class OrderItem {
	private int orderId; // PKey
	private Product product; // PKey
	private Color color; // PKey
	private String size = ""; // PKey
	private double price; // 交易時價格
	private int quantity; // 交易時價格

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

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

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getDisplayedColorSizeName() {
		String displayedName = getColorName();
		if (size != null && size.length() > 0) {
			if (displayedName.length() > 0)
				displayedName += "/";
			displayedName += size;
		}

		return displayedName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	// 依據畫面欄位加getters
	public String getPhotoUrl() {
		if (color != null) {
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
		if (size != null && size.length() > 0) {
			String name = (color != null ? "/" : "");
			name += size;
			return name;
		}
		return "";
	}

	public double getAmount() {
		return price * quantity;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + orderId;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
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
		OrderItem other = (OrderItem) obj;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (orderId != other.orderId)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
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
		return "OrderItem [" + "照片url=" + getPhotoUrl() + ",\n 產品名稱=" + getProductName() + ", 顏色/Size=" + getColorName()
				+ getSizeName() + ",\n 交易價=" + getPrice() + ", 交易數量=" + getQuantity() + ", 小計=" + getAmount() + "]";
	}

}
