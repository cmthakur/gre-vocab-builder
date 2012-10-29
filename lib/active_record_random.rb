class ActiveRecord::Relation
  def random
    self.first(:order => "RANDOM()")
  end  
end  
