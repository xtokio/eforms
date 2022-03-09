module Model
    class User < Crecto::Model

        schema "users" do # table name
            field :id, Int32, primary_key: true
            field :user, String
            field :password, String
            field :name, String
            field :photo, String
            field :active, Int32
            field :role_id, Int32
            field :access_id, Int32
        end
    
        validate_required [:user, :password, :name, :role_id, :access_id]
    end
end