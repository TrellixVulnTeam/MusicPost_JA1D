class SoundsController < ApplicationController
    before_action :set_sound, only: [:show, :edit, :update, :destroy]
    require 'kconv'
    require 'mimemagic'

    def index
        @sounds = Sound.all
    end

    def index_recommend
    end

    def show
    end

    def show_melody
    end

    def new
        @sound = Sound.new
    end

    # GET /sounds/1/edit
    def edit
    end

    # POST /sounds
    # POST /sounds.json
    def create
        @sound = Sound.new(sound_params)
        file = params[:sound][:upfile]
        perms = ['.mp3', '.ogg', '.wav']
        unless @sound.valid?     
            render :new
        else
           @user.set_sound(file)
            if @sound.save then
            redirect_to @sound, notice: "#{file_name.toutf8}をアップロードしました。"
            #↑redirect_to sound_path(@sound.id)→redirect_to sound_path(@sound.id)→redirect_to @sound
            #↑sound_path(@sound.id)でshowアクションに飛ぶ
            else
                render :new
            end
        end
    end

    # PATCH/PUT /sounds/1
    # PATCH/PUT /sounds/1.json
    def update
        respond_to do |format|
            if @sound.update(sound_params)
                format.html { redirect_to @sound, notice: 'Sound was successfully updated.' }
                format.json { render :show, status: :ok, location: @sound }
            else
                format.html { render :edit }
                format.json { render json: @sound.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /sounds/1
    # DELETE /sounds/1.json
    def destroy
        @sound.destroy
        respond_to do |format|
            format.html { redirect_to sounds_url, notice: 'Sound was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_sound
            @sound = Sound.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def sound_params
            params.require(:sound).permit(:title, :content)
        end
end
