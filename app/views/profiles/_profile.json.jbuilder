json.extract! profile, :id, :active, :firstName, :lastName, :website, :location, :typeOfWork, :fatCategory, :orientation, :religion, :ethnicity, :created_at, :updated_at
json.url profile_url(profile, format: :json)
