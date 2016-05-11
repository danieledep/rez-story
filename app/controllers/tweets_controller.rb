class TweetsController < ApplicationController
  def new
  end

  def create
    message = "#{twitter_params[:youtube_url]} #{twitter_params[:message]} #NowPlaying"

    options = {}
    if twitter_params[:lat].present? && twitter_params[:lng].present?
      options[:lat] = twitter_params[:lat]
      options[:long] = twitter_params[:lng]
    end

    current_user.tweet(message, options)

    redirect_to prototype_path
  end



  def twitter_params
    params.require(:tweet).permit(:message, :lat, :lng)
  end

  def search
  	@tweets = twitter_client.search(
  		"from:rez_story #réz_story",
		geocode: "#{params[:lat]},#{params[:lng]},5km"
		
  		
  	)
  	render layout: false
	
  end


  private

  def twitter_client
  	# TODO: memoize?
  	Twitter::REST::Client.new do |config|
  		# TODO: put in ENV variables
  		config.consumer_key = 'EJecKKXF7dhC9zEUxLqaGW3Ul'
  		config.consumer_secret = 'XUacO6oFB5LdAIlc0f4NOeDiyAYlo5Sp0tPbLmWyCPTvb9V0pq'
  	end
  end
end
