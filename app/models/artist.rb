class Artist < ActiveRecord::Base
    #Artist::Slugifiable
    has_many :songs
    has_many :genres, :through => :songs
    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods
  end