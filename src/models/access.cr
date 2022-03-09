module Model
    class Access < Crecto::Model

        schema "access" do # table name
            field :id, Int32, primary_key: true
            field :department, String
            field :area, String
            field :company, String
        end
    
        validate_required [:department, :area, :company]
    end
end