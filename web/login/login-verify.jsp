<%-- 
    Document   : login-verify
    Created on : 03 5, 22, 9:31:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/verify-style.css">
        <link rel="stylesheet" href="../assets/css/modal-style.css">
          
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    
        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">
        
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        
         <script language="JavaScript" type="text/javascript" src="../assets/scripts/modal.js"></script>  
        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>
    <body>
        <!-- TODO: CONNECT LOGIN SERVLET -->
        <!-- TODO: CONNECT LOGIN TO VERIFICATION -->
        <!-- navbar -->
        <div class="bar"> 
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                   <i class="fas fa-bars"></i>
            </label>
            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="../home.jsp"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="../home.jsp">Home</a>
                    <a class="option" href="../subpage/about.jsp">About</a>
                    <a class="option" href="../subpage/events.jsp">Events</a>
                    <a class="option" href="../subpage/contact.jsp">Contact</a>
                    <form  action="../login/login.jsp">
                        <input type="submit" value="Login"  class="button"/>
                    </form>
            
                </div>
            </div>
        </div>
        
        <section class="verify-section">
            <form class="verify-container" method="post" action="SignupVerifyServlet">
                <h2>Verify your Identity</h2>
                
                <div class="verify-login-code">
                    <p>For added security, we need to verify your email address. We have sent a verification code to  
                        <span class="verify-email">juan.delacruz.cics@ust.edu.ph</span>
                    </p>
                    
                    <p>If the email does not arrive soon, check your spam folder or have us <a>send it again.</a></p>
                   
                </div>
                
                
                <div class="input-container">   
                    <label for="vcode"><b>Validate OTP</b></label>    
                    <div class="input">
                        <input type="" placeholder="Enter verification code" name="vcode" required>
                    </div>
                </div>
                
                <div class="submit-container">
                    <button id="modalBtn" type="submit">SUBMIT</button>
                    
                </div>
            </form>   
        </section>
        
          <section id="modalSection" class="modal-section">
                <div class="modal-content">
                    <h3 class="modal-header">SUCCESS!</h3>
                    <p class="modal-msg">Your account has been officially verified.</p>   
                    <span class="modal-buttoncon">
<!--                        <span onclick="Home()" class="close modal-button">Home</span>-->
                        <span onclick="Home()" class="modal-button">Got it!</span> 
                    </span>
                </div>
            </section>
    </body>
</html>
