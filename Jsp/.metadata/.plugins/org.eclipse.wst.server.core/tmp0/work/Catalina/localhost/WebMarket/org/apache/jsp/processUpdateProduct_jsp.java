/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.65
 * Generated at: 2022-10-17 11:06:00 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;
import java.util.*;
import java.sql.*;

public final class processUpdateProduct_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/dbconn.jsp", Long.valueOf(1665822973000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("com.oreilly.servlet");
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("com.oreilly.servlet.multipart");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');

Connection con = null;
try {
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "shop";
	String password = "1234";
	Class.forName("oracle.jdbc.OracleDriver");
	con = DriverManager.getConnection(url, user, password);
} catch (SQLException ex) {
	out.println("데이터베이스 연결에 실패했습니다.<br>");
	out.println("SQLException : " + ex.getMessage());
}

      out.write('\n');

request.setCharacterEncoding("UTF-8");

MultipartRequest multi = new MultipartRequest(request, "/Users/netpart/Desktop/Dev/Jsp/upload", 5 * 1024 * 1024,
		"UTF-8", new DefaultFileRenamePolicy());

String productId = multi.getParameter("productId");
String name = multi.getParameter("name");
String unitPrice = multi.getParameter("unitPrice");
String description = multi.getParameter("description");
String manufacturer = multi.getParameter("manufacturer");
String category = multi.getParameter("category");
String unitsInStock = multi.getParameter("unitsInStock");
String condition = multi.getParameter("condition");

Integer price;
if (unitPrice.isEmpty())
	price = 0;
else
	price = Integer.valueOf(unitPrice);

long stock;
if (unitsInStock.isEmpty())
	stock = 0;
else
	stock = Long.valueOf(unitsInStock);

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String filename = multi.getFilesystemName(fname);

PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = "select * from product where p_id=?";
pstmt = con.prepareStatement(sql);
pstmt.setString(1, productId);
rs = pstmt.executeQuery();
if (rs.next()) {
	sql = "update product set p_name=? ,p_unitPrice=?," 
	+ "p_description=?, p_manufacturer=?, p_category=?,"
	+ "p_unitsInStock=?, p_condition=?";
	if (filename != null) {
		sql += ", p_fileName=? where p_id=?";
	} else {
		sql += " where p_id=?";
	}
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setInt(2, price);
	pstmt.setString(3, description);
	pstmt.setString(4, manufacturer);
	pstmt.setString(5, category);
	pstmt.setLong(6, stock);
	pstmt.setString(7, condition);

	if (filename != null) {
		pstmt.setString(8, filename);
		pstmt.setString(9, productId);
	} else {
		pstmt.setString(8, productId);
	}
	pstmt.executeUpdate();
}

if (rs != null)
	rs.close();
if (con != null)
	con.close();
if (pstmt != null)
	pstmt.close();

response.sendRedirect("editProduct.jsp?edit=update");

    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
