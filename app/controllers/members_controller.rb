class MembersController < ApplicationController
  before_action :set_member, only: [:add_friends, :edit, :update, :destroy, :search]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all.map(&:decorate)
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id]).decorate
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    form = MemberForm.new Member.new, member_params
    @member = form.member

    respond_to do |format|
      if form.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_friends
    add_friends_form = AddFriendsForm.new(@member, member_params[:friends])

    respond_to do |format|
      if add_friends_form.save
        format.html { redirect_to @member, notice: 'Friends were successfully added.'}
      else
        format.html { redirect_to @member, alert: 'Some errors occured.'}
      end
    end
  end

  def search
    respond_to do |format|
      format.json { render json: { result: ArticlesSearch.new(@member, params[:query]).search } }
      format.html { redirect_to @member }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :url, friends: [])
    end
end
