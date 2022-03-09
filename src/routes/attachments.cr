post "/upload/attachment/form/:id" do |env|
    upload_folder = "#{ENV_HASH["PUBLIC_PATH"].to_s}/assets/forms/uploads/"

    form_id = env.params.url["id"].to_i
    user_id = env.session.string("user_id").to_i
    
    filename = ""
    HTTP::FormData.parse(env.request) do |upload|
      filename = upload.filename
    # Be sure to check if file.filename is not empty otherwise it'll raise a compile time error
      if !filename.is_a?(String)
        p "No filename included in upload"
      else
        ext = filename.split(".").pop()
        attachment = Random::Secure.hex(8) + "." + ext
        file_path = ::File.join [upload_folder, attachment]
        File.open(file_path, "w") do |f|
          IO.copy(upload.body, f)
        end
        
        Controller::Attachments.create(attachment,filename,ext,user_id,form_id)

      end
    end
    {status: "OK", filename: filename}.to_json
end