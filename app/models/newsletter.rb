class Newsletter < ActiveRecord::Base
  attr_accessible :name, :autosubscribe

  has_many    :users_newsletters
  has_many    :users, :through => :users_newsletters

end
