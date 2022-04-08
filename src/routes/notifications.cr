post "/notification/viewed" do |env|
    if Controller::Application.user_logged(env)
      id = env.params.json["id"].as(String).to_i
      Controller::Notifications.update(id, 1)
    else
      {status: "ERROR", message: "Session expired, need to log in"}.to_json
    end
end