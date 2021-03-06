class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
    #al objeto de pins, que se guarden solo los pins del usuario actual.
    @pins = current_user.pins 
    
    #@pins = Pin.where(user_id:current_user.id)
    
    @pinsDestacados = Pin.where(destacado: 'si').first(2)
 
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @pins = Pin.all
  end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
     
  end

  # POST /pins
  # POST /pins.json
  def create
    #creame un pin vacio con los valores que vienne desde el formulario.
    @pin = Pin.new(pin_params)
 
    
    #de la tabla Pin al campo "user_id" que se almacene el idusuario de usuario actual.
     @pin.user_id = current_user.id 

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin de Youtube fue  creado.' }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Pin de Youtube fue modificado.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: 'Pin de Youtube fue borrado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:title, :photo, :description, :destacado, :email, :user_id)
    end
end
