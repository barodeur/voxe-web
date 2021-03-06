class NewAdmin::CountriesController < AdminController
  before_filter :load_countries, only: [:index]
  load_resource except: [:index]

  def index
    @country ||= Country.new
  end

  def create
    if @country.save
      flash[:notice] = "#{@country} has correctly been created" 
      respond_with :new_admin, @country, location: new_admin_countries_path
    else
      load_countries
      render :index
    end
  end

  def destroy
    @country.destroy
    flash[:notice] = "#{@country} has been destroyed !"
    respond_with :new_admin, @country
  end

  def edit
  end

  def update
    old_name = @country.name
    @country.update_attributes(params[:country])
    flash[:notice] = "#{old_name} has been updated to #{@country}"
    respond_with :new_admin, @country, location: new_admin_countries_path
  end

  protected

  def load_countries
    @countries = Country.all.order_by name: :asc
  end
end
