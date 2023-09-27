package plants.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import plants.entity.Customer;
import plants.entity.Order;
import plants.exception.VGBException;

public class OrderService {
	private OrdersDAO dao = new OrdersDAO();

	public void checkOut(Order order) throws VGBException {
		dao.insert(order);
	}

	public List<Order> getOrdersHistory(Customer member) throws VGBException {
		if (member == null)
			throw new IllegalArgumentException("查詢歷史訂單會員不得為null");

		List<Order> list = dao.selectOrdersHistory(member.getId());
		return list;
	}

	public Order getOrderById(Customer member, String orderId) throws VGBException {
		if (member == null)
			throw new IllegalArgumentException("查詢訂單會員物件不得為null");
		Order order = dao.selectOrderById(member.getId(), orderId);
		if (order != null)
			order.setCustomer(member);
		return order;
	}

	public void atmTransfered(String memberId, String orderId, String bank, String last5Code, double amount,
			LocalDate transDate, String transTime) throws VGBException {
		String paymentNote = bank + ",後5碼:" + last5Code + ",金額: " + amount + ",時間:" + transDate + " " + transTime;
		dao.updateStatusToATMTransfered(memberId, orderId, paymentNote);
	}

	public void updateOrderStatusToPAID(Customer member, String orderId, String cardF6, String cardL4, String auth,
			String paymentDate, String amount) throws VGBException {
		StringBuilder paymentNote = new StringBuilder("信用卡號:");
		paymentNote.append(cardF6 == null ? "4311-95" : cardF6).append("**-****")
				.append(cardL4 == null ? 2222 : cardL4);
		paymentNote.append(",授權碼:").append(auth == null ? "777777" : auth);
		paymentNote.append(",交易時間:").append(paymentDate == null ? LocalDateTime.now() : paymentDate); // 必須import
																										// java.time.LocalDateTime
//        paymentNote.append(",刷卡金額:").append(amount);
		System.out.println("orderId = " + orderId);
		System.out.println("memberId = " + member.getId());
		System.out.println("paymentNote = " + paymentNote);
		dao.updateOrderStatusToPAID(member.getId(), Integer.parseInt(orderId), paymentNote.toString());
	}

//	public List<OrderStatusLog> getOrderStatusLog(String orderId)//記得要import OrderStatusLog
//	          throws VGBException{
//	       return dao.selectOrderStatusLog(orderId);
//	}
}
