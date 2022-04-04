module Controller
  module Forms
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::ViewForms)
    end

    def get_by_user(env)
      forms = nil
      is_admin = env.session.bool("is_admin")
      if is_admin
        forms = Model::ConnDB.all(Model::ViewForms)
      else
        forms = Model::ConnDB.all(Model::ViewForms, Query.where("assigned_to like '%#{env.session.string("user_name")}%'"))
      end
      forms
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::ViewForms, Query.where(id: id))
    end

    def get_by_status_id(env,status_id : Int32)
      forms = nil
      is_admin = env.session.bool("is_admin")
      if is_admin
        forms = Model::ConnDB.all(Model::ViewForms, Query.where(status_id: status_id))
      else
        forms = Model::ConnDB.all(Model::ViewForms, Query.where("assigned_to like '%#{env.session.string("user_name")}%'").where(status_id: status_id))
      end
      forms
    end

    def get_by_search_id(search : String)
        Model::ConnDB.all(Model::ViewForms, Query.where(id: search).or_where(form: search))
    end

    def create(env)
      form        = env.params.json["form_number"].as(String)
      data        = env.params.json["form_data"].as(String)
      type_id     = env.params.json["type_id"].as(String).to_i
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

      {status: "OK",id: data_id, message: "eForm : #{data_id} was created."}.to_json
    end

    def update_data(env)
      id          = env.params.json["id"].as(String)
      form        = env.params.json["form_number"].as(String)
      data        = env.params.json["form_data"].as(String)
      
      data_record = Model::ConnDB.get!(Model::Forms, id)
      data_record.form        = form
      data_record.data        = data
      changeset = Model::ConnDB.update(data_record)

      # Add notification
      eform = Model::ConnDB.all(Model::ViewForms, Query.where(id: id))
      assigned_to = eform[0].assigned_to.to_s.split(",")
      assigned_to.each do |for_user|
        if env.session.string("user_name") != for_user
          notification = "eForm #{id} was updated by #{env.session.string("user_name")}"
          Controller::Notifications.create(notification, id.to_i, for_user, env.session.string("user_name"))
        end
      end

      {status: "OK",id: id, message: "eForm : #{id} was updated."}.to_json
    end

    def update_assigned_to(env)
        id          = env.params.json["id"].as(String)
        assigned_to = env.params.json["assigned_to"].as(String)
        
        data_record = Model::ConnDB.get!(Model::Forms, id)
        data_record.assigned_to = assigned_to
        changeset = Model::ConnDB.update(data_record)

        # Add notification
        assigned_to.to_s.split(",").each do |for_user|
          if env.session.string("user_name") != for_user
            notification = "eForm #{id} new Assigned to user was added by #{env.session.string("user_name")}"
            Controller::Notifications.create(notification, id.to_i, for_user, env.session.string("user_name"))
          end
        end
  
        {status: "OK",id: id, message: "eForm : #{id} was updated."}.to_json
    end

    def update_status(env)
      id        = env.params.json["id"].as(String)
      status_id = env.params.json["status_id"].as(String)
      
      data_record = Model::ConnDB.get!(Model::Forms, id)
      data_record.status_id = status_id.to_i
      changeset = Model::ConnDB.update(data_record)

      # Add notification
      status = Model::ConnDB.all(Model::Status, Query.where(id: status_id))
      eform  = Model::ConnDB.all(Model::ViewForms, Query.where(id: id))
      assigned_to = eform[0].assigned_to.to_s.split(",")
      assigned_to.each do |for_user|
        if env.session.string("user_name") != for_user
          notification = "eForm #{id} Status changed to #{status[0].description} by #{env.session.string("user_name")}"
          Controller::Notifications.create(notification, id.to_i, for_user, env.session.string("user_name"))
        end
      end

      {status: "OK",id: id, message: "eForm : #{id} was updated."}.to_json
    end

  end
end