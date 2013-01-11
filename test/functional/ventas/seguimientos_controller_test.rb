require 'test_helper'

class Ventas::SeguimientosControllerTest < ActionController::TestCase
  setup do
    @ventas_seguimiento = ventas_seguimientos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_seguimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_seguimiento" do
    assert_difference('Ventas::Seguimiento.count') do
      post :create, ventas_seguimiento: {  }
    end

    assert_redirected_to ventas_seguimiento_path(assigns(:ventas_seguimiento))
  end

  test "should show ventas_seguimiento" do
    get :show, id: @ventas_seguimiento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_seguimiento
    assert_response :success
  end

  test "should update ventas_seguimiento" do
    put :update, id: @ventas_seguimiento, ventas_seguimiento: {  }
    assert_redirected_to ventas_seguimiento_path(assigns(:ventas_seguimiento))
  end

  test "should destroy ventas_seguimiento" do
    assert_difference('Ventas::Seguimiento.count', -1) do
      delete :destroy, id: @ventas_seguimiento
    end

    assert_redirected_to ventas_seguimientos_path
  end
end
