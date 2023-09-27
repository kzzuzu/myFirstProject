package plants.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import plants.entity.Customer;
import plants.entity.Order;
import plants.entity.PaymentType;
import plants.entity.ShippingType;
import plants.entity.ShoppingCart;
import plants.exception.VGBException;
import plants.exception.VGBStockShortageException;
import plants.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckOutServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errorList = new ArrayList<>();
		HttpSession session = request.getSession();
		Customer member = (Customer) session.getAttribute("member");
		ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

		if (cart == null || cart.isEmpty()) {
			response.sendRedirect("cart.jsp");
			return;
		}

		// 1.取得request中的form data
		String paymentType = request.getParameter("paymentType");
		String shippingType = request.getParameter("shippingType");
		String shippingAddr = request.getParameter("shippingAddr");

		String recipientName = request.getParameter("name");
		String recipientEmail = request.getParameter("email");
		String recipientPhone = request.getParameter("phone");

		PaymentType thePType = null; // 將paymentType字串轉為對應的
		if (paymentType == null || paymentType.length() == 0) {
			errorList.add("必須選擇付款方式");
		} else {
			try {
				thePType = PaymentType.valueOf(paymentType);
			} catch (Exception ex) {
				errorList.add("錯誤的付款方式");
			}
		}

		ShippingType theShippingType = null; // 將shippingType字串轉為對應的
		if (shippingType == null || shippingType.length() == 0) {
			errorList.add("必須選擇取貨方式");
		} else {
			try {
				theShippingType = ShippingType.valueOf(shippingType);
			} catch (Exception ex) {
				errorList.add("錯誤的取貨方式");
			}
		}

		if (shippingAddr == null || (shippingAddr = shippingAddr.trim()).length() == 0) {
			errorList.add("必須輸入取件地址");
		}

		if (recipientName == null || (recipientName = recipientName.trim()).length() == 0) {
			errorList.add("必須輸入收件人姓名");
		}

		if (recipientEmail == null || (recipientEmail = recipientEmail.trim()).length() == 0) {
			errorList.add("必須輸入收件人Email");
		}

		if (recipientPhone == null || (recipientPhone = recipientPhone.trim()).length() == 0) {
			errorList.add("必須輸入收件人電話");
		}

		// 2. 若無誤, 則呼叫商業邏輯
		String errorsUrl = "check_out.jsp";
		if (errorList.isEmpty()) {
			Order order = new Order();
			order.setCustomer(member);
			order.setOrderDate(LocalDate.now());
			order.setOrderTime(LocalTime.now());

			order.setPaymentType(thePType.name());
			order.setPaymentFee(thePType.getFee());

			order.setShippingType(theShippingType.name());
			order.setShippingFee(theShippingType.getFee());
			order.setShippingAddress(shippingAddr);

			order.setRecipientName(recipientName);
			order.setRecipientEmail(recipientEmail);
			order.setRecipientPhone(recipientPhone);

			order.add(cart);
			OrderService oService = new OrderService();
			try {
				oService.checkOut(order);

				session.removeAttribute("cart");// 結帳成功務必移除session中的cart
				// 3.1 成功內部轉址給check_out_ok.jsp
				request.setAttribute("theOrder", order);
				request.getRequestDispatcher("check_out_ok.jsp").forward(request, response);
				return;
			} catch (VGBStockShortageException e) {
				this.log(e.getMessage(), e); // for admin
				errorList.add(e.getMessage()); // for user
				errorsUrl = "cart.jsp";
			} catch (VGBException e) {
				this.log(e.getMessage(), e);
				errorList.add(e.getMessage());
			} catch (Exception e) {
				this.log("建立訂單發生非預期錯誤", e);
				errorList.add("建立訂單發生非預期錯誤:" + e.getMessage());
			}
		}

		// 3.2 error內部轉交給check_out.jsp
		request.setAttribute("errorList", errorList);
		request.getRequestDispatcher(errorsUrl).forward(request, response);
	}

}
