require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "GET index" do
    it "return value index" do
      params = {user_id: 1, sort: 'name'}
      sort = params[:sort] if params[:sort] == 'name'
      projects = Project.left_outer_joins(:project_users).where("projects.manager_id = :userid or project_users.user_id = :userid", userid: params[:user_id]).order(sort).uniq
    end
  end

  describe "POST create" do

    before(:each) do
      params = {user_id: 1}
      @user = User.find_by(id: params[:user_id])
      if @user.blank?
        puts "User are invalid"
      end
    end

    context 'when user does not exist' do
      context 'with invalid params' do
        it 'invalid project name' do
          unless @user.blank?
            invalid_params_name = ''
            project = Project.new(name: invalid_params_name, manager_id: @user.id)
            unless project.save
              puts project.errors.full_messages
            end
          end
        end
      end

      context 'with valid params' do
        let(:valid_params) do
          {
            project: {name: 'Test'}
          }
        end
        it 'responds with success' do
          unless @user.blank?
            project = Project.new(name: valid_params[:project][:name], manager_id: @user.id)
            if project.save
              puts 'Record successfully save'
            else
              puts project.errors.full_messages
            end
          end
        end
      end
    end
  end
end
