module Controller
    module ViewForms
        extend self

        Query = Crecto::Repo::Query

        def all()
            Model::ConnDB.all(Model::ViewForms)
        end

    end
end