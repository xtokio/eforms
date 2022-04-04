module Controller
  module Comments
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Comment)
    end

    def get_by_form_id(form_id : String)
        Model::ConnDB.all(Model::ViewComment, Query.where(form_id: form_id).order_by("form_id,id DESC"))
    end

    def create(env)
      comment = env.params.json["comment"].as(String)
      form_id = env.params.json["form_id"].as(String).to_i
      user_id = env.session.string("user_id").to_i

      data_record = Model::Comment.new
      data_record.comment = comment
      data_record.form_id = form_id
      data_record.user_id = user_id
      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      # Add notification
      user  = Model::ConnDB.all(Model::ViewUsers, Query.where(id: user_id))
      eform = Model::ConnDB.all(Model::ViewForms, Query.where(id: form_id))
      assigned_to = eform[0].assigned_to.to_s.split(",")
      assigned_to.each do |for_user|
        if user[0].name.to_s != for_user
          notification = "eForm #{form_id} has a new Comment by #{user[0].name.to_s}"
          Controller::Notifications.create(notification, form_id.to_i, for_user, user[0].name.to_s)
        end
      end

      {status: "OK",id: data_id, message: "Comment : #{data_id} was created."}.to_json
    end

  end
end