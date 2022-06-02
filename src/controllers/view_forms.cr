module Controller
    module ViewForms
        extend self

        Query = Crecto::Repo::Query

        def all()
            Model::ConnDB.all(Model::ViewForms)
        end

        def status_total()
            status = [] of Hash(String, String | Int64 | Float64 | Slice(UInt8) | Nil)
            records = Model::ConnDB.all(Model::ViewForms, Query.distinct("status").order_by("status_id"))
            if records.size > 0
                records.each do |record|
                    query = Query.where(status: record.status.to_s)
                    total = Model::ConnDB.aggregate(Model::ViewForms, :count, :status_id, query)

                    status.push({"status" => record.status.to_s, "total" => total})
                end
            end
            status            
        end

    end
end