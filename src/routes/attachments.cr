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

post "/upload/import/csv/:id" do |env|
  type_id = env.params.url["id"]
  upload_folder = "#{ENV_HASH["PUBLIC_PATH"].to_s}/assets/forms/uploads/import/"

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
      
      CSV.each_row(File.read(file_path)) do |row|
        form        = row[0]
        data        = "[]"
        type_id     = type_id.to_i
        template    = Controller::Types.get_by_id(type_id.to_s)[0].template
        user_id     = env.session.string("user_id").to_i
        assigned_to = env.session.string("user_name")
        status_id   = 1
        active      = 1
        
        data_record = Model::Forms.new
        data_record.form        = form
        data_record.template    = template
        data_record.type_id     = type_id
        data_record.status_id   = status_id
        data_record.user_id     = user_id
        data_record.data        = data
        data_record.assigned_to = assigned_to
        data_record.active      = active
        changeset = Model::ConnDB.insert(data_record)
        data_id = changeset.instance.id

        puts "eForm : #{data_id} was created."
      end
      # file_path

    end
  end
  {status: "OK", filename: filename}.to_json
end