module Controller
  module Roles
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Role)
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::Role, Query.where(id: id))
    end

    def create(env)
      role        = env.params.json["role"].as(String)
      description = env.params.json["description"].as(String)
      
      data_record = Model::Role.new
      data_record.role        = role
      data_record.description = description
      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      {status: "OK",id: data_id, message: "Role : #{data_id} was created."}.to_json
    end

    def update(env)
        id         = env.params.json["id"].as(String)
        role        = env.params.json["role"].as(String)
        description = env.params.json["description"].as(String)

        data_record = Model::ConnDB.get!(Model::Role, id)
        data_record.role        = role
        data_record.description = description
        changeset = Model::ConnDB.update(data_record)

        {status: "OK",id: id, message: "Role : #{id} was updated."}.to_json
    end

  end
end