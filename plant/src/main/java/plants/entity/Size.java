package plants.entity;

public class Size {
	private int productId; // Pkey
	private String colorName = ""; // Pkey
	private String sizeName; // Pkey
	private int stock;
	private double listPrice;
	private double price;

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getColorName() {
		return colorName;
	}

	public void setColorName(String colorName) {
		if (colorName == null)
			colorName = "";
		this.colorName = colorName;
	}

	public String getSizeName() {
		return sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public double getListPrice() {
		return listPrice;
	}

	public void setListPrice(double listPrice) {
		this.listPrice = listPrice;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + productId;
		result = prime * result + ((colorName == null) ? 0 : colorName.hashCode());
		result = prime * result + ((sizeName == null) ? 0 : sizeName.hashCode());
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
		Size other = (Size) obj;
		if (productId != other.productId)
			return false;
		if (colorName == null) {
			if (other.colorName != null)
				return false;
		} else if (!colorName.equals(other.colorName))
			return false;
		if (sizeName == null) {
			if (other.sizeName != null)
				return false;
		} else if (!sizeName.equals(other.sizeName))
			return false;
		return true;
	}

}
