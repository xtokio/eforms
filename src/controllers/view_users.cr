module Controller
    module ViewUsers
        extend self

        Query = Crecto::Repo::Query

        def all()
            Model::ConnDB.all(Model::ViewUsers)
        end

    end
end