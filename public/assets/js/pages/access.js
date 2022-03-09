$("#btn_update").on("click", async function(){
  let id         = $(this).attr("data-id");
  let company    = $("#txt_company").val();
  let area       = $("#txt_area").val();
  let department = $("#txt_department").val();
  let params = {id,company,area,department};

  let response = await App.post("/access/update",params).catch(message => App.show_error(message));
  let data = await response.json();
  
  if(data.status == "OK")
    $("#lnk_menu_settings_access").trigger("click");
  else
    App.show_error("Update error.");
});

$("#btn_new").on("click", async function(){
  let company    = $("#txt_company").val();
  let area       = $("#txt_area").val();
  let department = $("#txt_department").val();
  let params = {company,area,department};

  let response = await App.post("/access/new",params).catch(message => App.show_error(message));
  let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_access").trigger("click");
    else
      App.show_error("Update error.");
});