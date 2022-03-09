get "/roles" do |env|
    if Controller::Application.user_logged(env)
        roles = Controller::Roles.all()
        render "src/views/roles/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/roles/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        render "src/views/roles/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end

post "/roles/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Roles.create(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

get "/roles/update/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"]
        role = Controller::Roles.get_by_id(id)
        render "src/views/roles/update.ecr"
    else
        env.redirect "/login"
    end
end

post "/roles/update" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Roles.update(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end