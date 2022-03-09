module Controller
  module Access
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Access)
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::Access, Query.where(id: id))
    end

    def companies()
      Model::ConnDB.all(Model::Access, Query.distinct("company"))
    end

    def areas(company : String)
      Model::ConnDB.all(Model::Access, Query.distinct("area").where(company: company))
    end

    def departments(area : String)
      Model::ConnDB.all(Model::Access, Query.where(area: area))
    end

    def create(env)
      company    = env.params.json["company"].as(String)
      area       = env.params.json["area"].as(String)
      department = env.params.json["department"].as(String)
      
      data_record = Model::Access.new
      data_record.company    = company
      data_record.area       = area
      data_record.department = department
      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      {status: "OK",id: data_id, message: "Access : #{data_id} was created."}.to_json
    end

    def update(env)
        id         = env.params.json["id"].as(String)
        company    = env.params.json["company"].as(String)
        area       = env.params.json["area"].as(String)
        department = env.params.json["department"].as(String)

        data_record = Model::ConnDB.get!(Model::Access, id)
        data_record.company    = company
        data_record.area       = area
        data_record.department = department
        changeset = Model::ConnDB.update(data_record)

        {status: "OK",id: id, message: "Access : #{id} was updated."}.to_json
    end

  end
end