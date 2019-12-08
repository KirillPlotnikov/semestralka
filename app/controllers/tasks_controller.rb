class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_categories_and_tags, only: [:index, :completed, :pending, :by_category, :by_tags]

  # GET /tasks
  # GET /tasks.json
  def index
    # @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}
    if params[:group] == '1'
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:category).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
    else
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    end
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
    if params[:group] == '1'
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).completed.joins(:category).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
    else
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).completed.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    end
    render 'index'

  end

  def pending
    if params[:group] == '1'
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).pending.joins(:category).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
    else
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).pending.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    end
    render 'index'
  end

  def by_category
    if params[:group] == '1'
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:category).where(category: params[:category]).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
    else
      @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).where(category: params[:category]).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
    end
    render 'index'
    console
  end

  def by_tags
    if params[:category] == nil
      tags_ids = params[:tags_ids].split("+")
      if params[:group] == '1'
        @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:category, :tag_associations).where(tag_associations: {tag_id: tags_ids}).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
      else
        @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:tag_associations).where(tag_associations: {tag_id: tags_ids}).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
      end
    else
      category = params[:category]
      tags_ids = params[:tags_ids].split("+")
      if params[:group] == '1'
        @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:category, :tag_associations).where(category: category).where(tag_associations: {tag_id: tags_ids}).group_by{|t| t.category.title}.map{|k,v| [k, v.sort_by {|task| task.deadline_at != nil ? [task.deadline_at, task.created_at] : [100.years.after, task.created_at]}]}.to_h
      else
        @tasks = current_user.tasks.includes(:category, :tag_associations, :tags).joins(:tag_associations).where(category: category).where(tag_associations: {tag_id: tags_ids}).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END, deadline_at')
      end

    end
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

  def set_categories_and_tags
    @categories = current_user.categories
    @tags = current_user.tags
  end
end
