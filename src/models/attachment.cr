module Model
    class Attachment < Crecto::Model

        schema "attachments" do # table name
            field :id, Int32, primary_key: true
            field :attachment, String
            field :filename, String
            field :extension, String
            field :user_id, Int32
            field :form_id, Int32
        end
    
        validate_required [:attachment,:user_id,:form_id]
    end
end