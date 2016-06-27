class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    # receving from EDIT 
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do 
    # receiving from figures/new
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end
    @figure.save
    params[:figure].to_s
    #redirect "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

end