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

import plants.entity.Color;
import plants.entity.Product;
import plants.entity.ShoppingCart;
import plants.entity.Size;
import plants.exception.VGBException;
import plants.exception.VGBInvalidDataException;
import plants.service.ProductService;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errorList = new ArrayList<>();
		HttpSession session = request.getSession();
		// 已有CharsetFilter來處理中文編碼
		// 1.取得request的Form Data
		String productId = request.getParameter("productId");
		String colorName = request.getParameter("color");
		String sizeName = request.getParameter("size");
		String quantity = request.getParameter("quantity");
		// 2.檢查並呼叫商業邏輯
		if (productId != null) {
			ProductService pService = new ProductService();
			try {
				Product p = pService.getProductById(productId);
				if (p != null && quantity != null && quantity.matches("\\d+")) {
					Size size = null;
					if (p.hasSize() && sizeName != null) {
						if (colorName == null)
							colorName = "";
						size = pService.getProductSize(productId, colorName, sizeName);
						if (size == null) {
							throw new VGBInvalidDataException("size不正確");
						}
					}
					ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
					if (cart == null) {
						cart = new ShoppingCart();
						session.setAttribute("cart", cart);
					}

					int qty = Integer.parseInt(quantity);
					if (qty > 0) {
						cart.addCartItem(p, colorName, size, qty);
					}
				}
			} catch (Exception e) {
				this.log("加入購物車失敗", e);
				errorList.add(e.getMessage());
			}
		} else {
			errorList.add("productId不得為null，quantity必須為正整數");
		}
		System.err.println(errorList);

		// 3. 同步請求 外部轉址 /member/cart.jsp vs 非同步請求 內部轉交 /small_cart_json.jsp
		String ajax = request.getParameter("ajax");
		if (ajax == null) {
			response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
		} else {
			request.getRequestDispatcher("/small_cart_json.jsp").forward(request, response);
		}
		return;
	}
}
