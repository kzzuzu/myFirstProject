package plants.entity;

import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Calendar;
//import java.text.SimpleDateFormat;

import plants.exception.VGBInvalidDataException;

//import java.lang.String;

public class Customer {
	private String id; // PKey, 符合ROC ID, x
	private String email; // 必要欄位, unique index, x
	private String password; // 必要欄位, 6~20個字元
	private String name; // 必要欄位, 2~20個字元
	private LocalDate birthday; // 必要欄位, 年滿12歲, import java.time.LocalDate, x
//	public java.util.Date birthday; //必要欄位, 年滿12歲, import java.util.Date, x
	private char gender; // 必要欄位, 'F'-女,'M'-男, 'U'-不透漏

	private String address = "";// 非必要欄位

	private String phone = new String(""); // 非必要欄位
	private boolean subscribed; // 非必要欄位

//以下為bloodType屬性	
	private BloodType bloodType; // 非必要欄位

	public BloodType getBloodType() {
		return bloodType;
	}

	public void setBloodType(BloodType bloodType) {
		this.bloodType = bloodType;
	}

	public void setBloodType(String bloodType) {
		if (bloodType != null && (bloodType = bloodType.trim()).length() > 0) {
			try {
				this.setBloodType(BloodType.valueOf(bloodType));
			} catch (IllegalArgumentException ex) {
				throw new VGBInvalidDataException("客戶血型不正確: " + bloodType);
			}
		}
	}
//以上為bloodType屬性	

	public Customer() {
	}

	public Customer(String id, String email, String password) { // worker
		// super();
		this.setId(id);
		this.setEmail(email);
		this.setPassword(password);
	}

	public Customer(String id, String email, String password, String name) {
		this(id, email, password); // caller
		this.setName(name);
	}

	public String getId() throws Error, RuntimeException {
		return id;
	}

	public void setId(String id) {
		if (checkId(id)) {
			this.id = id;
		} else {
			// System.err.println("客戶id必須符合ROC ID規則: " + id);
			// 第13章後要改成throw RuntimeException
			throw new VGBInvalidDataException("客戶id必須符合ROC ID規則: " + id);
		}
	}

	public static final String ID_PATTERN = "[A-Z][1289]\\d{8}";
	public static final int MAX_ID_LENGTH = 10;

	public static boolean checkId(String id) {
		if (id != null && id.matches(ID_PATTERN)) {
			// 1.將id第0碼字元轉成對應的整數(10~35)
			char firstChar = id.charAt(0);
			int firstNumber = -1;
			if (firstChar >= 'A' && firstChar <= 'H') {
				firstNumber = firstChar - 'A' + 10;
			} else if (firstChar >= 'J' && firstChar <= 'N') {
				firstNumber = firstChar - 'J' + 18;
			} else if (firstChar >= 'P' && firstChar <= 'V') {
				firstNumber = firstChar - 'P' + 23;
			} else {
				switch (firstChar) {
				default:
					return false; // 當第0碼不是A~Z，直接回傳身分證號不正確(false)
				case 'X':
					firstNumber = 30;
					break;
				case 'Y':
					firstNumber = 31;
					break;
				case 'W':
					firstNumber = 32;
					break;
				case 'Z':
					firstNumber = 33;
					break;
				case 'I':
					firstNumber = 34;
					break;
				case 'O':
					firstNumber = 35;
				}
			}
			// System.out.println("firstNumber:" + firstNumber); //for test

			// 2.將firstNumber的十位數*1 + 個位數*9
			int sum = (firstNumber / 10) + (firstNumber % 10) * 9;
			// System.out.printf("sum: %s\n" , sum); //sum: 1 , for test

			// 3.將第1~9碼數字字元轉成對應的整數('0'~'9' 轉成 0~9的整數)，依公式加總計算
			// 以A123456789為例
			// (1*1+0*9) + (1*8) + (2*7)+ (3*6) + (4*5) + (5*4) + (6*3) + (7*2) + (8*1) +
			// (9*0), sum為121....
			for (int i = 1, j = 8; i < 10; i++, j--) {
				char nthChar = id.charAt(i);
				// sum = sum+(nthChar-'0') * j;
				sum += (nthChar - '0') * (j > 0 ? j : 1);
				// System.out.printf("第%d碼:%s*%d , sum: %s\n",i ,id.charAt(i),(j>0?j:1), sum);
				// //for test
			}

			return sum % 10 == 0;
		} else
			return false;
	}

	public String getEmail() {
		return email;
	}

	public static final String EMAIL_PATTERN = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";

	public static boolean checkEmail(String email) {
		return email != null && email.matches(EMAIL_PATTERN);
	}

	public void setEmail(String email) {
		if (checkEmail(email)) {// google email reqular expression
			this.email = email;
		} else {
			// System.err.printf("email必須輸入且符合email應有格式:%s\n", email);
			// 第13章後要改成throw RuntimeException
			String msg = String.format("email必須輸入且符合email應有格式:%s\n", email);
			throw new VGBInvalidDataException(msg);
		}
	}

	public static final int MIN_PWD_LENGTH = 6;
	public static final int MAX_PWD_LENGTH = 20;

	public void setPassword(String pwd) {
		if (pwd != null && pwd.length() >= MIN_PWD_LENGTH && pwd.length() <= MAX_PWD_LENGTH) {
			this.password = pwd;
		} else {
			// System.err.printf("密碼必須輸入%d~%d個字元: [%s] 不正確\n",MIN_PWD_LENGTH,MAX_PWD_LENGTH,
			// pwd);
			// 第13章後要改成throw RuntimeException
			String msg = String.format("密碼必須輸入%d~%d個字元: [%s] 不正確\n", MIN_PWD_LENGTH, MAX_PWD_LENGTH, pwd);
			throw new VGBInvalidDataException(msg);
		}
	}

	public String getPassword() {
		return password;
	}

	public static final int MIN_NAME_LENGTH = 2;
	public static final int MAX_NAME_LENGTH = 20;

	public void setName(String n) {
		if (n != null && n.length() >= MIN_NAME_LENGTH && n.length() <= MAX_NAME_LENGTH) {
			this.name = n;
		} else {
			// System.err.printf("姓名必須輸入%d~%d個字元: [%s]
			// 不正確\n",MIN_NAME_LENGTH,MAX_NAME_LENGTH, n);
			// 第13章後要改成throw RuntimeException
			String msg = String.format("姓名必須輸入%d~%d個字元: [%s] 不正確\n", MIN_NAME_LENGTH, MAX_NAME_LENGTH, n);
			throw new VGBInvalidDataException(msg);
		}
	}

	public String getName() {
		return this.name;
	}

	public LocalDate getBirthday() {
		return birthday;
	}

	public static final int MIN_AGE = 12;

	public void setBirthday(LocalDate birthday) {
		if (birthday != null && getAge(birthday) >= MIN_AGE) {
			this.birthday = birthday;
		} else {
			// System.err.printf("客戶生日為必要欄位且須年滿%d歲: %s\n" ,MIN_AGE, birthday);
			// 第13章後要改成throw RuntimeException
			String msg = String.format("客戶生日為必要欄位且須年滿%d歲: %s\n", MIN_AGE, birthday);
			throw new VGBInvalidDataException(msg);
		}
	}

	public char getGender() {
		return gender;
	}

	public static final char MALE = 'M';
	public static final char FEMALE = 'F';
	public static final char UNKNOWN = 'U';

	public void setGender(char gender) {
		if (gender == MALE || gender == FEMALE || gender == UNKNOWN) {
			this.gender = gender;
		} else {
			// System.err.printf("客戶性別資料不正確(%s|%s|%s): %s\n",
			// MALE,FEMALE,UNKNOWN, gender);
			// 第13章後要改成throw RuntimeException，前端Servlet->網頁才收得到
			String msg = String.format("客戶性別資料不正確(%s|%s|%s): %s\n", MALE, FEMALE, UNKNOWN, gender);
			throw new VGBInvalidDataException(msg);
		}
	}

	public String getAddress() {
		return address;
	}

	/**
	 * 
	 * @param address 資料為null將改用空字串指派給address屬性
	 */
	public void setAddress(String address) {
		if (address != null) {
			this.address = address.trim();
		} else {
			this.address = "";
		}
	}

	public String getPhone() {
		return phone;
	}

	/**
	 * 
	 * @param phone allow null
	 */
	public void setPhone(String phone) {
		if (phone != null) {
			this.phone = phone.trim();
		} else {
			this.phone = "";
		}
	}

	public boolean isSubscribed() {
		return subscribed;
	}

	public void setSubscribed(boolean subcribed) {
		this.subscribed = subcribed;
	}

	/**
	 * 計算參數指定日期的年齡
	 * 
	 * @param birthDate(java.time.LocalDate) 指定的出生日期
	 * @return >=0年齡
	 * @exception 客戶無生日資料時拋出VGBInvalidDataException
	 */
	public static int getAge(LocalDate birthDate) {
		int thisYear = LocalDate.now().getYear(); // 取得今年的整數值
		if (birthDate != null) {
			int birthYear = birthDate.getYear(); // 取得birthDate的年的整數值
			int age = thisYear - birthYear;
			return age;
		} else {
			// 第13章，改用throw來處理Exception
			String msg = "客戶無生日資料，無法計算年齡";
			throw new VGBInvalidDataException(msg);
		}
	}

	/**
	 * 計算參數指定日期的年齡，在此專案中用不到這個方法
	 * 
	 * @param birthDate(java.util.Date) 指定的出生日期
	 * @return >=0年齡，或 -1 表示null的出生日日期，無法計算
	 * @exception 客戶無生日資料時拋出VGBInvalidDataException
	 */
	public static int getAge(java.util.Date birthDate) {
		int thisYear = Calendar.getInstance().get(Calendar.YEAR); // 取得今年的整數值
		if (birthDate != null) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(birthDate);
			int birthYear = calendar.get(Calendar.YEAR); // 取得birthDate的年的整數值

			int age = thisYear - birthYear;
			return age;
		} else {
			String msg = "生日資料為null，無法計算年齡";
			throw new VGBInvalidDataException(msg);
		}
	}

	/**
	 * 依據屬性birthday的日期計算客戶年齡，為derived attribute設計示範
	 * 
	 * @return >=12年齡，或 -1 表示屬性birthday為null，無法計算
	 */
	public int getAge() {
		return getAge(this.getBirthday());
	}

	/**
	 * 1.將birthDateString轉成對應的birthday屬性型態<br>
	 * 2.呼叫this.setBirthday(檢查轉換後的日期物件)，來集中年齡限制檢查
	 * 
	 * @param birthDateString 符合iso 8601的生日日期字串，如"2000-01-12"
	 */
	public void setBirthday(String birthDateString) {
		if (birthDateString == null || birthDateString.length() == 0)
			throw new IllegalArgumentException("客戶生日日期字串必須有值: " + birthDateString);
		birthDateString = birthDateString.replace("/", "-");
		try {
			// 1.將birthDateString轉成對應的birthday的型態
			// 當birthday型態為LocalDate(JDK 8以上才提供)
			LocalDate birthDate = LocalDate.parse(birthDateString);

			// 2.呼叫this.setBirthday(檢查轉換後的日期物件) 來集中年齡限制檢查
			this.setBirthday(birthDate);
		} catch (DateTimeParseException ex) { // TODO: java.time.format.DateTimeParseException
			throw new VGBInvalidDataException("客戶生日日期不符合iso-8601: " + birthDateString, ex);
		}
	}

	/**
	 * 
	 * @param year  生日的年份
	 * @param month 生日的月份, 1~12
	 * @param day   生日的日期, 1~28/29, 30, 31
	 */
	public void setBirthday(int year, int month, int day) {
		// 1.將int year, int month, int day轉成對應的birthday的型態
		LocalDate birthDate = LocalDate.of(year, month, day);

		// 2.呼叫this.setBirthday(檢查轉換後的日期物件) 來集中年齡限制檢查
		this.setBirthday(birthDate);
	}

	@Override
	public String toString() {
		return this.getClass().getSimpleName() + "[帳號=" + id + ", email=" + email + ", 密碼=" + password + ", 姓名=" + name
				+ ",\n 生日=" + birthday + ", 性別=" + gender + ", 地址=" + address + ", 電話=" + phone + ", 是否訂閱電子報="
				+ subscribed + (birthday != null ? ", 年齡=" + getAge() + "歲]" : "") + ", 血型: " + bloodType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Customer))
			return false;
		Customer other = (Customer) obj;
		if (this.id == null || other.id == null) {
			return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	// TODO(optinal)
	// enum Gender{
	// MALE('M'),FEMALE('F'),UNKNOWN('U');
	//
	// private char genderCode;
	// private Gender(char genderCode) {
	// this.genderCode = genderCode;
	// }
	//
	// public char getGenderCode() {
	// return genderCode;
	// }
	// }
}
