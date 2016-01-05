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
    params.require(:tweet).permit(:message, :youtube_url, :lat, :lng)
  end

  def search
  	@tweets = twitter_client.search(
  		'#nowplaying',
  		geocode: "#{params[:lat]},#{params[:lng]},500mi"
  	)
  	render layout: false
  end

  private

  def twitter_client
  	# TODO: memoize?
  	Twitter::REST::Client.new do |config|
  		# TODO: put in ENV variables
  		config.consumer_key = 'CXVNsTDohsJaIxl0cjpuLKXYr'
  		config.consumer_secret = 'Y49dNi2NPN9vJaPS95QnRLslOqisEuC7v934lHOfN05cVjbtDB'
  	end
  end
end
