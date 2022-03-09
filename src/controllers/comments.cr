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

      {status: "OK",id: data_id, message: "Comment : #{data_id} was created."}.to_json
    end

  end
end