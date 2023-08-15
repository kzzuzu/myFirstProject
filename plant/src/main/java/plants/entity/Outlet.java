package plants.entity;

public class Outlet extends Product {
	private int discount; // 必要, 1~90% off

	public Outlet() {
	}

	public Outlet(int id, String name, double price) {
		super(id, name, price);
	}

	public Outlet(int id, String name, double unitPrice, int discount) {
		super(id, name, unitPrice);
		this.setDiscount(discount);
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if (discount >= 1 && discount <= 90) {
			this.discount = discount;
		} else {
			System.err.println("Outlet折扣必須在1~90% off之間");
		}
	}

	public String getDiscountString() {
		int discount = 100 - this.discount;
		if (discount % 10 == 0)
			discount /= 10;

		return discount + "折";
	}

	/**
	 * 查詢折扣後的售價(父類別Product的getUnitPrice()取得定價做折扣計算)
	 * 
	 * @return double型態的售價
	 */
	@Override
	public double getUnitPrice() {
		double price = super.getUnitPrice() * (100D - discount) / 100;
		return price;
	}

	/**
	 * 查詢定價(父類別Product的getUnitPrice()取得定價)
	 * 
	 * @return double型態的定價
	 */
	public double getListPrice() {
		return super.getUnitPrice();
	}

	@Override
	public String toString() {
		return super.toString() + "\ndiscount=" + discount + "% off, 享有" + getDiscountString() + ", 售價: "
				+ getUnitPrice();
	}

//	@Override
//	public int hashCode() {
//		final int prime = 31;
//		int result = super.hashCode();
//		result = prime * result + discount;
//		return result;
//	}

//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (!super.equals(obj))
//			return false;
//		if (getClass() != obj.getClass())
//			return false;
//		Outlet other = (Outlet) obj;
//		if (discount != other.discount)
//			return false;
//		return true;
//	}	

}
