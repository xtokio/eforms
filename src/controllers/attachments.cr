module Controller
    module Attachments
      extend self
  
      Query = Crecto::Repo::Query
  
      def all()
        Model::ConnDB.all(Model::Attachment)
      end
  
      def get_by_id(id : String)
        Model::ConnDB.all(Model::Attachment, Query.where(id: id))
      end

      def get_by_form_id(form_id : String)
        Model::ConnDB.all(Model::Attachment, Query.where(form_id: form_id))
      end
  
      def create(attachment : String, filename : String, extension : String, user_id : Int32, form_id : Int32)
        
        data_record = Model::Attachment.new
        data_record.attachment = attachment
        data_record.filename   = filename
        data_record.extension  = extension
        data_record.user_id    = user_id
        data_record.form_id    = form_id
        changeset = Model::ConnDB.insert(data_record)
  
        data_id = changeset.instance.id
  
        {status: "OK",id: data_id, message: "Attachment : #{data_id} was created."}.to_json
      end
  
    end
  end