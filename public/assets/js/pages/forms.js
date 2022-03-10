$("#btn_create").on("click", async function(){
    let form_number = $("#txt_form_number").val();
    if(form_number.length > 0)
    {
        let form_data = JSON.stringify(App.form_data());
        let type_id = $(this).attr("data-type-id");
        let params = {form_number,form_data,type_id};
        let response = await App.post("/forms/new",params).catch(message => App.show_error(message));
        let data_response = await response.json();
        if(data_response.status == "OK")
            App.show_success(data_response.message,() => $(".search-status").first().trigger("click") );
    }
    else
    {
        $("#txt_form_number").css("border-color","#fc5757");
        $("#txt_form_number").on("input",function(){
            $(this).css("border-color","#f6f9fc");
        });
        App.show_error("Form number field is empty.");
    }
});