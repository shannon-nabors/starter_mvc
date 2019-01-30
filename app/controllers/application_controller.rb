
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    set :method_override, true
  end

  get '/' do

  end

  get '/flags' do
    @flags = Flag.all
    erb :index
  end

  get '/flags/new' do
    erb :new
  end

  get '/flags/:id' do
    @flag = Flag.find(params[:id])
    erb :show
  end

  post '/flags' do
    flag = Flag.find_or_create_by(params)
    redirect "/flags/#{flag.id}"
  end

  get '/flags/:id/edit' do
    @flag = Flag.find(params[:id])
    erb :edit
  end

  patch '/flags/:id' do
    flag = Flag.find(params[:id])
    flag.update(country: params[:country],
                adoption_date: params[:adoption_date],
                proportion: params[:proportion],
                design: params[:design])
    redirect "/flags/#{flag.id}"
  end

  delete '/flags/:id' do
    Flag.destroy(params[:id])
    redirect "/flags"
  end


end
