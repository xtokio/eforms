module Model
    class Forms < Crecto::Model

        schema "forms" do # table name
            field :id, Int32, primary_key: true
            field :form, String
            field :template, String
            field :data, String
            field :assigned_to, String
            field :active, Int32
            field :type_id, Int32
            field :status_id, Int32
            field :user_id, Int32
        end
    
        validate_required [:template, :type_id, :status_id, :user_id]
    end
end