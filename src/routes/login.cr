# Login
get "/login" do |env|
  render "src/layouts/login.ecr"
end

post "/login" do |env|
  env.response.content_type = "application/json"

  Controller::Users.login(env)
  if Controller::Application.user_logged(env)
    {status: "OK"}.to_json
  else
    {status: "ERROR"}.to_json
  end
end

get "/logout" do |env|
  env.session.destroy
  env.redirect "/login"
end