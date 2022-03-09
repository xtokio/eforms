module Controller
  module Types
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Type)
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::Type, Query.where(id: id))
    end

    def active()
      Model::ConnDB.all(Model::Type, Query.where(active: 1))
    end

    def create(env)
      type        = env.params.json["type"].as(String)
      description = env.params.json["description"].as(String)
      template    = env.params.json["template"].as(String)
      addons      = env.params.json["addons"].as(String)
      user_id     = env.session.string("user_id")
            
      data_record = Model::Type.new
      data_record.type        = type
      data_record.description = description
      data_record.template    = template
      data_record.addons      = addons
      data_record.user_id     = user_id.to_i
      data_record.active      = 1
      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      {status: "OK",id: data_id, message: "Type : #{data_id} was created."}.to_json
    end

    def update(env)
      id          = env.params.json["id"].as(Int64)
      type        = env.params.json["type"].as(String)
      description = env.params.json["description"].as(String)
      active      = env.params.json["active"].as(String)
      template    = env.params.json["template"].as(String)
      addons      = env.params.json["addons"].as(String)
      user_id     = env.session.string("user_id")

      data_record = Model::ConnDB.get!(Model::Type, id)
      data_record.type        = type
      data_record.description = description
      data_record.template    = template
      data_record.addons      = addons
      data_record.user_id     = user_id.to_i
      data_record.active      = active.to_i
      changeset = Model::ConnDB.update(data_record)

      {status: "OK",id: id, message: "Type : #{id} was updated."}.to_json
    end

    def activate(id : String)
      data_record = Model::ConnDB.get!(Model::Type, id)
      data_record.active = 1
      changeset = Model::ConnDB.update(data_record)

      {status: "OK",id: id, message: "Type is now Active."}.to_json
    end

    def deactivate(id : String)
      data_record = Model::ConnDB.get!(Model::Type, id)
      data_record.active = 0
      changeset = Model::ConnDB.update(data_record)

      {status: "OK",id: id, message: "Type is now Inactive."}.to_json
    end

  end
end