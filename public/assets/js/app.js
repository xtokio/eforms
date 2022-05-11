class App
{
    static post(url,params={})
    {
        var token = $('meta[name="csrf-token"]').attr('content');
        return fetch(url,{
        method: 'POST',
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'X-CSRF-Token': token
        },
        credentials: 'same-origin',
        body: JSON.stringify(params)
        });
    }
    
    static load_page(page,element="#main",callback=function(){})
    {
        return new Promise(
            async function(resolve,reject)
            {
                // Show full page LoadingOverlay
                // $.LoadingOverlay("show");
                try
                {
                    const response = await fetch(page, {credentials: 'include'});
                    let content = await response.text();
                    
                    if(content.indexOf("<script src=") > -1)
                    {
                        var parser = new DOMParser();
                        var doc = parser.parseFromString(content, 'text/html');
                        var script_tag = doc.querySelector('script');
                        var newScript = document.createElement("script");
                        newScript.src = script_tag.getAttribute("src");

                        content = content.substring(content.indexOf("<script src="),-1);
                        document.querySelector(element).innerHTML = content;
                        
                        document.querySelector(element).appendChild(newScript);
                    }
                    else if(content.indexOf("<script") > -1)
                    {
                        var parser = new DOMParser();
                        var doc = parser.parseFromString(content, 'text/html');
                        var script_tag = doc.querySelector('script');
                        var newScript = document.createElement("script");
                        newScript.innerHTML = script_tag.innerHTML;

                        content = content.substring(content.indexOf("<script"),-1);
                        document.querySelector(element).innerHTML = content;
                        
                        document.querySelector(element).appendChild(newScript);
                    }
                    else
                        if(content.indexOf('{"status":"ERROR"}') > -1)
                            window.location.href = "/"
                        else
                            document.querySelector(element).innerHTML = content;

                    // window.history.pushState({}, null, "/");
                    
                    App.components();
                    callback();
                }
                catch(error)
                {
                    //Close the LoadingOverlay
                    $.LoadingOverlay("hide");

                    console.log('Error:' + error.message);
                    reject(error.message);
                }
                //Close the LoadingOverlay
                $.LoadingOverlay("hide");
                resolve();
            }
        );
    }

    static components()
    {
        // Datepicker
        $('.datepicker-custom').each(function(){
            new Datepicker($(this)[0], {
                autohide: true
            });
        });
        
        // Select2
        $("select").each(function(){
            $(this).select2({
                minimumResultsForSearch: -1,
                width: '100%'
            });
        });
        
        $('b[role="presentation"]').hide();
        $('.select2-selection__arrow').append(`
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16" style="margin-left: -4px; transition: .5s;">
            <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"></path>
        </svg>`
        );
        $(".select2-selection--multiple").append(`
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16" style="margin-right: 8px; margin-top: 10px; float: right; transition: .5s;">
            <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"></path>
        </svg>`
        );

        $('select.simple').each(function(){
            $(this).on('select2:opening', function (e) {
                $(this).next().find('.select2-selection__arrow > svg').toggleClass('rotate');
            });
            $(this).on('select2:closing', function (e) {
                $(this).next().find('.select2-selection__arrow > svg').toggleClass('rotate');
            });
        });

        $('select.multiple').each(function(){
            $(this).on('select2:opening', function (e) {
                $(this).next().find('.select2-selection--multiple > svg').toggleClass('rotate');
            });
            $(this).on('select2:closing', function (e) {
                $(this).next().find('.select2-selection--multiple > svg').toggleClass('rotate');
            });
        });
    }

    static form_data()
    {
        let data = [];
        let inputs = document.querySelector(".grid-form").elements;

        // Iterate over the form controls
        for (let i = 0; i < inputs.length; i++)
        {
            if(inputs[i].nodeName != "FIELDSET" && inputs[i].id != "" && inputs[i].type != "search")
            {
                switch(inputs[i].type)
                {
                    case "select-multiple":
                        let values = $(`#${inputs[i].id}`).val().join(",");
                        data.push({"element":inputs[i].nodeName,"type":inputs[i].type,"id":inputs[i].id,"value":values});
                    break;
                    case "radio":
                    case "checkbox":
                        if(inputs[i].checked)
                            data.push({"element":inputs[i].nodeName,"type":inputs[i].type,"id":inputs[i].id,"value":inputs[i].value});
                    break;
                    default:
                        data.push({"element":inputs[i].nodeName,"type":inputs[i].type,"id":inputs[i].id,"value":inputs[i].value});
                }
            }
        }

        return data;
    }

    static form_data_load(json)
    {
        json.forEach(function(data){
        switch(data.type)
        {
            case "radio":
            case "checkbox":
            $(`#${data.id}`).prop("checked",true);
            break;
            case "select-one":
            $(`#${data.id}`).val(data.value).trigger('change');
            break;
            case "select-multiple":
            $(`#${data.id}`).val(data.value.split(",")).change();
            break;
            default:
            $(`#${data.id}`).val(data.value)
        }
        });
    }

    static toast_message(title="",message="",data="")
    {
        VanillaToasts.create({
            title: title,
            text: message,
            data_id: data
        });
    }

    static show_success(message,callback=function(){})
    {
        swal({
            title: "Success",
            text: message,
            type: "success",
            buttonsStyling: !1,
            confirmButtonClass: "btn btn-success"
        })
        .then((Ok) => {
        if (Ok) 
            {
                callback();
            }
        });
    }

    static show_error(message,callback=function(){})
    {
        swal({
            title: "Warning",
            text: message,
            type: "warning",
            buttonsStyling: !1,
            confirmButtonClass: "btn btn-warning"
        })
        .then((Ok) => {
        if (Ok) 
            {
                callback();
            }
        });
    }

    static show_info(title,message,callback=function(){})
    {
        swal({
            title: title,
            html: message,
            type: "info",
            buttonsStyling: !1,
            confirmButtonClass: "btn btn-primary",
            width: 650
        })
        .then((Ok) => {
            if (Ok) 
            {
                callback();
            }
        });
    }
}