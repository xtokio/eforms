module Model
    class Comment < Crecto::Model

        schema "comments" do # table name
            field :id, Int32, primary_key: true
            field :comment, String
            field :user_id, Int32
            field :form_id, Int32
        end
    
        validate_required [:comment, :user_id, :form_id]
    end
end