get "/forms" do |env|
    if Controller::Application.user_logged(env)
        forms = Controller::Forms.get_by_user(env)
        form_status = "All"
        render "src/views/forms/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/form/:id" do |env|
    if Controller::Application.user_logged(env)
        user_name =   env.session.string("user_name")
        user_photo =  env.session.string("user_photo")
        is_admin =    env.session.bool("is_admin")

        forms = Controller::Types.active()

        id = env.params.url["id"]
        users = Controller::Users.all()
        status = Controller::Status.all()
        form = Controller::Forms.get_by_id(id)
        comments = Controller::Comments.get_by_form_id(id)
        attachments = Controller::Attachments.get_by_form_id(id)
        
        render "src/views/forms/show.ecr", "src/layouts/base.ecr"
    else
        env.redirect "/login"
    end
end

post "/forms/new/comment" do |env|
    if Controller::Application.user_logged(env)
      Controller::Comments.create(env)
    else
      {status: "ERROR"}.to_json
    end
end

get "/forms/new/:type" do |env|
    if Controller::Application.user_logged(env)
        type = env.params.url["type"]
        form = Controller::Types.get_by_id(type)
        
        render "src/views/forms/new.ecr"
    else
        env.redirect "/login"
    end
end

post "/forms/new" do |env|
    if Controller::Application.user_logged(env)
      Controller::Forms.create(env)
    else
      {status: "ERROR"}.to_json
    end
end

post "/forms/update" do |env|
    if Controller::Application.user_logged(env)
      Controller::Forms.update_data(env)
    else
      {status: "ERROR"}.to_json
    end
end

post "/forms/update/assigned_to" do |env|
    if Controller::Application.user_logged(env)
      Controller::Forms.update_assigned_to(env)
    else
      {status: "ERROR"}.to_json
    end
end

post "/forms/update/status" do |env|
    if Controller::Application.user_logged(env)
      Controller::Forms.update_status(env)
    else
      {status: "ERROR"}.to_json
    end
end

get "/forms/status/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"].to_i
        forms = Controller::Forms.get_by_status_id(env,id)
        
        form_status = ""
        if forms.size > 0
            form_status = forms[0].status
        end

        render "src/views/forms/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/forms/search/:search" do |env|
    if Controller::Application.user_logged(env)
        search = env.params.url["search"]
        forms = Controller::Forms.get_by_search_id(search)

        form_status = ""
        if forms.size > 0
            form_status = "Search"
        end

        render "src/views/forms/index.ecr"
    else
        env.redirect "/login"
    end
end