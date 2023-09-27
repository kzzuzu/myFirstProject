package plants.entity;

public class Color implements Comparable<Color> {
	private String name; // PKey
	private int stock; // required
	private String photoUrl;
	private String iconUrl;
	private int ordinal; // 以此為序

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public String getIconUrl() {
		return iconUrl;
	}

	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}

	public int getOrdinal() {
		return ordinal;
	}

	public void setOrdinal(int ordinal) {
		this.ordinal = ordinal;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Color))
			return false;
		Color other = (Color) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "顏色 [" + name + ", 庫存=" + stock + ", \n圖片網址=" + photoUrl + ", \n小圖網址=" + iconUrl + ", \n順序=" + ordinal
				+ "]";
	}

	@Override
	public int compareTo(Color otherColor) {
		return this.ordinal - otherColor.ordinal;
	}

}
