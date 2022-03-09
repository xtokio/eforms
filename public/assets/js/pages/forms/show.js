if($("#form_data").length > 0)
    App.form_data_load(JSON.parse($("#form_data").html()));

$("#div_users").focusout(function(e){
    let options = ["add_user","send_to"];
    if(e.relatedTarget == null || !options.includes(e.relatedTarget.className))
    {
        $("#lnk_send_to").next().attr("style","");
        $("#lnk_send_to").children().first().removeClass("rotate");

        $("#lnk_add_user").next().attr("style","");
        $("#lnk_add_user").children().first().removeClass("rotate");
    }
});

$("#lnk_add_user").on("click",function(e){
    e.preventDefault();
    $("#lnk_send_to").next().attr("style","");
    $("#lnk_send_to").children().first().removeClass("rotate");

    if($(this).next().is(':visible'))
    {
        $(this).next().attr("style","");
        $(this).children().first().removeClass("rotate");
    }
    else
    {
        $(this).next().css("visibility","visible");
        $(this).next().css("opacity","1");
        $(this).next().css("display","block");

        $(this).children().first().addClass("rotate");
    }
});

$("#lnk_send_to").on("click",function(e){
    e.preventDefault();
    $("#lnk_add_user").next().attr("style","");
    $("#lnk_add_user").children().first().removeClass("rotate");

    if($(this).next().is(':visible'))
    {
        $(this).next().attr("style","");
        $(this).children().first().removeClass("rotate");
    }
    else
    {
        $(this).next().css("visibility","visible");
        $(this).next().css("opacity","1");
        $(this).next().css("display","block");

        $(this).children().first().addClass("rotate");
    }
});

$(".add_user").on("click", async function(e){
    e.preventDefault();
    let id = $(this).attr("data-id");
    let user_selected = $(this).attr("data-user");
    let assigned_to = $("#div_users").attr("data-users");
    let users_array = $("#div_users").attr("data-users").split(",");
    let duplicate = false;
    
    users_array.forEach(function(user){
        if(user_selected == user)
        {
            duplicate = true;
            App.show_error("User already assigned!");            
        }
    });

    if(!duplicate)
    {
        if(assigned_to == "")
            assigned_to = user_selected;
        else
            assigned_to = assigned_to + "," + user_selected;
        
        let params = {id,assigned_to};
        let response = await App.post("/forms/update/assigned_to",params).catch(message => App.show_error(message));
        let data_response = await response.json();
        if(data_response.status == "OK")
            location.reload();
    }
    
    $("#lnk_add_user").next().attr("style","");
});

$(".remove_user").on("click", async function(e){
    e.preventDefault();
    let id = $(this).attr("data-id");
    let user_selected = $(this).attr("data-user");
    let users_array = $("#div_users").attr("data-users").split(",");
    let assigned_to = "";
    
    users_array.forEach(function(user){
        if(user_selected != user)
        {
            if(assigned_to == "")
                assigned_to = user;
            else
                assigned_to = assigned_to + "," + user;
        }
    });

    let params = {id,assigned_to};
    let response = await App.post("/forms/update/assigned_to",params).catch(message => App.show_error(message));
    let data_response = await response.json();
    if(data_response.status == "OK")
        location.reload();
});

$(".send_to").on("click", async function(e){
    let id        = $(this).attr("data-id");
    let status_id = $(this).attr("data-status");
    let params = {id,status_id};
    let response = await App.post("/forms/update/status",params).catch(message => App.show_error(message));
    let data_response = await response.json();
    if(data_response.status == "OK")
    {
        location.reload();
        $(".search-status").removeClass("active");
        $(`#search-status-${status_id}`).addClass("active");
    }

});

$("#btn_save").on("click", async function(){
    let form_number = $("#txt_form_number").val();
    let form_data = JSON.stringify(App.form_data());
    let id = $(this).attr("data-id");
    let params = {id,form_number,form_data};
    let response = await App.post("/forms/update",params).catch(message => App.show_error(message));
    let data_response = await response.json();
    if(data_response.status == "OK")
        App.show_success(data_response.message);
});

$("#btn_save_comment").on("click", async function(){
    let form_id = $(this).attr("data-id");
    let comment = $("#txt_comment").val();
    let params = {form_id,comment};
    let response = await App.post("/forms/new/comment",params).catch(message => App.show_error(message));
    let data_response = await response.json();
    if(data_response.status == "OK")
        location.reload();
});

$("#btn_attachment_upload").on("click",function(){
    $("#btn_attachment_upload_file").click();
});
$("#btn_attachment_upload_file").change(function(){
    let form_id = $(this).attr("data-id");
    
    $(this).simpleUpload("/upload/attachment/form/"+form_id, {

        start: function(file){
            //upload started
            console.log("upload started");
        },

        progress: function(progress){
            //received progress
            console.log("upload progress: " + Math.round(progress) + "%");
        },

        success: async function(data){
            //upload successful
            console.log("upload successful!");
            console.log(data);
            location.reload();
        },

        error: function(error){
            //upload failed
            console.log("upload error: " + error.name + ": " + error.message);
        }

    });
});    