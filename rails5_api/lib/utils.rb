class Utils

  ########## Domain From URL ##########

  def self.get_domain_from_url(url)
    Addressable::URI.parse(url).host
  end

  def self.get_sub_domain_from_url(url)
    domain = self.get_domain_from_url url
    raise "domain not found for url #{url}" unless domain
    PublicSuffix.parse(domain, ignore_private: true).trd
  end

end

