package plants.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import plants.entity.Color;
import plants.entity.Order;
import plants.entity.OrderItem;
import plants.entity.PaymentType;
import plants.entity.Product;
import plants.exception.VGBException;
import plants.exception.VGBStockShortageException;

class OrdersDAO {

	private static final String UPDATE_products_stock = "UPDATE products SET stock= stock-? "
			+ "	WHERE stock>=? AND id=?";
	private static final String UPDATE_product_colors_stock = "UPDATE product_colors SET stock= stock-?"
			+ "	WHERE stock>=? AND product_id=? AND color_name=?";
	private static final String UPDATE_product_color_sizes_stock = "UPDATE product_color_sizes SET stock= stock-? "
			+ "	WHERE stock>=? AND product_id=? AND color_name=? AND size_name=?";

	private static final String INSERT_orders = "INSERT INTO orders "
			+ "	(id, customer_id, order_date, order_time,status,  " + "    payment_type, payment_fee,  payment_note, "
			+ "    shipping_type, shipping_fee, shipping_address,  "
			+ "    recipient_name, recipient_email, recipient_phone) " + "    VALUES(?,?,?,?,0, ?,?,'', ?,?,?, ?,?,?)";
	private static final String INSERT_order_items = "INSERT INTO order_items "
			+ "	(order_id, product_id, color_name, size_name, price, quantity) " + "    VALUES(?,?,?,?, ?,?)";

	void insert(Order order) throws VGBException {

		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt01 = connection.prepareStatement(UPDATE_products_stock);
				PreparedStatement pstmt02 = connection.prepareStatement(UPDATE_product_colors_stock);
				PreparedStatement pstmt03 = connection.prepareStatement(UPDATE_product_color_sizes_stock);
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_orders, Statement.RETURN_GENERATED_KEYS); // 3.準備指令1
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_order_items); // 3.準備指令2
		) {

			connection.setAutoCommit(false); // connection.beginTran
			try {
				// 庫存管理
				if (order.getOrderItemSet() != null && order.size() > 0) {
					for (OrderItem orderItem : order.getOrderItemSet()) {
						PreparedStatement pstmt;
						if (orderItem.getSize() != null && orderItem.getSize().length() > 0) {
							pstmt = pstmt03;
							pstmt.setString(4, orderItem.getColorName());
							pstmt.setString(5, orderItem.getSize());
						} else if ((orderItem.getSize() == null || orderItem.getSize().length() == 0)
								&& orderItem.getColor() != null) {
							pstmt = pstmt02;
							pstmt.setString(4, orderItem.getColorName());
						} else {
							pstmt = pstmt01;
						}
						// 3.1 pstmt01, 02, 03的?值
						pstmt.setInt(1, orderItem.getQuantity());
						pstmt.setInt(2, orderItem.getQuantity());
						pstmt.setInt(3, orderItem.getProduct().getId());

						// 4.執行修改庫存的指令
						int rows = pstmt.executeUpdate();
						if (rows == 0) {
							throw new VGBStockShortageException(orderItem);
						}
						// System.out.println("修改成功: "+orderItem);
					}
				} else {
					throw new VGBException("建立訂單必須有明細");
				}

				// 3.1. 傳入pstmt1的?的值
				pstmt1.setInt(1, order.getId());
				pstmt1.setString(2, order.getCustomer().getId());
				pstmt1.setString(3, order.getOrderDate().toString());
				pstmt1.setString(4, order.getOrderTime().toString());

				pstmt1.setString(5, order.getPaymentType());
				pstmt1.setDouble(6, order.getPaymentFee());

				pstmt1.setString(7, order.getShippingType());
				pstmt1.setDouble(8, order.getShippingFee());
				pstmt1.setString(9, order.getShippingAddress());

				pstmt1.setString(10, order.getRecipientName());
				pstmt1.setString(11, order.getRecipientEmail());
				pstmt1.setString(12, order.getRecipientPhone());

				// 4.執行pstmt1
				pstmt1.executeUpdate();

//				String s = null; //for test
//				System.out.println(s.length()); //for test

				// 取得pstmt1自動給號的值
				try (ResultSet rs = pstmt1.getGeneratedKeys();) {
					while (rs.next()) {
						order.setId(rs.getInt(1));
					}
				}

				if (order.getOrderItemSet() != null && order.size() > 0) {
					for (OrderItem orderItem : order.getOrderItemSet()) {
						// 3.1. 傳入pstmt2的?的值
						pstmt2.setInt(1, order.getId());
						pstmt2.setInt(2, orderItem.getProduct().getId());
						pstmt2.setString(3, orderItem.getColorName());
						pstmt2.setString(4, orderItem.getSize());
						pstmt2.setDouble(5, orderItem.getPrice());
						pstmt2.setInt(6, orderItem.getQuantity());

						// 4.執行pstmt2
						pstmt2.executeUpdate();
					}
				}
				connection.commit();
			} catch (Exception e) {
				connection.rollback();
				throw e;
			} finally {
				connection.setAutoCommit(true);
			}

		} catch (SQLException e) {
			throw new VGBException("建立訂單失敗", e);
		}
	}

	private static final String SELECT_Orders_History = "SELECT id, order_date, order_time, status, "
			+ "payment_type, shipping_type, payment_fee, shipping_fee, "
			+ "	SUM(order_items.price * order_items.quantity) as total_amount " + " FROM orders "
			+ "   JOIN order_items ON orders.id=order_items.order_id " + " WHERE orders.customer_id=? "
			+ "   GROUP BY orders.id " + "   ORDER BY order_date DESC, order_time DESC";

	List<Order> selectOrdersHistory(String customerId) throws VGBException {
		List<Order> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_Orders_History);// 3. 準備指令
		) {
			// 3.1 傳入？的值
			pstmt.setString(1, customerId);

			try (ResultSet rs = pstmt.executeQuery()// 4.執行查詢指令
			) {
				// 5.處理rs
				while (rs.next()) {
					Order order = new Order();
					order.setId(rs.getInt("id"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderTime(rs.getString("order_time"));
					order.setStatus(rs.getInt("status"));

					order.setPaymentType(rs.getString("payment_type"));
					order.setPaymentFee(rs.getDouble("payment_fee"));

					order.setShippingType(rs.getString("shipping_type"));
					order.setShippingFee(rs.getDouble("shipping_fee"));

					order.setTotalAmount(rs.getDouble("total_amount"));

					list.add(order);
				}
			}
		} catch (SQLException e) {
			throw new VGBException("查詢歷史訂單失敗", e);
		}

		return list;
	}

	private static final String select_Order_ById = "SELECT orders.id, customer_id, order_date, order_time, status,  "
			+ "		payment_type, payment_fee, payment_note, shipping_type, shipping_fee, shipping_note,  "
			+ "		shipping_address, recipient_name, recipient_email, recipient_phone, "
			+ "	order_items.product_id, order_items.color_name, order_items.size_name,  "
			+ "		order_items.price, order_items.quantity, " + "		products.name AS product_name,  "
			+ "		IFNULL(product_colors.photo_url,products.photo_url) as photo_url " + " FROM orders "
			+ "   LEFT JOIN order_items ON orders.id=order_items.order_id "
			+ "   LEFT JOIN products ON order_items.product_id = products.id "
			+ "   LEFT JOIN product_colors ON order_items.product_id = products.id "
			+ "	AND order_items.color_name = product_colors.color_name "
			+ "   WHERE orders.customer_id=? AND orders.id=?";

	Order selectOrderById(String customerId, String orderId) throws VGBException {
		Order order = null;
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Order_ById);// 3. 準備指令
		) {
			// 3.1 傳入？的值
			pstmt.setString(1, customerId);
			pstmt.setString(2, orderId);

			System.out.println(pstmt);
			try (ResultSet rs = pstmt.executeQuery()// 4.執行查詢指令
			) {
				// 5.處理rs
				while (rs.next()) {
					if (order == null) {
						order = new Order();
						order.setId(rs.getInt("id"));
						order.setOrderDate(rs.getString("order_date"));
						order.setOrderTime(rs.getString("order_time"));
						order.setStatus(rs.getInt("status"));

						order.setPaymentType(rs.getString("payment_type"));
						order.setPaymentFee(rs.getDouble("payment_fee"));
						order.setPaymentNote(rs.getString("payment_note"));

						order.setShippingType(rs.getString("shipping_type"));
						order.setShippingFee(rs.getDouble("shipping_fee"));
						order.setShippingNote(rs.getString("shipping_note"));
						order.setShippingAddress(rs.getString("shipping_address"));

						order.setRecipientName(rs.getString("recipient_name"));
						order.setRecipientEmail(rs.getString("recipient_email"));
						order.setRecipientPhone(rs.getString("recipient_phone"));
					}

					Integer pId = (Integer) rs.getObject("product_id");
					if (pId != null) {
						OrderItem orderItem = new OrderItem();
						orderItem.setOrderId(order.getId());

						Product p = new Product();
						p.setId(rs.getInt("product_id"));
						p.setName(rs.getString("product_name"));
						p.setPhotoUrl(rs.getString("photo_url"));
						orderItem.setProduct(p);

						String colorName = rs.getString("color_name");
						if (colorName != null && colorName.length() > 0) {
							Color color = new Color();
							color.setName(colorName);
							color.setPhotoUrl(p.getPhotoUrl());
							orderItem.setColor(color);
						}

						orderItem.setSize(rs.getString("size_name"));
						orderItem.setPrice(rs.getDouble("price"));
						orderItem.setQuantity(rs.getInt("quantity"));

						order.addOrderItem(orderItem);
					}
				}
			}
		} catch (SQLException e) {
			throw new VGBException("查詢客戶訂單失敗", e);
		}
		return order;
	}

	private static final String UPDATE_orders_status_To_ATMtransfered = "UPDATE orders" + "	SET payment_note=?, status="
			+ Order.Status.TRANSFERED.ordinal() + "    WHERE customer_id=? AND id=? " + "		AND payment_type='"
			+ PaymentType.ATM.name() + "' AND status=" + Order.Status.NEW.ordinal();

	/**
	 * 通知轉帳
	 * 
	 * @param memberId:    訂購人
	 * @param orderId:     訂單編號
	 * @param paymentNote: 紀錄轉帳相關資訊(銀行名稱, 帳號後5碼,轉帳日期時間,轉帳金額等)
	 * @throws VGBException
	 */
	void updateStatusToATMTransfered(String memberId, String orderId, String paymentNote) throws VGBException {
		try (Connection connection = MySQLConnection.getConnection(); // 1, 2取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_orders_status_To_ATMtransfered); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, paymentNote);
			pstmt.setString(2, memberId);
			pstmt.setString(3, orderId);
			// 4.執行指令
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new VGBException("[通知轉帳]失敗", e);
		}

	}

	private static final String UPDATE_STATUS_TO_PAID = "UPDATE orders" + " SET status=" + Order.Status.PAID.ordinal() // 狀態設定為已付款
			+ ", payment_note=? WHERE customer_id=? AND id=?" + " AND status=0" + " AND payment_type='"
			+ PaymentType.CARD.name() + "'";

	/**
	 * 紀錄信用卡付款相關資料
	 * 
	 * @param memberId:    訂購人
	 * @param orderId:     訂單編號
	 * @param paymentNote: 紀錄信用卡付款相關資料(信用卡號，有效年月、授權碼等)
	 * @throws VGBException
	 */
	void updateOrderStatusToPAID(String memberId, int orderId, String paymentNote) throws VGBException {
		try (Connection connection = MySQLConnection.getConnection(); // 2. 建立連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_PAID) // 3. 準備指令
		) {

			// 3.1 傳入?的值
			pstmt.setString(1, paymentNote);
			pstmt.setString(2, memberId);
			pstmt.setInt(3, orderId);

			// 4. 執行指令
			pstmt.executeUpdate();
		} catch (SQLException ex) {
			System.out.println("修改信用卡付款入帳狀態失敗-" + ex);
			throw new VGBException("修改信用卡付款入帳狀態失敗!", ex);
		}
	}

//	private static final String SELECT_ORDER_STATUS_LOG = "SELECT order_id, update_time, old_status, new_status "
//			+ " FROM vgb.order_logs WHERE order_id=?";
//
//	List<OrderStatusLog> selectOrderStatusLog(String orderId) throws VGBException {
//		List<OrderStatusLog> list = new ArrayList<>();
//		try (Connection connection = MySQLConnection.getConnection();
//				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_STATUS_LOG);) {
//
//			// 3.1 傳入?的值
//			pstmt.setString(1, orderId);
//
//			// 4. 執行指令
//			try (ResultSet rs = pstmt.executeQuery()) {
//				while (rs.next()) {
//					OrderStatusLog log = new OrderStatusLog(); // 記得要import OrderStatusLog
//					log.setId(rs.getInt("order_id"));
//					log.setOldStatus(rs.getInt("old_status"));
//					log.setStatus(rs.getInt("new_status"));
//					log.setLogTime(rs.getString("update_time"));
//					list.add(log);
//				}
//			}
//
//			return list;
//
//		} catch (SQLException ex) {
//			throw new VGBException("查詢訂單狀態Log失敗", ex);
//		}
//	}
}
