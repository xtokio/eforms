get "/status" do |env|
    if Controller::Application.user_logged(env)
        status = Controller::Status.all()
        render "src/views/status/index.ecr"
    else
        env.redirect "/login"
    end
end

get "/status/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        render "src/views/status/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end

post "/status/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Status.create(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end

get "/status/update/:id" do |env|
    if Controller::Application.user_logged(env)
        id = env.params.url["id"]
        status = Controller::Status.get_by_id(id)
        render "src/views/status/update.ecr"
    else
        env.redirect "/login"
    end
end

post "/status/update" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        Controller::Status.update(env)
      else
        {status: "ERROR", message: "Not allowed to use this resource"}.to_json
      end
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end