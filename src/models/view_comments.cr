module Model
    class ViewComment < Crecto::Model

        schema "view_comments" do # table name
            field :id, Int32, primary_key: true
            field :comment, String
            field :user_id, Int32
            field :name, String
            field :user, String
            field :form_id, Int32
            field :form, String
        end
    
        validate_required [:comment, :user_id, :form_id]
    end
end