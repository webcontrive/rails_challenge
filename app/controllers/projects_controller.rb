class ProjectsController < ApplicationController
  ## Callbacks
  skip_before_action :verify_authenticity_token
  before_action :set_user

  ## Listing of projects
  def index
    status, projects = 204, []
    unless @user.blank?
      sort = params[:sort].blank? ? "created_at desc" : params[:sort]
      projects = Project.left_outer_joins(:project_users).where("projects.manager_id = :userid or project_users.user_id = :userid", userid: @user.id).order(sort).uniq
      status = 200
    end
    render json: {status: status, data: projects}
  end

  ## Assign project to user
  def add
    status, message = 406, 'please enter valide data.'
    unless @user.blank? && params[:id].blank?
      project = Project.find_by(id: params[:id])
      unless project.blank?
        project_user = project.project_users.new(user_id: @user.id)
        if project_user.save
          status, message = 201, 'Project successes fully assign.'
        end
      end
      Rails.logger.info message
    end
    render json: {status: status, message: message}
  end

  ## Create project
  def create
    status, message, data = 406, 'please enter valide data.', ''
    unless @user.blank?
      project = Project.new(project_params)
      project.manager_id = @user.id
      if project.save
        status, message, data = 201, 'Project successes fully created.', project
      else
        status, message = 406, project.errors.full_messages
      end
      Rails.logger.info message
    end
    render json: {status: status, message: message, data: data}
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
      Rails.logger.info "User #{params[:user_id]} not found." if @user.blank?
    end
end
