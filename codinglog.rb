require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('models/language')
require_relative('models/timer')

get '/' do
  @timer = Timer.all().first
  erb(:index)
end

post '/start_timer/' do
  Timer.start_timer()
  redirect '/'
end

get '/stop_timer/' do
  @stop_time = Timer.stop_timer()
  @elapsed_time = Timer.elapsed_time()
  @languages = Language.all()
  erb(:stop_timer)
end

post '/stop_timer/' do
  time = Language.get_time(params['id'].to_i)
  time = time.values.first.to_f
  new_time = time + (Timer.elapsed_time().to_f)
  Language.update_time(new_time, params['id'].to_i)
  redirect to '/'
end

post '/manual_input/' do
  new_time_seconds = params['time'].to_f

  new_time_minutes = new_time_seconds * 60
  new_time = Language.get_time(params['id']).values.first.to_f + new_time_minutes.to_f
  language = Language.new(params)
  Language.update_time(new_time, params['id'].to_i)
  redirect back
end

post '/show_times/' do
  @languages = Language.all()
  erb(:show_times)
end

get '/manual_input/' do
  @languages = Language.all()
  erb(:manual_input)
end

get '/add_new_language/' do
  erb(:add_new_language)
end

post '/add_new_language/' do
  language = Language.new(params)
  language.save()
  redirect to '/'
end

get '/delete_language/' do
  @languages = Language.all()
  erb(:delete_language)
end

post '/delete_language/' do
  Language.delete_by_id(params['id'])
  erb(:delete_conformation)
end
