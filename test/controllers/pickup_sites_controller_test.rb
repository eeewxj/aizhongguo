require 'test_helper'

class PickupSitesControllerTest < ActionController::TestCase
  setup do
    @pickup_site = pickup_sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pickup_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pickup_site" do
    assert_difference('PickupSite.count') do
      post :create, pickup_site: { liaison: @pickup_site.liaison, meeting_time: @pickup_site.meeting_time, name: @pickup_site.name, phone_number: @pickup_site.phone_number, project_id: @pickup_site.project_id }
    end

    assert_redirected_to pickup_site_path(assigns(:pickup_site))
  end

  test "should show pickup_site" do
    get :show, id: @pickup_site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pickup_site
    assert_response :success
  end

  test "should update pickup_site" do
    patch :update, id: @pickup_site, pickup_site: { liaison: @pickup_site.liaison, meeting_time: @pickup_site.meeting_time, name: @pickup_site.name, phone_number: @pickup_site.phone_number, project_id: @pickup_site.project_id }
    assert_redirected_to pickup_site_path(assigns(:pickup_site))
  end

  test "should destroy pickup_site" do
    assert_difference('PickupSite.count', -1) do
      delete :destroy, id: @pickup_site
    end

    assert_redirected_to pickup_sites_path
  end
end
