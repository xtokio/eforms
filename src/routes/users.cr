get "/users" do |env|
    if Controller::Application.user_logged(env)
        users = Controller::ViewUsers.all()
        render "src/views/users/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/users/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        roles  = Controller::Roles.all()
        access = Controller::Access.all()
        render "src/views/users/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end

post "/users/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Users.create(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

get "/users/update/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"]
        user = Controller::Users.get_by_id(id)
        roles  = Controller::Roles.all()
        access = Controller::Access.all()
        render "src/views/users/update.ecr"
    else
        env.redirect "/login"
    end
end

post "/users/update" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Users.update(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end