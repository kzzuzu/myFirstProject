<%-- 
    Document   : snackbar
    Created on : 2018/6/11, 上午 11:30:38
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- 以下為toast程式 -->
<style>
    #snackbar {
        visibility: hidden;
        min-width: 250px;
        margin-left: -125px;
        background-color: orange;
        color: #fff;
        text-align: center;
        border-radius: 2px;
        padding: 16px;
        position: fixed;
        z-index: 100000;
        left: 50%;
        top: 50%;
        font-size: 17px;
    }

    #snackbar.show {
        visibility: visible;
        -webkit-animation: fadein 0.5s, fadeout 0.5s  0.8s;
        animation: fadein 0.5s, fadeout 0.5s  1.8s;
    }

    @-webkit-keyframes fadein {
        from {top: 0; opacity: 0;} 
        to {top: 50%; opacity: 1;}
    }

    @keyframes fadein {
        from {top: 0; opacity: 0;}
        to {top: 50%; opacity: 1;}
    }

    @-webkit-keyframes fadeout {
        from {top: 50%; opacity: 1;} 
        to {top: 0; opacity: 0;}
    }

    @keyframes fadeout {
        from {top: 50%; opacity: 1;}
        to {top: 0; opacity: 0;}
    }
</style>        
<script>
    function toastMessage(msg) {
        var x = document.getElementById("snackbar");
        x.innerHTML = msg;
        x.className = "show";
        setTimeout(function () {
            x.className = x.className.replace("show", "");
        }, 2300); //此根據css show方法fadeout所需時間相加
    }
</script>        
<div id="snackbar"></div>
<!-- 以上為toast程式 -->