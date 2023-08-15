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

//import plants.entity.BloodType;
import plants.entity.Customer;
import plants.exception.VGBException;
import plants.exception.VGBInvalidDataException;
import plants.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		// 1.讀取request中的FormData資料,並檢查
		// (id,email,password1,password2,name,birthday,gender, captcha)
		// (address,phone,bloodType,subscribed)
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String captcha = request.getParameter("captcha");

		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		String bloodType = request.getParameter("bloodType");
		String subscribed = request.getParameter("subscribed");

		if (id == null || (id = id.trim()).length() == 0) {
			errors.add("必須輸入帳號");
		}

		if (email == null || (email = email.trim()).length() == 0) {
			errors.add("必須輸入email");
		}

		if (name == null || (name = name.trim()).length() == 0) {
			errors.add("必須輸入name");
		}

		if (password1 == null || password1.length() == 0) {
			errors.add("必須輸入密碼");
		} else if (!password1.equals(password2)) {
			errors.add("必須輸入一致的密碼與確認密碼");
		}

		if (birthday == null || (birthday = birthday.trim()).length() == 0) {
			errors.add("必須輸入生日");
		}

		if (gender == null || (gender = gender.trim()).length() != 1) {
			errors.add("必須輸入性別");
		}

		if (captcha == null || (captcha = captcha.trim()).length() == 0) {
			errors.add("必須輸入驗證碼");
		} else {
			String oldCaptcha = (String) session.getAttribute("RegisterCaptchaServlet");
			if (!captcha.equalsIgnoreCase(oldCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}

		session.removeAttribute("RegisterCaptchaServlet");// for 資安

		// 2. 若無誤，呼叫商業邏輯
		if (errors.isEmpty()) {
			Customer c = new Customer();
			try {
				c.setId(id);
				c.setEmail(email);
				c.setName(name);
				c.setPassword(password1);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));

				// address, phone, bloodtype, subscribed
				c.setAddress(address);
				c.setPhone(phone);

				// if(bloodType!=null && bloodType.length()>0) {
				// c.setBloodType(BloodType.valueOf(bloodType));
				// }

				c.setBloodType(bloodType);
				c.setSubscribed(subscribed != null);

				CustomerService service = new CustomerService();
				service.register(c);

				// 3.1 登入成功: 內部轉交(forward)/login_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("register_ok.jsp");
				request.setAttribute("member", c);
				request.setAttribute("msg", "註冊");
				dispatcher.forward(request, response);
				return;
			} catch (VGBInvalidDataException ex) {
				errors.add(ex.getMessage()); // for users
			} catch (VGBException ex) {
				errors.add(ex.getMessage() + ",請聯絡系統管理人員"); // for users
				this.log(ex.getMessage(), ex); // for admin, developer, tester
			} catch (Exception ex) {
				errors.add("註冊失敗，系統發生錯誤" + ex + ",請聯絡系統管理人員"); // for users
				this.log("註冊失敗，系統發生非預期錯誤", ex); // for admin, developer, tester
			}

		}

		// 3.2 產生註冊失敗的html, 請看第(9), 13章
		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		request.setAttribute("errors", errors);
		dispatcher.forward(request, response);
		// return;
	}

}
