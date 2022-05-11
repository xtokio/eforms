get "/import/new" do |env|
    if Controller::Application.user_logged(env)
      is_admin = env.session.bool("is_admin")
      if is_admin
        forms = Controller::Types.active()
        render "src/views/import/new.ecr"
      else
        env.redirect "/"
      end
    else
      env.redirect "/login"
    end
end