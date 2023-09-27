package plants.service;

import java.util.ArrayList;
import java.util.List;

import plants.entity.Color;
import plants.entity.Outlet;
import plants.entity.Product;
import plants.entity.Size;
import plants.exception.VGBException;

import java.sql.*;
import java.time.LocalDate;

class ProductsDAO {

	private static final String SELECT_ALL_PRODUCTS = "SELECT id, name, unit_price, stock, description, photo_url,"
			+ "	launch_date, category, discount " + "FROM products_view";

	List<Product> selectAllProducts() throws VGBException {
		List<Product> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS); // 3.準備指令
		) {
			// 3.1 傳入?(無)的值

			try (ResultSet rs = pstmt.executeQuery(); // 4.執行指令
			) {
				// 5. 處理rs
				while (rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if (discount > 0) {
						p = new Outlet();
						((Outlet) p).setDiscount(discount);
					} else
						p = new Product();

					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setDescription(rs.getString("description"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
					p.setCategory(rs.getString("category"));

					list.add(p); // 不要忘了
				}
			}
		} catch (SQLException e) {
			throw new VGBException("[查詢全部產品]失敗", e);
		}

		return list;
	}

	private static final String select_Products_By_Keyword = SELECT_ALL_PRODUCTS + " WHERE name LIKE ?";

	List<Product> selectProductsByKeyword(String keyword) throws VGBException {
		List<Product> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Keyword); // 3.準備指令
		) {
			// 3.1 傳入?(1)的值
			pstmt.setString(1, "%" + keyword + "%");

			try (ResultSet rs = pstmt.executeQuery(); // 4.執行指令
			) {
				// 5. 處理rs
				while (rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if (discount > 0) {
						p = new Outlet();
						((Outlet) p).setDiscount(discount);
					} else
						p = new Product();

					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setDescription(rs.getString("description"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
					p.setCategory(rs.getString("category"));

					list.add(p); // 不要忘了
				}
			}
		} catch (SQLException e) {
			throw new VGBException("[用關鍵字查詢產品]失敗", e);
		}

		return list;
	}

	private static final String select_Products_By_Keyword_AndCategory = SELECT_ALL_PRODUCTS
			+ " WHERE name LIKE ? AND category = ?";

	List<Product> selectProductsByKeywordAndCategory(String keyword, String category) throws VGBException {
		List<Product> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Keyword_AndCategory); // 3.準備指令
		) {
			// 3.1 傳入?(1)的值
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, category);

			try (ResultSet rs = pstmt.executeQuery(); // 4.執行指令
			) {
				// 5. 處理rs
				while (rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if (discount > 0) {
						p = new Outlet();
						((Outlet) p).setDiscount(discount);
					} else
						p = new Product();

					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setDescription(rs.getString("description"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
					p.setCategory(rs.getString("category"));

					list.add(p); // 不要忘了
				}
			}
		} catch (SQLException e) {
			throw new VGBException("[用關鍵字查詢產品]失敗", e);
		}

		return list;
	}

	private static final String select_Products_By_Category = SELECT_ALL_PRODUCTS + " WHERE category = ?";

	List<Product> selectProductsByCategory(String category) throws VGBException {
		List<Product> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Category); // 3.準備指令
		) {
			// 3.1 傳入?(1)的值
			pstmt.setString(1, category);

			try (ResultSet rs = pstmt.executeQuery(); // 4.執行指令
			) {
				// 5. 處理rs
				while (rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if (discount > 0) {
						p = new Outlet();
						((Outlet) p).setDiscount(discount);
					} else
						p = new Product();

					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setDescription(rs.getString("description"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
					p.setCategory(rs.getString("category"));

					list.add(p); // 不要忘了
				}
			}
		} catch (SQLException e) {
			throw new VGBException("[用分類查詢產品]失敗", e);
		}

		return list;
	}

//	private static final String select_Product_By_Id=
//			"SELECT id, name, unit_price, stock, description, photo_url, "
//			+ "	launch_date, category, discount"
//			+ "   FROM products"
//			+ " WHERE id=?";

//	private static final String select_Product_By_Id=
//			"SELECT id, name, unit_price, products.stock, description, "
//			+ "	products.photo_url, launch_date, category, discount,"
//			+ "    product_id, color_name, product_colors.stock AS color_stock,"
//			+ "    product_colors.photo_url AS color_photo,"
//			+ "    icon_url, ordinal "
//			+ "FROM products LEFT JOIN product_colors "
//			+ "	ON id=product_id  "
//			+ "    WHERE id = ? "
//			+ "    ORDER BY id, ordinal";

	private static final String select_Product_By_Id = "SELECT id, name, products.unit_price, "
			+ "IFNULL(SUM(product_color_sizes.stock), products.stock)AS stock, description,"
			+ "	products.photo_url, launch_date, category, discount,"
			+ "    product_colors.product_id,  product_colors.color_name,  "
			+ "    IFNULL(SUM(product_color_sizes.stock),product_colors.stock) AS color_stock, "
			+ "    COUNT(product_color_sizes.size_name) AS size_count, "
			// + " SUM(product_color_sizes.stock) AS size_total_stock, "
			+ "    product_colors.photo_url AS color_photo, " + "    icon_url,  product_colors.ordinal "
			+ "FROM products  " + "	LEFT JOIN product_colors ON id=product_id  " + "    LEFT JOIN product_color_sizes "
			+ "			ON products.id = product_color_sizes.product_id "
			+ "				AND (product_colors.color_name = product_color_sizes.color_name "
			+ "					OR product_colors.color_name IS NULL )     " + "    WHERE id = ? "
			+ "    GROUP BY color_name " + "    ORDER BY id,  product_colors.ordinal";

	public Product selectProductById(String id) throws VGBException {
		Product p = null;
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Product_By_Id); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery();// 4.執行指令
			) {
				// 5. 處理rs
				while (rs.next()) {
					// Product p;
					if (p == null) {
						int discount = rs.getInt("discount");
						if (discount > 0) {
							p = new Outlet();
							((Outlet) p).setDiscount(discount);
						} else
							p = new Product();

						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setDescription(rs.getString("description"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
						p.setCategory(rs.getString("category"));

						// System.out.println(p); //for test
					}

					// 檢查是否有size
					p.setHasSize(rs.getInt("size_count") > 0);

					// 檢查是否有顏色
					String colorName = rs.getString("color_name");
					if (colorName != null) {
						Color color = new Color();
						color.setName(colorName);
						color.setStock(rs.getInt("color_stock"));
						color.setPhotoUrl(rs.getString("color_photo"));
						color.setIconUrl(rs.getString("icon_url"));
						color.setOrdinal(rs.getInt("ordinal"));
						System.out.println(color);
						p.addColor(color);
					}
				}
			}
		} catch (SQLException e) {
			throw new VGBException("[用id查詢產品]失敗", e);
		}
		return p;
	}

	private static final String select_Product_Size_List = "SELECT product_id, color_name, size_name, product_color_sizes.stock, "
			+ "	product_color_sizes.unit_price AS list_price, "
			+ "    (product_color_sizes.unit_price * (100-discount) / 100) as unit_price, " + "    ordinal "
			+ "	FROM product_color_sizes" + "		JOIN products ON product_color_sizes.product_id = products.id"
			+ "    WHERE product_id=? AND color_name=?" + "    ORDER BY ordinal";

	List<Size> selectProductSizeList(String productId, String colorName) throws VGBException {
		List<Size> list = new ArrayList<>();

		try (Connection connection = MySQLConnection.getConnection(); // 1, 2 取得connection
				PreparedStatement pstmt = connection.prepareStatement(select_Product_Size_List); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, productId);
			pstmt.setString(2, colorName);

			// 4.執行指令
			try (ResultSet rs = pstmt.executeQuery();) {
				// 5.處理rs
				while (rs.next()) {
					Size size = new Size();
					size.setProductId(rs.getInt("product_id"));
					size.setColorName(rs.getString("color_name"));
					size.setSizeName(rs.getString("size_name"));
					size.setStock(rs.getInt("stock"));
					size.setListPrice(rs.getDouble("list_price"));
					size.setPrice(rs.getDouble("unit_price"));
					list.add(size);
				}
			}
		} catch (SQLException e) {
			String msg = String.format("查詢指定產品(%s-%s)SizeList失敗", productId, colorName);
			throw new VGBException(msg, e);
		}
		return list;
	}

	private static final String select_Product_Size = "SELECT product_id, color_name, size_name, product_color_sizes.stock, "
			+ "	product_color_sizes.unit_price AS list_price, "
			+ "    (product_color_sizes.unit_price * (100-discount) / 100) as unit_price, " + "    ordinal "
			+ "	FROM product_color_sizes" + "		JOIN products ON product_color_sizes.product_id = products.id"
			+ "    WHERE product_id=? AND color_name=? AND size_name=?";

	Size selectProductSize(String productId, String colorName, String sizeName) throws VGBException {
		Size size = null;
		try (Connection connection = MySQLConnection.getConnection(); // 1, 2 取得connection
				PreparedStatement pstmt = connection.prepareStatement(select_Product_Size); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, productId);
			pstmt.setString(2, colorName);
			pstmt.setString(3, sizeName);

			// 4.執行指令
			try (ResultSet rs = pstmt.executeQuery();) {
				// 5.處理rs
				while (rs.next()) {
					size = new Size();
					size.setProductId(rs.getInt("product_id"));
					size.setColorName(rs.getString("color_name"));
					size.setSizeName(rs.getString("size_name"));
					size.setStock(rs.getInt("stock"));
					size.setListPrice(rs.getDouble("list_price"));
					size.setPrice(rs.getDouble("unit_price"));
				}
			}
		} catch (SQLException e) {
			String msg = String.format("查詢指定(%s-%s-%s)Size失敗", productId, colorName, sizeName);
			throw new VGBException(msg, e);
		}
		return size;
	}

	private static final String SELECT_ColorSizeStock = "SELECT stock " + "FROM product_color_sizes "
			+ "WHERE product_id=? AND color_name=? AND size_name=?";

	int selectColorSizeStock(int productId, String colorName, String sizeName) throws VGBException {
		int stock = 0;
		try (Connection connection = MySQLConnection.getConnection(); // 1, 2 取得connection
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ColorSizeStock); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setInt(1, productId);
			pstmt.setString(2, colorName);
			pstmt.setString(3, sizeName);

			// 4.執行指令
			try (ResultSet rs = pstmt.executeQuery();) {
				// 5.處理rs
				while (rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			String msg = String.format("查詢指定(%s-%s-%s)庫存失敗", productId, colorName, sizeName);
			throw new VGBException(msg, e);
		}
		return stock;
	}

	private static final String SELECT_ColorStock = "SELECT stock " + "	FROM product_colors"
			+ "	WHERE product_id=? AND color_name=?";

	int selectColorStock(int productId, String colorName) throws VGBException {
		int stock = 0;
		try (Connection connection = MySQLConnection.getConnection(); // 1, 2 取得connection
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ColorStock); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setInt(1, productId);
			pstmt.setString(2, colorName);

			// 4.執行指令
			try (ResultSet rs = pstmt.executeQuery();) {
				// 5.處理rs
				while (rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			String msg = String.format("查詢指定(%s-%s)庫存失敗", productId, colorName);
			throw new VGBException(msg, e);
		}
		return stock;
	}

	private static final String SELECT_ProductStock = "SELECT stock " + "	FROM products" + "	WHERE id=?";

	int selectProductStock(int productId) throws VGBException {
		int stock = 0;
		try (Connection connection = MySQLConnection.getConnection(); // 1, 2 取得connection
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ProductStock); // 3.準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setInt(1, productId);

			// 4.執行指令
			try (ResultSet rs = pstmt.executeQuery();) {
				// 5.處理rs
				while (rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			String msg = String.format("查詢指定(%s)庫存失敗", productId);
			throw new VGBException(msg, e);
		}
		return stock;
	}
}
