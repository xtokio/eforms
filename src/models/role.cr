module Model
    class Role < Crecto::Model

        schema "roles" do # table name
            field :id, Int32, primary_key: true
            field :role, String
            field :description, String
        end
    
        validate_required [:role]
    end
end