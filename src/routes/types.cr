get "/types" do |env|
    if Controller::Application.user_logged(env)
        types = Controller::Types.all()
        render "src/views/types/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/types/update/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"]
        type = Controller::Types.get_by_id(id)
        render "src/views/types/update.ecr"
    else
        env.redirect "/login"
    end
end

get "/types/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        render "src/views/types/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end

post "/types/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Types.create(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

post "/types/update" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Types.update(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

post "/types/update/activate" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.json["id"].as(String)
        Controller::Types.activate(id)
    else
        {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

post "/types/update/deactivate" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.json["id"].as(String)
        Controller::Types.deactivate(id)
    else
        {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end