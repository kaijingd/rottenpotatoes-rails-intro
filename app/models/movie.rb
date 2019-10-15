class Movie < ActiveRecord::Base
	#def self.all_ratings
	#	['G', 'PG', 'PG-13', 'R']
	#end
	def self.ratings
    	pluck(:rating).uniq
    end

    def self.find_all_by_ratings(ratings)
    	where(rating: ratings)
    end
end
