

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

@WebServlet("/servletdata")
public class servletdata extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public servletdata() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("zapytanie get");
		PrintWriter output = response.getWriter();
		output.println(" [0] NEW TEST:");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		 StringBuffer jb = new StringBuffer();
		 String line = null;
		  try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null) {
		    	System.out.println(line);
		    	jb.append(line); //wpisanie przychodzącej linii do bufora
		    	parser.par(line); //wywołanie funkcji parsującej przychodzące dane
		    }
		  } catch (Exception e) { /*report an error*/ }
		  PrintWriter output = response.getWriter();
			output.println(" [0] NEW TEST:");
		output.flush();
	}
}
