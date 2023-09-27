package plants.entity;

public enum PaymentType {
	SHOP(0, "門市付款"), ATM(0, "ATM轉帳"), HOME(50, "貨到付款"), STORE(0, "超商付款"), CARD(0, "信用卡");

	private final double fee; // blank final attribute
	private final String description; // blank final attribute

	private PaymentType(double fee, String description) {
		this.fee = fee;
		this.description = description;
	}

	public double getFee() {
		return fee;
	}

	public String getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return description + (fee > 0 ? ", " + fee + "元" : "");
	}
}
