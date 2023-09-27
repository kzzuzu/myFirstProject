package plants.entity;

public enum BloodType {
	O, A, B, AB;

	@Override
	public String toString() {
		return name() + "型";
	}
}
