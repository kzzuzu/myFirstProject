package plants.service;

import plants.entity.Customer;
import plants.exception.LoginFailedException;
import plants.exception.VGBException;

public class CustomerService {
	private CustomersDAO dao = new CustomersDAO();

	public Customer login(String idOrEmail, String password) throws VGBException {
		if (idOrEmail == null || idOrEmail.length() == 0 || password == null || password.length() == 0) {
			throw new IllegalArgumentException("登入時帳號密碼必須有值");
		}

		Customer c = dao.selectCustomerById(idOrEmail);

		if (c != null && c.getPassword().equals(password)) {
			return c;
		}
		throw new LoginFailedException("登入失敗! 帳號或密碼不正確");
	}

	public void register(Customer c) throws VGBException {
		if (c == null) {
			throw new IllegalArgumentException("註冊會員時Customer物件不得為null");
		}

		dao.insert(c);
	}

	public void update(Customer c) throws VGBException {
		if (c == null) {
			throw new IllegalArgumentException("修改會員時Customer物件不得為null");
		}

		dao.update(c);
	}

	public boolean isDuplicateEmail(String email) throws VGBException {
		if (email == null || email.length() == 0) {
			throw new IllegalArgumentException("檢查email是否重複註冊時，必須有email資料");
		}
		Customer c = dao.selectCustomerById(email);
		if (c != null) {
			return c.getEmail().equalsIgnoreCase(email);// 已重複
		}
		return false;
	}

	public boolean isDuplicateId(String id) throws VGBException {
		if (id == null || id.length() == 0) {
			throw new IllegalArgumentException("檢查id是否重複註冊時，必須有id資料");
		}
		Customer c = dao.selectCustomerById(id);
		if (c != null) {
			return c.getId().equals(id); // 已重複
		}
		return false;
	}

}