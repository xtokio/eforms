module Model
    class ViewUsers < Crecto::Model

        schema "view_users" do # table name
            field :id, Int32, primary_key: true
            field :user, String
            field :password, String
            field :name, String
            field :photo, String
            field :active, Int32
            field :role_id, Int32
            field :role, String
            field :description, String
            field :access_id, Int32
            field :department, String
            field :area, String
            field :company, String
        end
        
    end
end