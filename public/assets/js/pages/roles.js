$("#btn_update").on("click", async function(){
    let id          = $(this).attr("data-id");
    let role        = $("#txt_role").val();
    let description = $("#txt_description").val();
    let params = {id,role,description};

    let response = await App.post("/roles/update",params).catch(message => App.show_error(message));
    let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_roles").trigger("click");
    else
      App.show_error("Update error.");
});

$("#btn_new").on("click", async function(){
  let role        = $("#txt_role").val();
  let description = $("#txt_description").val();
  let params = {role,description};

  let response = await App.post("/roles/new",params).catch(message => App.show_error(message));
  let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_roles").trigger("click");
    else
      App.show_error("Update error.");
});