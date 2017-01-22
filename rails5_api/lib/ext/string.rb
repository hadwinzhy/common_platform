# add require in 'config/initializers/init_extension.rb'

########## Add to String method ##########
class String
  def to_class
    self.camelize.constantize
  end

  def to_class_safely
    self.camelize.safe_constantize
  end
end
