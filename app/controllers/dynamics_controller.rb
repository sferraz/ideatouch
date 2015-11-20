class DynamicsController < ApplicationController
  before_action :set_dynamic, only: [:show, :edit, :update, :destroy, :addBoard, :addParticipant, :info, :leave, :activateVotation, :statistics, :votingResults]
  before_action :require_login

  include DynamicsHelper

  # GET /dynamics
  # GET /dynamics.json
  def index
    @dynamics = Dynamic.all
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def info 
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end 

  def edit
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participant = Participant.new
    @participants = Participant.all
  end

  def leave
    Participant.where(email: current_user.email,dynamic_id:@dynamic.id).destroy_all
    Notification.create :user_id => current_user.id , :text => "You left dynamic #{@dynamic.name}", :estado => false
    redirect_to "/dynamics/"
  end

  def statistics
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
    @total_notes = Note.where(dynamic_id:@dynamic.id).size
    @total_boards = Board.where(dynamic_id:@dynamic.id).size - 2
    @total_participants= (Participant.where(dynamic_id:@dynamic.id) & Participant.where.not(avatar_file_name: nil) & Participant.where.not(name: nil)).size
    note_aux
    @char_note = notes
  end

  def votingResults
    @total_participants= (Participant.where(dynamic_id:@dynamic.id) & Participant.where.not(avatar_file_name: nil) & Participant.where.not(name: nil)).size
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
    @partVoted = Vote.where(dynamic_id:@dynamic.id).pluck('Distinct participant_id').size
    
    votes_aux
    @char_vote = votes
  end

  def votes_aux
    @typ =  Note.where(id:Vote.where(dynamic_id:@dynamic.id).map(&:note_id)).map(&:numerodanota)
    @typ_ids = Vote.where(dynamic_id:@dynamic.id).map(&:note_id)
    @number = []
    @typ_ids.each do |t|
      @number << Vote.pluck(:note_id).select { |a| a == t }.size
    end
  end

  def note_aux
    @typ =  (Board.where.not(name: "all notes") & Board.where.not(name:"without board") &  Board.where(dynamic_id:@dynamic.id)).map(&:name)
    @typ_ids = (Board.where.not(name: "all notes") & Board.where.not(name:"without board") &  Board.where(dynamic_id:@dynamic.id)).map(&:id)
    @number = []
    @typ_ids.each do |t|
      @number << Note.pluck(:board_id).select { |a| a == t }.size
    end
  end

  def activateVotation
    d=Dynamic.where(id:@dynamic.id).last
    d.votation=true
    d.save
    Notification.create :user_id => current_user.id , :text => "You activated the votation in dynamic #{@dynamic.name}", :estado => false
    redirect_to "/dynamics/#{@dynamic.id}"
  end 

  # GET /dynamics/1
  # GET /dynamics/1.json
  def show
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def addBoard
    @board= Board.new
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participants = Participant.all
  end

  def addParticipant
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @participant = Participant.new
    @participants = Participant.all
  end

  # GET /dynamics/new
  def new
    @notificationss =  Notification.where(user_id:current_user.id,estado:false).size
    @dynamic = Dynamic.new    
  end

  # GET /dynamics/1/edit

  # POST /dynamics
  # POST /dynamics.json
  def create
    @dynamic = Dynamic.new(dynamic_params)
    respond_to do |format|
      if @dynamic.save
        format.html { redirect_to @dynamic}
        format.json { render :show, status: :created, location: @dynamic }
      else
        format.html { render :new }
        format.json { render json: @dynamic.errors, status: :unprocessable_entity }
      end
    end
      if @dynamic.name==""
        @dynamic.name="undefined"
        @dynamic.save
      end
      if @dynamic.descricao==""
        @dynamic.descricao="undefined"
        @dynamic.save
      end
      if @dynamic.final==nil
        @dynamic.final = DateTime.now + 2.hour
        @dynamic.save
      end
      if @dynamic.votationnumber==nil
        @dynamic.votationnumber = 3
        @dynamic.save
      end
    Board.create :dynamic_id => @dynamic.id , :color=>"boardCinza", :name=> "all notes"
    Board.create :dynamic_id => @dynamic.id , :color=>"boardCinza", :name=> "without board"
    Participant.create :dynamic_id => @dynamic.id , :email=>current_user.email, :vote => false
    Notification.create :user_id => current_user.id , :text => "You created dynamic #{@dynamic.name}", :estado => false
  end

  # PATCH/PUT /dynamics/1
  # PATCH/PUT /dynamics/1.json
  def update
    respond_to do |format|
      if @dynamic.update(dynamic_params)
        format.html { redirect_to @dynamic}
        format.json { render :show, status: :ok, location: @dynamic }
      else
        format.html { render :edit }
        format.json { render json: @dynamic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dynamics/1
  # DELETE /dynamics/1.json
  def destroy
    @dynamic.destroy
    respond_to do |format|
      format.html { redirect_to dynamics_url }
      format.json { head :no_content }
    end
    Notification.create :user_id => current_user.id , :text => "You destroyed dynamic #{@dynamic.name}" , :estado => false
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_dynamic
      @dynamic = Dynamic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dynamic_params
      #params.require(:dynamic).permit(:name, :descricao)
       params.require(:dynamic).permit(:name, :descricao, :user_id,:color,:final,:numerodenotas,:votation,:votationnumber, boards_attributes: [ :name, :descricao ],participants_attributes: [ :email ], notes_attributes: [ :text ])
    end

    def notes
      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'Number of notes per board')
        f.xAxis(categories:(Board.where.not(name: "all notes") & Board.where.not(name:"without board") &  Board.where(dynamic_id:@dynamic.id)).map(&:name))
        f.series(name: 'Boards', yAxis: 0, data: @number)
        f.yAxis [{ allowDecimals: false, title: { text: 'Number of notes', margin: 70 } }]
        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart(defaultSeriesType: 'column')
      end
    end

    def votes
      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'Number of votes per note')
        f.xAxis(categories: (Note.where(id:Vote.where(dynamic_id:199).map(&:note_id)).map(&:numerodanota)))
        f.series(name: 'Notes', yAxis: 0, data: @number)
        f.yAxis [{ allowDecimals: false, title: { text: 'Number of votes', margin: 70 } }]
        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart(defaultSeriesType: 'column')
      end
    end
end
