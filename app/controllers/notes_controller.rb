class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to "/boards/#{@note.board_id}" }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
    @dynamic = Dynamic.where(id:@note.dynamic_id).last
    @dynamic.numerodenotas = @dynamic.numerodenotas + 1 
    @dynamic.save
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to "/dynamics/#{@note.dynamic_id}" }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    @i = Note.last
    Note.destroy(params[:notes])
      respond_to do |format|
        format.html { redirect_to (:back) }
        format.json { head :no_content }
      end
  end

  def update_multiple
    if (params.has_key?(:note))
      @board = params[:note][:board_id]
      @notes = Note.find(params[:notes])
      @notes.reject! do |note|
        note.update_attributes(:board_id => @board )
      end
      redirect_to "/dynamics/#{Board.where(id:@board).last.dynamic_id}"
    else
      redirect_to (:back)
    end
  end


  def vote_multiple
    @notes = Note.find(params[:notes])
    @notes.reject! do |note|
      Vote.create :participant_id => Participant.where(email:current_user.email,dynamic_id:note.dynamic_id).last.id , :dynamic_id => note.dynamic_id, :note_id => note.id
      @p= Participant.where(email:current_user.email,dynamic_id:note.dynamic_id).last
    end
    @p.vote= true
    @p.save
    Notification.create :user_id => current_user.id , :text => "You voted on dynamic #{Dynamic.where(id:@p.dynamic_id).last.name}", :estado => false
    redirect_to (:back)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:board_id, :text,:color,:email,:dynamic_id,:numerodanota)
    end
end
