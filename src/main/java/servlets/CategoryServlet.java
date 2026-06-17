package servlets;

import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    // Method untuk MENAMPILKAN halaman dan isi tabel
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CategoryDAO manager = new CategoryDAO();

        // Ambil semua data dari database
        List<Category> list = manager.getAllCategories(); 

        // Kirim data ke JSP
        request.setAttribute("kategoriList", list); 

        // Pastikan huruf besar/kecil "Category.jsp" sesuai dengan nama file asli Anda
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }

    // Method untuk MEMPROSES form (Nantinya untuk Tambah/Edit/Hapus data)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Jika form yang dikirim adalah perintah Hapus
        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            
            if (idParam != null && !idParam.isEmpty()) {
                int categoryId = Integer.parseInt(idParam);
                CategoryDAO dao = new CategoryDAO();
                
                // Panggil method delete dari DAO Anda
                boolean success = dao.deleteCategory(categoryId);
                
                if (success) {
                    // Opsional: Kirim pesan sukses
                    request.getSession().setAttribute("successMessage", "Category deleted successfully!");
                } else {
                    // Opsional: Kirim pesan gagal
                    request.getSession().setAttribute("errorMessage", "Failed to delete category. Please try again");
                }
            }

        }else if ("add".equals(action)){
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            
            if (name != null && type != null && !name.isEmpty() && !type.isEmpty()){
                Category isiCategory = new Category();
                isiCategory.setName(name);
                isiCategory.setType(type);
                
                CategoryDAO dao = new CategoryDAO();

                // Panggil method delete dari DAO Anda
                boolean success = dao.addCategory(isiCategory);
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Category added successfully!");
                    } else {
                    request.getSession().setAttribute("errorMessage", "Failed to add category. Please try again");
                }
            }
        } else if ("edit".equals(action)) {
            String idParam = request.getParameter("id"); 
            String name = request.getParameter("name");
            String type = request.getParameter("type");

            if (idParam != null && name != null && type != null && !name.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Category isiCategory = new Category();
                    isiCategory.setCategoryID(id); 
                    isiCategory.setName(name);
                    isiCategory.setType(type);

                    CategoryDAO dao = new CategoryDAO();
                    boolean success = dao.updateCategory(isiCategory);

                    if (success) {
                        request.getSession().setAttribute("successMessage", "Category edited successfully!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to edit category.");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMessage", "Invalid ID format.");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Invalid data provided.");
            }
        }
        // Setelah selesai diproses (berhasil atau gagal), kembalikan ke halaman tabel
        response.sendRedirect("category");
    }


}
