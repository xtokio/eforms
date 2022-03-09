module Model
    class ViewForms < Crecto::Model

        schema "view_forms" do # table name
            field :id, Int32, primary_key: true
            field :form, String
            field :template, String
            field :data, String
            field :assigned_to, String
            field :active, Int32
            field :type_id, Int32
            field :type, String
            field :description, String
            field :status_id, Int32
            field :status, String
            field :status_description, String
            field :user_id, Int32
            field :user, String
            field :name, String
        end
        
    end
end