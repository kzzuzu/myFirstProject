package plants.entity;

public class VIP extends Customer {
	private int discount = 10; // 1% off ~ 90% off

	public VIP() {
	}

	public VIP(String id, String email, String password, String name, int discount) {
		super(id, email, password, name);
		this.setDiscount(discount);
	}

	public VIP(String id, String email, String password, String name) {
		super(id, email, password, name);
	}

	public VIP(String id, String email, String password) {
		super(id, email, password);
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if (discount >= 1 && discount <= 90) {
			this.discount = discount;
		} else {
			System.err.println("VIP折扣必須在1% off ~ 90% off之間");
		}
	}

	public String getDiscountString() {
		int discount = 100 - this.discount;
		if (discount % 10 == 0)
			discount /= 10;
		return discount + "折";
	}

	@Override
	public String toString() {
		return super.toString() + "\ndiscount=" + discount + "% off, 享有" + getDiscountString();
	}

}