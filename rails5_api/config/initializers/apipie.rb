Apipie.configure do |config|
  config.app_name                = "Rails5Api"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/docs"
  # where is your API defined?
  #config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"

  config.api_controllers_matcher = Dir["#{Rails.root}/app/controllers/**/*.rb"].map do |f|
    if f.include?('concerns')
      nil
    elsif f.include?('.rb')
      f
    else
      "#{f}/*.rb"
    end
  end.compact

end
