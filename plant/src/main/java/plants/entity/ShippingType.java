package plants.entity;

public enum ShippingType {
	SHOP(0, "門市取貨"), HOME(100, "宅配"), STORE(65, "超商取貨");

	private final double fee; // blank final attribute
	private final String description; // blank final attribute

	private ShippingType(double fee, String description) {
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
