class Entry < ActiveRecord::Base
  include Tire::Model::Search

  validates_presence_of :uri
end
