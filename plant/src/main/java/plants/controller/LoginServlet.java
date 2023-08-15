package plants.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import plants.entity.Customer;
import plants.exception.LoginFailedException;
import plants.exception.VGBException;
import plants.exception.VGBInvalidDataException;
import plants.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = "/login.do") // http://localhost:8080/vgb/login.do
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession(false);
		
		String oldCaptcha2 = (String)session.getAttribute("captchaKey");
		System.out.println("1 == " + oldCaptcha2);
		
		// request.setCharacterEncoding("utf-8"); //這個Form所有的欄位都沒中文, 這行有跟沒有一樣

		// 1.取得request中form data(id, password, captcha), 請看第10章
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String captcha = request.getParameter("captcha");
		// System.out.println(captcha);
		// 檢查有無錯誤: 必要欄位的檢查
		if (id == null || (id = id.trim()).length() == 0) {
			errors.add("必須輸入帳號或email");
		}

		if (password == null || password.length() == 0) {
			errors.add("必須輸入密碼");
		}

    	if(captcha==null || (captcha=captcha.trim()).length()==0) {
    		errors.add("必須輸入驗證碼");
    	}else {
    		String oldCaptcha = (String)session.getAttribute("captchaKey");
    		System.out.println(captcha + " == " + oldCaptcha);
    		if(!captcha.equalsIgnoreCase(oldCaptcha)) {
    			errors.add("驗證碼不正確");
    		}
    	}
		session.removeAttribute("LoginCaptchaServlet");// for 資安

		// 2.若檢查無誤，則建立CustomerService物件，並呼叫商業邏輯login
		if (errors.isEmpty()) {
			CustomerService service = new CustomerService();
			try {
				Customer c = service.login(id, password);
				// 3.1 登入成功: 內部轉交(forward)/login_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("/login_ok.jsp");

				session.setAttribute("member", c);// 注意在 [//1.]之前要宣告並取得session
				Object prevURI = session.getAttribute("loginCheck.prev.uri");
				Object prevQueryString = session.getAttribute("loginCheck.prev.queryString");
				session.removeAttribute("loginCheck.prev.uri");
				session.removeAttribute("loginCheck.prev.queryString");
				// System.out.printf("%s?%s\n", prevURI, prevQueryString); //for test

				if (prevURI != null) {
					request.setAttribute("prevURI", prevURI);
					if (prevQueryString != null)
						request.setAttribute("prevQueryString", prevQueryString);
				}

				request.setAttribute("msg", "Login");
				dispatcher.forward(request, response);
				return;
			} catch (LoginFailedException e) {
				// this.log(e.getMessage());
				errors.add(e.getMessage()); // for user
			} catch (VGBException e) {
				this.log(e.getMessage(), e);// for admin, tester, developer
				errors.add(e.getMessage() + ":" + e + ", 請聯絡系統管理人員"); // for user
			} catch (Exception e) {
				this.log("登入失敗，系統發生非預期錯誤", e); // for admin, tester, developer
				errors.add("系統發生錯誤:" + e + ", 請聯絡系統管理人員"); // for user
			}
		}

		// 3.2 登入失敗: 內部轉交(forward) http://localhost:8080/vgb/login.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		request.setAttribute("errors", errors);
		dispatcher.forward(request, response);
		// return;
	}
}