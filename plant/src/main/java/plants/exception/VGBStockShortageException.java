package plants.exception;

import plants.entity.OrderItem;

public class VGBStockShortageException extends VGBException {
	private final OrderItem theOrderItem;

//	public VGBStockShortageException() {
//		theOrderItem=null;
//	}

	public VGBStockShortageException(OrderItem theOrderItem) {
		super("庫存不足");
		this.theOrderItem = theOrderItem;
	}

	public VGBStockShortageException(OrderItem theOrderItem, String message, Throwable cause) {
		super(message, cause);
		this.theOrderItem = theOrderItem;
	}

	public VGBStockShortageException(OrderItem theOrderItem, String message) {
		super(message);
		this.theOrderItem = theOrderItem;
	}

	@Override
	public String toString() {
		return String.format("訂購項目庫存不足 [%s/%s/%s]", theOrderItem.getProduct().getId(), theOrderItem.getColorName(),
				theOrderItem.getSize());
	}
}
