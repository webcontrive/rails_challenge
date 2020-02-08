require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "GET index" do
    it "return value index" do
      params = {user_id: 1}
      projects = Project.joins(:project_users).where(project_users: {user_id: params[:user_id]}).all
      if params[:sort] == 'name'
        Project.all.order(params[:sort])
      end
    end
  end

  describe "POST create" do
    it "create record" do
      params = {user_id: 1}
      @user = Project.new(name: 'Test', manager_id: 1)
    end
  end
end
