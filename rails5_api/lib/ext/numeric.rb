# add require in 'config/initializers/init_extension.rb'

########## Add to Integer method ##########
class Numeric
  def to_date
    raise 'date must > 0 for #{self}' if self < 0
    return Time.at(self).to_date
  end

  def to_datetime
    raise 'date must > 0 for #{self}' if self < 0
    return Time.at(self).to_datetime
  end
end
