get "/access" do |env|
    if Controller::Application.user_logged(env)
        access = Controller::Access.all()
        render "src/views/access/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/access/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        render "src/views/access/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end

post "/access/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Access.create(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

get "/access/update/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"]
        access = Controller::Access.get_by_id(id)
        render "src/views/access/update.ecr"
    else
        env.redirect "/login"
    end
end

post "/access/update" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Access.update(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end