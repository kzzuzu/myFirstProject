package plants.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import plants.entity.Customer;
import plants.exception.VGBException;
import plants.service.OrderService;

/**
 * Servlet implementation class ATMTransferedServlet
 */
@WebServlet("/member/atm_transfer.do")
public class ATMTransferedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ATMTransferedServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer member = (Customer) session.getAttribute("member");
		List<String> errorList = new ArrayList<>();

		// 1.取得request的form data
		String orderId = request.getParameter("orderId");
		String bank = request.getParameter("bank");
		String last5Code = request.getParameter("last5Code");
		String amount = request.getParameter("amount");
		String transDate = request.getParameter("transDate");
		String transTime = request.getParameter("transTime");
		if (orderId == null && member == null) {
			errorList.add("無訂單與訂購人資料");
		}
		if (errorList.isEmpty()) {
			OrderService oService = new OrderService();
			try {
				oService.atmTransfered(member.getId(), orderId, bank, last5Code, Double.parseDouble(amount),
						LocalDate.parse(transDate), transTime);
			} catch (VGBException e) {
				this.log("[通知已轉帳]失敗", e);
				errorList.add("[通知已轉帳]失敗");
			}
		}

		// 3.回歷史訂單
		response.sendRedirect("orders_history.jsp");
		return;
	}
}
