module Model
    class Notification < Crecto::Model

        schema "notifications" do # table name
            field :id, Int32, primary_key: true
            field :notification, String
            field :form_id, Int32
            field :for_user, String
            field :by_user, String
            field :viewed, Int32
        end
    
        validate_required [:notification, :form_id, :for_user, :by_user]
    end
end