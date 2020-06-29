require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'rettiwf_terces_noisses'
  end

  helpers do
    def current_user() User.find_by(id: session[:user_id]) end
    def logged_in?() !!current_user end
<<<<<<< HEAD
    def redirect_if(direct, check) redirect direct if check end
=======
    def redirect_if(direct, check) (redirect direct; return) if check end
>>>>>>> 6426855a8fa63c26f348d540a9a4abeb66d7ec7e
    def login_redirect() redirect_if('/login', !logged_in?) end
  end

  get('/') { erb :index }
  get('/signup') { redirect_if('/tweets', logged_in?); erb :'users/create_user' }
  get('/login') { redirect_if('/tweets', logged_in?); erb :'users/login' }
  get('/logout') { login_redirect; session.destroy; redirect '/login' }

  post '/login' do
    user = User.find_by(username: params[:username])
<<<<<<< HEAD
    (session[:user_id] = user.id; redirect '/tweets') if user && user.authenticate(params[:password])
=======
    (session[:user_id] = user.id; redirect '/tweets/tweets'; return) if user && user.authenticate(params[:password])
>>>>>>> 6426855a8fa63c26f348d540a9a4abeb66d7ec7e
    redirect '/signup'
  end

  post '/signup' do
    [params[:username], params[:email], params[:password]].each { |param| redirect_if('/signup', param.empty?) }
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save; session[:user_id] = @user.id; redirect '/tweets'
  end

end
