class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy, :addNote,:moveNotes,:moveNotes,:votation]
  before_action :require_login

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def addNote
    @dynamics = Dynamic.all
    @note= Note.new
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def votation
    @lim = Dynamic.where(id:@board.dynamic_id).last.votationnumber
    @dynamics = Dynamic.all
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def moveNotes
    @dynamics = Dynamic.all
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  # GET /boards/new
  def new
    @board = Board.new
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
  end

  # GET /boards/1/edit
  def edit
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.name!="all notes" and @board.name!="without board" and @board.save 
        format.html { redirect_to "/dynamics/#{@board.dynamic_id}"}
        format.json { render :show, status: :created, location: @board }
      else
        format.html { redirect_to "/dynamics/#{@board.dynamic_id}" }
        format.json { render :show, status: :created, location: @board }
      end
    end
      if @board.name==""
        @board.name="undefined"
        @board.save
      end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board}
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to "/dynamics/#{@board.dynamic_id}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :descricao, :dynamic_id,:color,notes_attributes: [ :text ])
    end
end
