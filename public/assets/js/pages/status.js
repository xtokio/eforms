$("#btn_update").on("click", async function(){
    let id          = $(this).attr("data-id");
    let status        = $("#txt_status").val();
    let description = $("#txt_description").val();
    let params = {id,status,description};

    let response = await App.post("/status/update",params).catch(message => App.show_error(message));
    let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_status").trigger("click");
    else
      App.show_error("Update error.");
});

$("#btn_new").on("click", async function(){
  let status        = $("#txt_status").val();
  let description = $("#txt_description").val();
  let params = {status,description};

  let response = await App.post("/status/new",params).catch(message => App.show_error(message));
  let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_status").trigger("click");
    else
      App.show_error("Update error.");
});