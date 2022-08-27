module Model
    class Type < Crecto::Model

        schema "types" do # table name
            field :id, Int32, primary_key: true
            field :type, String
            field :description, String
            field :template, String
            field :active, Int32
            field :user_id, Int32
        end
    
        validate_required [:type, :template, :user_id]
    end
end