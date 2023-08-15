package plants.entity;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import plants.exception.VGBInvalidDataException;

public class ShoppingCart {
	private Customer member;
	private Map<CartItem, Integer> cartMap = new HashMap<>();

	public Customer getMember() {
		return member;
	}

	public void setMember(Customer member) {
		this.member = member;
	}

	// 用accessers方法取代集合型態屬性cartMap的getters:
	// 以下4個business方法是利用delegate method來產生的
	public int size() {// 幾項
		return cartMap.size();
	}

	public boolean isEmpty() { // 購物車是不是空的
		return cartMap.isEmpty();
	}

	/**
	 * 取得指定CartItem的購買數量
	 * 
	 * @param 指定的item
	 * @return 該item的購買數量(int)
	 */
	public int getQuantity(CartItem item) {
		if (item == null)
			throw new IllegalArgumentException("取得明細購買數量時，cartitem物件不得為null");
		Integer qty = cartMap.get(item);
		return qty != null ? qty : 0;
	}

	public Double getListPrice(CartItem item) {
		if (item.getProduct() instanceof Outlet) {
			return item.getListPrice();
		} else {
			return item.getUnitPrice();
		}
	}

	public String getDiscountString(CartItem item) {
		if (!(item.getProduct() instanceof Outlet) && member instanceof VIP) {
			return "VIP " + ((VIP) member).getDiscountString();
		} else {
			return item.getDiscountString();
		}
	}

	public Double getUnitPrice(CartItem item) {
		double price;
		if (!(item.getProduct() instanceof Outlet) && member instanceof VIP) {
			price = item.getUnitPrice() * (100 - ((VIP) member).getDiscount()) / 100;
		} else {
			price = item.getUnitPrice();
		}
		return price;
	}

	private NumberFormat priceFormat = NumberFormat.getCurrencyInstance();

	public String getUnitPriceStr(CartItem item) {
		return priceFormat.format(getUnitPrice(item));
	}

	public Set<CartItem> getCartItemSet() {// 取得CartItem清單
		// return (cartMap.keySet()); //不得回傳正本
		return new HashSet<>(cartMap.keySet()); // 應回傳複本
	}

	// 以下3個business method
	/**
	 * 取得指定CartItem的售價*購買數量
	 * 
	 * @param 指定的item
	 * @return 該item的小計金額
	 */
	public double getAmount(CartItem item) {
		if (item == null)
			throw new IllegalArgumentException("取得明細小計金額時，cartitem物件不得為null");
		double amount = this.getUnitPrice(item) * getQuantity(item);
		return amount;
	}

	public double getTotalAmount() { // 計算總金額
		double sum = 0;
		if (cartMap != null && size() > 0) {
			for (CartItem item : cartMap.keySet()) {
				sum += getAmount(item);
			}
		}
		return Math.round(sum);
	}

	public int getTotalQuantity() { // 計算總購買數量
		int sum = 0;
		if (cartMap != null && size() > 0) {
			for (Integer qty : cartMap.values()) {
				sum += (qty != null ? qty : 0);
			}
		}
		return sum;
	}

	// 用mutatters方法取代集合型態屬性cartMap的setters: addCartItem, updateCartItem,
	// removeCartItem
	public void updateCartItem(CartItem currentItem, int quantity) {
		Integer prevQty = cartMap.get(currentItem); // 找出之前加入的購買數量
		if (prevQty != null) { // 有找到才修改
			cartMap.put(currentItem, quantity);
		}
	}

	public void removeCartItem(CartItem currentItem) {
		cartMap.remove(currentItem);
	}

	public void addCartItem(Product p, String colorName, Size size) throws VGBInvalidDataException {
		addCartItem(p, colorName, size, 1);
	}

	public void addCartItem(Product p, String colorName, Size size, int quantity) throws VGBInvalidDataException {
		if (p == null)
			throw new IllegalArgumentException("加入購物車時，產品物件不得為null");
		if (quantity <= 0)
			throw new IllegalArgumentException("加入購物車時，購物數量必須>0");

		Color color = null;

		if (p.getColorCount() > 0 && colorName != null) {
			color = p.findColor(colorName);
			if (color == null) {
				String msg = String.format("加入購物車時，有顏色的產品(%s)，無此顏色(%s)", p.getId(), colorName);
				throw new VGBInvalidDataException(msg);
			}
		} else if (p.getColorCount() > 0 && colorName == null) {
			String msg = String.format("加入購物車時，有顏色的產品(%s)，必須選擇顏色(%s)", p.getId(), colorName);
			throw new VGBInvalidDataException(msg);
		} // TODO: else if(無顏色的產品(1)，不可選[紅]色){ 拋出錯誤}

		if (p.getColorCount() > 0 && p.hasSize() && size == null) {
			String msg = String.format("加入購物車時，有顏色(%s)/Size的產品(%s)，必須選擇Size", colorName, p.getId());
			throw new VGBInvalidDataException(msg);
		} else if (p.getColorCount() == 0 && p.hasSize() && size == null) {
			String msg = String.format("加入購物車時，無顏色/Size的產品(%s)，必須選擇Size()", p.getId());
			throw new VGBInvalidDataException(msg);
		}

		CartItem item = new CartItem();
		item.setProduct(p);
		item.setColor(color);
		item.setSize(size);

		Integer prevQty = cartMap.get(item);
		if (prevQty != null) {
			quantity += prevQty;
		}
		cartMap.put(item, quantity);
	}

	@Override
	public String toString() {
		return "購物車[訂購人:" + member + "\n, 內容:" + cartMap + "\n, 共" + size() + "項, " + getTotalQuantity() + "件, 總金額"
				+ getTotalAmount() + "元]";
	}

}
