# TODO: Write documentation for `Eforms`
require "kemal"
require "kemal-session"
require "sqlite3"
require "crecto"
require "csv"
require "./routes/*"
require "./models/*"
require "./controllers/*"

# Default values
ENV_HASH = {"PUBLIC_PATH"=>Dir.current + "/public","PORT"=>3000,"DATABASE_PATH"=>Dir.current + "/db/eforms.db"}
# Check .env
File.each_line(".env") do |line|
    key = line.split("=")[0]
    val = line.split("=")[1]
    if key == "PUBLIC_PATH"
      ENV_HASH["PUBLIC_PATH"] = val
    end
    if key == "PORT"
      ENV_HASH["PORT"] = val
    end
    if key == "DATABASE_PATH"
      ENV_HASH["DATABASE_PATH"] = val
    end
end if File.file?(".env")

public_folder ENV_HASH["PUBLIC_PATH"].to_s

module Eforms
    VERSION = "0.1.0"

    # TODO: Put your code here
    Kemal::Session.config.secret = "9e7abe8ae041296820a0b69ef0e4a397c87f5866f454d35d432840bc98cfd789439addc260bb6f9a058e88faa7e4a4e416e39d05273f459dd3373dc6387cf69c"
    
    static_headers do |response, filepath, filestat|
        response.headers.add("Cache-control", "public")
        response.headers.add("Cache-control", "max-age=31557600")
        response.headers.add("Cache-control", "s-max-age=31557600")
        response.headers.add("Content-Size", filestat.size.to_s)
    end

    error 404 do
        error_code = "404"
        error_message = "Page / Resource not found"
        render "src/views/error_page.ecr"
    end

    error 500 do
        error_code = "500"
        error_message = "Server error"
        render "src/views/error_page.ecr"
    end

    messages = [] of String
    sockets  = [] of HTTP::WebSocket

    ws "/message" do |socket|
        sockets.push socket

        # Handle incoming message and dispatch it to all connected clients
        socket.on_message do |message|
            messages.push message
            sockets.each do |a_socket|
                a_socket.send message
            end
        end

        # Handle disconnection and clean sockets
        socket.on_close do |_|
            sockets.delete(socket)
            puts "Closing Socket: #{socket}"
        end
    end

    get "/" do |env|
        if Controller::Application.user_logged(env)
            
            user_name  =  env.session.string("user_name")
            user_photo =  env.session.string("user_photo")
            is_admin   =  env.session.bool("is_admin")
            
            status        = Controller::Status.all()
            forms         = Controller::Types.active()
            notifications = Controller::Notifications.get_by_for_user(user_name)

            # Get total by status for dashboard chart.
            status_total  = Controller::ViewForms.status_total()
            status_labels = "[]"
            status_labels_total = "[]"
            if status_total.size > 0
                labels = ""
                totals = ""
                status_total.each do |total|
                    if labels == ""
                        labels = labels + "'" + total["status"].to_s + "'"
                    else
                        labels = labels + "," + "'" + total["status"].to_s + "'"
                    end

                    if totals == ""
                        totals = totals + total["total"].to_s
                    else
                        totals = totals + "," + total["total"].to_s
                    end
                end
                status_labels = "["+labels+"]"
                status_labels_total = "["+totals+"]"
            end
            
            render "src/views/dashboard/index.ecr", "src/layouts/base.ecr"
        else
            env.redirect "/login"
        end
    end

end
Kemal.run(ENV_HASH["PORT"].to_i)
