var template_code_mirror = CodeMirror.fromTextArea(txt_template, {
    lineNumbers: true
});

$("#btn_show_preview").on("click",function(){
    $("#div_show_preview").html(template_code_mirror.getValue());
    App.components();
    
    location.href = "#div_show_preview";
});

$("#btn_update").on("click", async function(){
    let id          = $(this).data("id");
    let type        = $("#txt_type").val();
    let description = $("#txt_description").val();
    let active      = $("#cmb_active").val();
    let template    = template_code_mirror.getValue();
    let addons      = $(this).data("addons");
    let params = {id,type,description,active,template,addons,addons};

    let response = await App.post("/types/update",params).catch(message => App.show_error(message));
    let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_forms").trigger("click");
    else
      App.show_error("Update error.");
});

$("#btn_new").on("click", async function(){
    let type        = $("#txt_type").val();
    let description = $("#txt_description").val();
    let template    = template_code_mirror.getValue();
    let addons      = "comments,attachments";
    let params = {type,description,template,addons,addons};

    let response = await App.post("/types/new",params).catch(message => App.show_error(message));
    let data = await response.json();
    
    if(data.status == "OK")
      $("#lnk_menu_settings_forms").trigger("click");
    else
      App.show_error("Update error.");
});