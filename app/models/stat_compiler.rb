class StatCompiler
  attr_reader :stats

  def initialize(user)
    @stats = Song.all_viewer_counts(user)
  end

  def all_titles
    stats.map { |song| song[:title] }
  end

  def all_views
    stats.map { |song| song[:views] }
  end

  def all_likes
    stats.map { |song| song[:likes] }
  end

  def all_dislikes
    stats.map { |song| song[:dislikes] }
  end

  def all_favorites
    stats.map { |song| song[:favorites] }
  end


  def all_likeratios
    stats.map do |stat|
      (stat[:likes].to_f/(stat[:likes].to_f+stat[:dislikes].to_f))
    end
  end

  def avg_views
    if stats.length > 0
      (all_views.reduce(:+))/stats.length
    end
  end

  def avg_likeratio
    if stats.length > 0
      (all_likeratios.reduce(:+))/stats.length
    end
  end
end