module Model
    module ConnDB
        extend Crecto::Repo

        config do |conf|
            conf.adapter = Crecto::Adapters::SQLite3
            conf.database = ENV_HASH["DATABASE_PATH"].to_s
        end

    end
end