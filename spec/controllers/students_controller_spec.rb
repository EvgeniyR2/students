# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsController do
  render_views

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    sign_in user1
    create_list(:student, 3, user: user1)
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'add student' do
      post :create, params: { student: { first_name: 'Any first_name',
                                         last_name: 'Any last_name',
                                         gender: 'male' } }

      expect(Student.where(user_id: user1.id).count).to be(4)
    end
  end

  describe 'GET edit' do
    it 'has a 200 status code' do
      get :edit, params: { id: Student.first.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT update' do
    it 'updates student' do
      student = Student.first
      put :update, params: { student: { first_name: 'New Name' }, id: student.id }
      expect(student.reload.first_name).to eq('New Name')
    end
  end

  describe 'DELETE destroy' do
    it 'deletes student' do
      student = Student.first
      delete :destroy, params: { id: student.id }

      expect(Student.count).to eq(2)
    end
  end
end
