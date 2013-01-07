require 'test_helper'

class Ventas::PresupuestosControllerTest < ActionController::TestCase
  setup do
    @ventas_presupuesto = ventas_presupuestos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_presupuestos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_presupuesto" do
    assert_difference('Ventas::Presupuesto.count') do
      post :create, ventas_presupuesto: {  }
    end

    assert_redirected_to ventas_presupuesto_path(assigns(:ventas_presupuesto))
  end

  test "should show ventas_presupuesto" do
    get :show, id: @ventas_presupuesto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_presupuesto
    assert_response :success
  end

  test "should update ventas_presupuesto" do
    put :update, id: @ventas_presupuesto, ventas_presupuesto: {  }
    assert_redirected_to ventas_presupuesto_path(assigns(:ventas_presupuesto))
  end

  test "should destroy ventas_presupuesto" do
    assert_difference('Ventas::Presupuesto.count', -1) do
      delete :destroy, id: @ventas_presupuesto
    end

    assert_redirected_to ventas_presupuestos_path
  end
end
