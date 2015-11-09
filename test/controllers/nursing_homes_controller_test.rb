require 'test_helper'

class NursingHomesControllerTest < ActionController::TestCase
  setup do
    @nursing_home = nursing_homes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nursing_homes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nursing_home" do
    assert_difference('NursingHome.count') do
      post :create, nursing_home: { address: @nursing_home.address, contact: @nursing_home.contact, description: @nursing_home.description, name: @nursing_home.name, phone_number: @nursing_home.phone_number, website: @nursing_home.website }
    end

    assert_redirected_to nursing_home_path(assigns(:nursing_home))
  end

  test "should show nursing_home" do
    get :show, id: @nursing_home
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nursing_home
    assert_response :success
  end

  test "should update nursing_home" do
    patch :update, id: @nursing_home, nursing_home: { address: @nursing_home.address, contact: @nursing_home.contact, description: @nursing_home.description, name: @nursing_home.name, phone_number: @nursing_home.phone_number, website: @nursing_home.website }
    assert_redirected_to nursing_home_path(assigns(:nursing_home))
  end

  test "should destroy nursing_home" do
    assert_difference('NursingHome.count', -1) do
      delete :destroy, id: @nursing_home
    end

    assert_redirected_to nursing_homes_path
  end
end
