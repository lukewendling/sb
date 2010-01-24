class AuthorizationsController < ApplicationController
  def new
    oauth = current_friend.oauth
    session['rtoken'] = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
  
  def show
    oauth = current_friend.oauth
    oauth.authorize_from_request(session['rtoken'], session['rsecret'])
    
    session['rtoken'] = nil
    session['rsecret'] = nil
    logger.debug current_friend.to_yaml
    current_friend.update_attributes({
      :atoken => oauth.access_token.token, 
      :asecret => oauth.access_token.secret,
    })
    
    redirect_to challenges_path
  end
end
