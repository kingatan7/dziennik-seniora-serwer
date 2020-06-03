<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>  
<%@page import="java.util.Date"%>
<%@page import="java.lang.Object"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Instant"%>
<%
String driver = "com.mysql.jdbc.Driver";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
Statement statementsenior = null;
Statement state_feeling = null;
Statement state_login = null;
Statement statement_wiad = null;
ResultSet resultSet_wiad = null;
ResultSet resultSet = null;
ResultSet resultSetsenior = null;
ResultSet result_feeling = null;
ResultSet r_login = null;
String login_lekarza=request.getParameter("username");
String haslo_lekarza=request.getParameter("password");
String nazwa_seniora=request.getParameter("nazwa_seniora");
String tresc_wiadomosci=request.getParameter("tresc");
if (nazwa_seniora != null && tresc_wiadomosci != null) {
	System.out.println("nazwa " + nazwa_seniora + " tresc: " + tresc_wiadomosci);
	String query = "SELECT tresc FROM wiadomosc WHERE user_klucz LIKE '"+nazwa_seniora+"'";
	connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\kinga\\git\\repository\\telematyka-serwer\\telematyka.db");
	statement_wiad=connection.createStatement();
	resultSet_wiad = statement_wiad.executeQuery(query);
	if(resultSet_wiad.isClosed()){
		String query_wiad = "INSERT INTO wiadomosc(tresc, user_klucz) VALUES (?,?)";
		PreparedStatement pstmt = connection.prepareStatement(query_wiad);
		pstmt.setString(1, tresc_wiadomosci);
		pstmt.setString(2, nazwa_seniora);
		pstmt.executeUpdate();
		connection.close();
	}
	else {
		PreparedStatement ps = null;
		String sql="Update wiadomosc set tresc=? where user_klucz="+nazwa_seniora;
		ps = connection.prepareStatement(sql);
		ps.setString(1,tresc_wiadomosci);
		ps.executeUpdate();
		nazwa_seniora = null;
		tresc_wiadomosci = null;
		connection.close();
	}
}
%>
<!DOCTYPE html>
<html>
<style>
body {
background: #F0F8FF;
}
#titlefont {
font-family: Georgia, serif;
font-size: 25px;
letter-spacing: 1.6px;
word-spacing: 0px;
color: #000000;
font-weight: 700;
text-decoration: none;
font-style: normal;
font-variant: normal;
text-transform: uppercase;
color:#6666FF;
margin-top:50px;
}
.wrapper {
  margin: 15px auto;
  max-width: 1100px;
}

.container-calendar {
  background: #ffffff;
  padding: 15px;
  max-width: 475px;
  margin: 0 auto;
  overflow: auto;
}

.button-container-calendar button {
  cursor: pointer;
  display: inline-block;
  zoom: 1;
  background: #00a2b7;
  color: #fff;
  border: 1px solid #0aa2b5;
  border-radius: 4px;
  padding: 5px 10px;
}

.table-calendar {
  border-collapse: collapse;
  width: 100%;
}

.table-calendar td, .table-calendar th {
  padding: 5px;
  border: 1px solid #e2e2e2;
  text-align: center;
  vertical-align: top;
}

.date-picker.selected {
  font-weight: bold;
  outline: 1px dashed #00BCD4;
}

.date-picker.selected span {
  border-bottom: 2px solid currentColor;
}

/* sunday */
.date-picker:nth-child(1) {
color: red;
}

/* friday */
.date-picker:nth-child(6) {
color: green;
}

#monthAndYear {
  text-align: center;
  margin-top: 0;
}

.button-container-calendar {
  position: relative;
  margin-bottom: 1em;
  overflow: hidden;
  clear: both;
}

#previous {
  float: left;
}

#next {
  float: right;
}

.footer-container-calendar {
  margin-top: 1em;
  border-top: 1px solid #dadada;
  padding: 10px 0;
}

.footer-container-calendar select {
  cursor: pointer;
  display: inline-block;
  zoom: 1;
  background: #ffffff;
  color: #585858;
  border: 1px solid #bfc5c5;
  border-radius: 3px;
  padding: 5px 1em;
}
.result_box {
width: 20%;
height: 100;
background-color:#c0c0c0;
background-position: top center;
float:left;
}
.style_font {
font-family: "Arial Black", Gadget, sans-serif;
font-size: 29px;
letter-spacing: 0.4px;
word-spacing: 2px;
color: #000000;
font-weight: normal;
text-decoration: none;
font-style: italic;
font-variant: normal;
text-transform: none;
}
</style>
<head>
<meta charset="ISO-8859-1">
<title>Dziennik seniora</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>

<%
   String query = "SELECT * from user WHERE Typ='lekarz'";
   String seniors = "Select Login from user Where Typ='senior'";
   connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\kinga\\git\\repository\\telematyka-serwer\\telematyka.db");
   statement=connection.createStatement();
   statementsenior=connection.createStatement();
   resultSet = statement.executeQuery(query);
   resultSetsenior = statementsenior.executeQuery(seniors);
		    	%>
		    	<center><div id="titlefont">Dzienniczek zdrowia seniora</div></center>
		    	<div style="margin-top:70px" id="titlefont">Wybierz pacjenta: </div>
		    	<form style="margin: 70px" name="senior" method="post" action="wyniki-seniora.jsp">
		    	<select name="login">
		    	<%
		    	while(resultSetsenior.next()){
		    	%>
		    	<option>
		    	<%=resultSetsenior.getString("Login")%>
		    	</option>
		    	 <%
		    	}
		    	%></select>
		    	<input type="text" id="datepicker" name="date">
		    	<input type="submit" value="zatwierdz">
		    	</form>
		    	<div style="margin-top:70px" id="titlefont"> Samopoczucie pacjentow: </div>
		    	<div>
		    	<%
 connection.close();

String tod = "2020-06-03";
String feeling = "Select tresc, user_klucz, data from samopoczucie where data Like '%" + tod + "%'";
connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\kinga\\git\\repository\\telematyka-serwer\\telematyka.db");
state_feeling=connection.createStatement();
state_login=connection.createStatement();
result_feeling = state_feeling.executeQuery(feeling);
int i = 0;
try {
	while (result_feeling.next())
		  {
			%><div class="result_box" style="margin:5%" id="res" onclick="javascript:test();"><p class="style_font" >
		    <%=result_feeling.getString("tresc") %> </p> 
		    <% r_login = state_login.executeQuery("Select Login from user where PK Like '" + result_feeling.getString("user_klucz") + "'"); %>
		    <p style="text-align:right"> <%=r_login.getString("Login") %>
		    </p><p><%=result_feeling.getString("data") %></p></div><% } ;
		connection.close();
		} catch (Exception e) {
		e.printStackTrace();
	}
%>
</div>
<div id="wiadomosc" style="visibility:hidden; clear:both;">
<form method="post" name="mess">
Wiadomosc:
<select name="nazwa_seniora" id="login">
		    	<%
		    	seniors = "Select Login, PK from user Where Typ='senior'";
		    	connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\kinga\\git\\repository\\telematyka-serwer\\telematyka.db");
		    	statementsenior=connection.createStatement();
		    	resultSetsenior = statementsenior.executeQuery(seniors);
		    	while(resultSetsenior.next()){
		    	%>
		    	<option value="<%=resultSetsenior.getString("PK") %>">
		    	<%=resultSetsenior.getString("Login")%>
		    	</option>
		    	 <%
		    	}
		    	%></select>
		    	<input type="text" name="tresc" required/>
		    	<input type="submit" value="wyslij" id="mes">
</form>
</div>
</body>
<script type="text/javascript" 
                src= 
"https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"> 
      </script> 
<script>
test = function() {
	this.document.getElementById('wiadomosc').style.visibility='visible';
}
</script>
<script>
    $(document).ready(function() { 
        $("#mes").click(function() { 
            var fn = $("#tresc").val();
            var userid = $('#nazwa_seniora').val();
            $.post("lekarz-domowa.jsp", { 
                tresc: fn,
                nazwa_seniora: userid
            }, function(data) { 
                $("#msg").html(data); 
            }); 

        }); 
    });
</script>

</html>