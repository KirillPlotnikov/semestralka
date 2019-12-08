class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    # @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}
    if params[:group] == '1'
      @tasks = current_user.tasks.includes(:category).joins(:category).group_by{|t| t.category}
    else
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    end
    console
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def completed
    @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).completed.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    render 'index'
  end

  def pending
    @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).pending.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:deadline_at, :title, :note, :is_done, :category_id, :tag_ids => [])
    end
end
