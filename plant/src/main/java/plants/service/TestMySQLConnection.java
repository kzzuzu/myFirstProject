package plants.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import plants.exception.VGBException;

class TestMySQLConnection {
	public static void main(String[] args) {
		try (Connection connection = MySQLConnection.getConnection(); // 1.2 取得連線
		) {
			System.out.println(connection.getCatalog());
		} catch (SQLException e) {
			Logger.getLogger("建立資料庫連線測試").log(Level.SEVERE, "建立連線失敗", e);
		} catch (VGBException e) {
			Logger.getLogger("建立資料庫連線測試").log(Level.SEVERE, "系統錯誤", e);
		}
		System.out.println("The End");
	}
}