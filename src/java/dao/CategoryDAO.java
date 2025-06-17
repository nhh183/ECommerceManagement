/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.CategoryDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/**
 *
 * @author User
 */
public class CategoryDAO {

    public List<CategoryDTO> getCategoryList() {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblCategories";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryDTO c = new CategoryDTO(
                        rs.getInt("categoryID"),
                        rs.getString("categoryName"),
                        rs.getString("description")
                );
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean createCategory(CategoryDTO c) {
        String sql = "INSERT INTO tblCategories (categoryName, description) VALUES (?, ?)";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCategory(CategoryDTO c) {
        String sql = "UPDATE tblCategories SET categoryName = ?, description = ? WHERE categoryID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            ps.setInt(3, c.getCategoryID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(int categoryID) {
        String sql = "DELETE FROM tblCategories WHERE categoryID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public CategoryDTO getCategoryById(int categoryID) {
        String sql = "SELECT * FROM tblCategories WHERE categoryID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new CategoryDTO(
                            rs.getInt("categoryID"),
                            rs.getString("categoryName"),
                            rs.getString("description")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<CategoryDTO> searchCategoryByName(String name) {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblCategories WHERE 1=1";
        if (name != null && !name.isEmpty()) {
            sql += " AND categoryName LIKE ?";
        }
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            if (name != null && !name.isEmpty()) {
                ps.setString(1, "%" + name + "%");
            }
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CategoryDTO c = new CategoryDTO(
                            rs.getInt("categoryID"),
                            rs.getString("categoryName"),
                            rs.getString("description")
                    );
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
