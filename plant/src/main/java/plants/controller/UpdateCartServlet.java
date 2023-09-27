package plants.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import plants.entity.CartItem;
import plants.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateCartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errorsList = new ArrayList<>();
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

		if (cart != null && cart.size() > 0) {
			// 1.取得request中的Form Data
			for (CartItem cartItem : cart.getCartItemSet()) {
				String quantity = request.getParameter("quantity" + cartItem.hashCode());
				String delete = request.getParameter("delete" + cartItem.hashCode());
				if (delete == null && quantity != null && quantity.matches("\\d+")) {
					int qty = Integer.parseInt(quantity);
					if (qty == 0) {
						cart.removeCartItem(cartItem);// getCartItemSet()方法若直接return正本，如果可能發生java.util.ConcurrentModificationException
					} else {
						cart.updateCartItem(cartItem, Integer.parseInt(quantity));
					}
				} else if (delete != null) {
					cart.removeCartItem(cartItem); // getCartItemSet()方法若直接return正本，如果可能發生java.util.ConcurrentModificationException
				} else
					errorsList.add("購買數量不正確: " + quantity);
			}
		} else
			errorsList.add("查無購物車!");
		this.log(errorsList.toString());

		// 3.外部轉址給check_out.jsp/cart.jsp
		String submit = request.getParameter("submit");
		if ("checkOut".equals(submit)) {
			response.sendRedirect("check_out.jsp");
		} else {
			response.sendRedirect("cart.jsp");
		}
	}

}
