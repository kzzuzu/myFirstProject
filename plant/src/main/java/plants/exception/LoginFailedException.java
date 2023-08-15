package plants.exception;

/**
 * 用login方法代表帳號密碼不正確的登入失敗
 * 
 * @author Admin
 *
 */
public class LoginFailedException extends VGBException {

	public LoginFailedException() {
		super();
	}

	public LoginFailedException(String message, Throwable cause) {
		super(message, cause);
	}

	public LoginFailedException(String message) {
		super(message);
	}

}
