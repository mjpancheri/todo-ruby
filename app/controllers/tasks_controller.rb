class TasksController < ApplicationController
  include Exportable
  
  before_action :set_task, only: %i[ edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.only_parents.order(due_date: :desc, description: :asc)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "A tarefa foi criada com sucesso." 
    else
        flash.now[:alert] = @task.errors.full_messages.to_sentence 
        render :new
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "A tarefa foi atualizada com sucesso." 
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence 
      render :edit, status: :unprocessable_entity 
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "A tarefa foi removida com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:description, :due_date, :done, :parent_id)
    end
end
