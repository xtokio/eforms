module Controller
  module Status
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Status)
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::Status, Query.where(id: id))
    end

    def create(env)
      status      = env.params.json["status"].as(String)
      description = env.params.json["description"].as(String)
      
      data_record = Model::Status.new
      data_record.status      = status
      data_record.description = description
      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      {status: "OK",id: data_id, message: "Status : #{data_id} was created."}.to_json
    end

    def update(env)
        id          = env.params.json["id"].as(String)
        status      = env.params.json["status"].as(String)
        description = env.params.json["description"].as(String)

        data_record = Model::ConnDB.get!(Model::Status, id)
        data_record.status      = status
        data_record.description = description
        changeset = Model::ConnDB.update(data_record)

        {status: "OK",id: id, message: "Status : #{id} was updated."}.to_json
    end

  end
end