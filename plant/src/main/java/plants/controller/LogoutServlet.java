package plants.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do") // http://localhost:8080/vgb/logout.do
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LogoutServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false); // 取得之前就產生的session，不要建立新的
		// 1,2. 有session則登出
		if (session != null) {
			// 登出
			session.invalidate();
		}

		// 3. 作法一: 內部轉交給首頁 (會讓轉交後browser上看到的首頁網址是//http://localhost:8080/vgb/logout.do)
		// request.getRequestDispatcher("/").forward(request, response); //
		// http://localhost:8080/vgb/

		// 3. 作法二: 外部轉址(response.sendRedirect(url字串))給首頁
		// (會讓轉交後browser上看到的首頁網址就是http://localhost:8080/vgb/)
		response.sendRedirect(request.getContextPath()); // request.getContextPath(), ./
	}
}
