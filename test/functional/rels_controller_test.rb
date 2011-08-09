require 'test_helper'

class RelsControllerTest < ActionController::TestCase
  setup do
    @rel = rels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel" do
    assert_difference('Rel.count') do
      post :create, :rel => @rel.attributes
    end

    assert_redirected_to rel_path(assigns(:rel))
  end

  test "should show rel" do
    get :show, :id => @rel.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rel.to_param
    assert_response :success
  end

  test "should update rel" do
    put :update, :id => @rel.to_param, :rel => @rel.attributes
    assert_redirected_to rel_path(assigns(:rel))
  end

  test "should destroy rel" do
    assert_difference('Rel.count', -1) do
      delete :destroy, :id => @rel.to_param
    end

    assert_redirected_to rels_path
  end
end
