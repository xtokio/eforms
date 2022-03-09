$("#btn_update").on("click", async function(){
    let id        = $(this).attr("data-id");
    let user      = $("#txt_user").val();
    let password  = $("#txt_password").val();
    let name      = $("#txt_name").val();
    let active    = $("#cmb_active").val();
    let photo     = "user.png";
    let role_id   = $("#cmb_role").val();
    let access_id = $("#cmb_access").val();
    let params = {id,user,password,name,active,photo,role_id,access_id};

    let response = await App.post("/users/update",params).catch(message => App.show_error(message));
    let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_users").trigger("click");
    else
      App.show_error("Update error.");
});

$("#btn_new").on("click", async function(){
  let user      = $("#txt_user").val();
  let password  = $("#txt_password").val();
  let name      = $("#txt_name").val();
  let active    = $("#cmb_active").val();
  let photo     = "user.png";
  let role_id   = $("#cmb_role").val();
  let access_id = $("#cmb_access").val();
  let params = {user,password,name,active,photo,role_id,access_id};

  let response = await App.post("/users/new",params).catch(message => App.show_error(message));
  let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_users").trigger("click");
    else
      App.show_error("Update error.");
});