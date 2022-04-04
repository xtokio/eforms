module Controller
  module Notifications
    extend self

    Query = Crecto::Repo::Query

    def all()
      Model::ConnDB.all(Model::Notification)
    end

    def get_by_id(id : String)
      Model::ConnDB.all(Model::Notification, Query.where(id: id))
    end

    def get_by_for_user(for_user : String)
      Model::ConnDB.all(Model::Notification, Query.where(for_user: for_user).where(viewed: 0))
    end

    def create(notification : String, form_id : Int32, for_user : String, by_user : String)
      
      data_record = Model::Notification.new
      data_record.notification  = notification
      data_record.form_id       = form_id
      data_record.for_user      = for_user
      data_record.by_user       = by_user
      data_record.viewed        = 0

      changeset = Model::ConnDB.insert(data_record)

      data_id = changeset.instance.id

      {status: "OK",id: data_id, message: "Notification : #{data_id} was created."}.to_json
    end

    def update(id : Int32, viewed : Int32)

      data_record = Model::ConnDB.get!(Model::Notification, id)
      data_record.viewed      = viewed
      changeset = Model::ConnDB.update(data_record)

      {status: "OK",id: id, message: "Notification : #{id} was updated."}.to_json
    end

  end
end