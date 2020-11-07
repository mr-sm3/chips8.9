class Movie < ActiveRecord::Base
  def self.show_director(dir)
    Movie.where(director: dir)
  end
end
