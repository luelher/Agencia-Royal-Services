require 'test_helper'

class ParroquiaControllerTest < ActionController::TestCase
  setup do
    @parroquia = parroquia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parroquia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parroquia" do
    assert_difference('Parroquia.count') do
      post :create, parroquia: { descripcion: @parroquia.descripcion, municipio_id: @parroquia.municipio_id }
    end

    assert_redirected_to parroquia_path(assigns(:parroquia))
  end

  test "should show parroquia" do
    get :show, id: @parroquia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parroquia
    assert_response :success
  end

  test "should update parroquia" do
    put :update, id: @parroquia, parroquia: { descripcion: @parroquia.descripcion, municipio_id: @parroquia.municipio_id }
    assert_redirected_to parroquia_path(assigns(:parroquia))
  end

  test "should destroy parroquia" do
    assert_difference('Parroquia.count', -1) do
      delete :destroy, id: @parroquia
    end

    assert_redirected_to parroquia_path
  end
end
