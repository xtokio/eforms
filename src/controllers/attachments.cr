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

        # Add notification
        user  = Model::ConnDB.all(Model::ViewUsers, Query.where(id: user_id))
        eform = Model::ConnDB.all(Model::ViewForms, Query.where(id: form_id))
        assigned_to = eform[0].assigned_to.to_s.split(",")
        assigned_to.each do |for_user|
          if user[0].name.to_s != for_user
            notification = "eForm #{form_id} has a new Attachment by #{user[0].name.to_s}"
            Controller::Notifications.create(notification, form_id.to_i, for_user, user[0].name.to_s)
          end
        end
  
        {status: "OK",id: data_id, message: "Attachment : #{data_id} was created."}.to_json
      end
  
    end
  end