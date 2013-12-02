require 'models/session_types'

module SessionTypesController

  def self.included(app)

    app.get '/session_types' do
      @session_types = SessionTypes.all
      @session_type = SessionTypes.new

      erb '/session_types/session_types'.to_sym
    end

    app.post '/session_types' do
      @session_type = SessionTypes.create(params[:session_type])

      flash[:notice] = 'Session Type created successfully'
      redirect '/session_types'
    end

    app.get '/session_types/:id/edit' do
      @session_type = SessionTypes.find_by_id(params[:id])
      @path = "/session_types/#{@session_type.id}/edit"
      erb "/session_types/edit".to_sym
    end

    app.post '/session_types/:id/edit' do
      @session_type = SessionTypes.find_by_id(params[:id])
      @session_type.update_attributes(params[:session_type])

      @errors = @session_type.save!
      flash[:notice] = 'Session Type updated successfully'
      redirect '/session_types'
    end

  end
end      

