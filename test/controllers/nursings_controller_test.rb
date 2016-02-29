require 'test_helper'

class NursingsControllerTest < ActionController::TestCase
  setup do
    @nursing = nursings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nursings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nursing" do
    assert_difference('Nursing.count') do
      post :create, nursing: { nurse_id: @nursing.nurse_id, resident_id: @nursing.resident_id }
    end

    assert_redirected_to nursing_path(assigns(:nursing))
  end

  test "should show nursing" do
    get :show, id: @nursing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nursing
    assert_response :success
  end

  test "should update nursing" do
    patch :update, id: @nursing, nursing: { nurse_id: @nursing.nurse_id, resident_id: @nursing.resident_id }
    assert_redirected_to nursing_path(assigns(:nursing))
  end

  test "should destroy nursing" do
    assert_difference('Nursing.count', -1) do
      delete :destroy, id: @nursing
    end

    assert_redirected_to nursings_path
  end
end
