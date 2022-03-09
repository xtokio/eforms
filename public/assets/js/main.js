$(document).ready(function(){
  
  // Header scroll
  const wrapper = document.querySelector(".wrapper");
  const header = document.querySelector(".header");
  wrapper.addEventListener("scroll", (e) => {
  e.target.scrollTop > 30
    ? header.classList.add("header-shadow")
    : header.classList.remove("header-shadow");
  });

  // Expand Navbar
  $(".nav__list").on("click",function(){
    if($(".body-pd").length == 0)
    {
      $("#navbar").toggleClass("expander");
      $("body").toggleClass("body-pd");
    }
  });

  $("#nav-toggle").on("click",function(){
    $("#navbar").toggleClass("expander");
    $("body").toggleClass("body-pd");

    $(".collapse__link").each(function(lnk){
      $(this).removeClass("rotate");
    });
    $(".collapse__menu").each(function(ul){
      $(this).removeClass("showCollapse");
    });
  });

  $(".nav__link").on("click",function(){
    $(".search-status").removeClass("active");

    $(".nav__link").each(function(lnk){
      $(this).removeClass("active");
    });
    $(this).addClass("active");
  });

  // Collapse Sidebar menus
  $(".collapse").each(function(item){
    $($(this).children()[0]).on("click",function(){
      $($(this).parent().children()[2]).toggleClass("rotate");
      $($(this).parent().children()[3]).toggleClass("showCollapse");
    });
    $($(this).children()[1]).on("click",function(){
      $($(this).parent().children()[2]).toggleClass("rotate");
      $($(this).parent().children()[3]).toggleClass("showCollapse");
    });
    $($(this).children()[2]).on("click",function(){
      $($(this).parent().children()[2]).toggleClass("rotate");
      $($(this).parent().children()[3]).toggleClass("showCollapse");
    });
  });
  

  $("#txt_assume_id").on("click",function(e){
    $(this).parent().addClass("showCollapse");
  });

  // Menu tab navigation
  $(".search-status").on("click",function(){
    $(".search-status").removeClass("active");

    $(this).addClass("active");
  });

  // Expand Table details
  $(".breakrow").on("click",function(){
    $(this).closest("tr").toggleClass("active-row");
    $(this).children().toggleClass('rotate');
    $(this).closest("tr").next("tr").toggle(200);
  });

 });