# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130701024956) do

  create_table "acciones", :force => true do |t|
    t.integer  "servicios_id",                 :null => false
    t.string   "accion",       :limit => 1000, :null => false
    t.datetime "fecha",                        :null => false
  end

  create_table "accions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_notes", :force => true do |t|
    t.string   "resource_id",     :null => false
    t.string   "resource_type",   :null => false
    t.integer  "admin_user_id"
    t.string   "admin_user_type"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "admin_notes", ["admin_user_type", "admin_user_id"], :name => "index_admin_notes_on_admin_user_type_and_admin_user_id"
  add_index "admin_notes", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cartas", :force => true do |t|
    t.string "co_cli",    :limit => 20, :null => false
    t.date   "entregado",               :null => false
    t.string "co_zon",    :limit => 20, :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre",                        :limit => 50,                                  :null => false
    t.integer  "ci",                                                                           :null => false
    t.string   "nacionalidad",                  :limit => 50,                                  :null => false
    t.string   "estado_civil",                  :limit => 20,                                  :null => false
    t.string   "direccion",                     :limit => 500,                                 :null => false
    t.string   "telefono",                      :limit => 15,                                  :null => false
    t.string   "empleado_en",                   :limit => 50
    t.string   "direccion_trabajo",             :limit => 500
    t.string   "telefono_trabajo",              :limit => 15
    t.integer  "tiempo"
    t.integer  "sueldo"
    t.string   "cargo",                         :limit => 50
    t.integer  "subordinados"
    t.string   "otros_ingresos",                :limit => 50
    t.string   "conyugue_nombre",               :limit => 50
    t.integer  "conyugue_ci"
    t.string   "conyugue_empleado_en",          :limit => 50
    t.string   "conyugue_telefono",             :limit => 15
    t.integer  "conyugue_tiempo"
    t.integer  "conyugue_sueldo"
    t.string   "conyugue_cargo",                :limit => 50
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.decimal  "latitude",                                     :precision => 15, :scale => 10
    t.decimal  "longitude",                                    :precision => 15, :scale => 10
    t.string   "telefono2"
    t.string   "telefono3"
    t.string   "email"
    t.string   "direccion2"
    t.integer  "parroquia_id"
    t.string   "referencia_uno_nombre"
    t.string   "referencia_uno_parentesco"
    t.string   "referencia_uno_direccion"
    t.string   "referencia_uno_telefono"
    t.string   "referencia_uno_observaciones"
    t.string   "referencia_dos_nombre"
    t.string   "referencia_dos_parentesco"
    t.string   "referencia_dos_direccion"
    t.string   "referencia_dos_telefono"
    t.string   "referencia_dos_observaciones"
    t.string   "referencia_tres_nombre"
    t.string   "referencia_tres_parentesco"
    t.string   "referencia_tres_direccion"
    t.string   "referencia_tres_telefono"
    t.string   "referencia_tres_observaciones"
  end

  add_index "clientes", ["ci", "nombre"], :name => "index_clientes"

  create_table "detalles_presupuestos", :force => true do |t|
    t.integer  "presupuesto_id",               :null => false
    t.string   "codigo",         :limit => 50, :null => false
    t.float    "cantidad",                     :null => false
    t.float    "precio",                       :null => false
    t.float    "total",                        :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "entregas", :force => true do |t|
    t.integer  "servicios_id",                 :null => false
    t.string   "observacion",  :limit => 1000, :null => false
    t.datetime "fecha",                        :null => false
  end

  create_table "estados", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "experiencia", :force => true do |t|
    t.date     "desde"
    t.string   "resultado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inbox", :force => true do |t|
    t.string    "number",     :limit => 20, :default => "", :null => false
    t.datetime  "smsdate",                                  :null => false
    t.timestamp "insertdate",                               :null => false
    t.text      "text"
    t.integer   "phone",      :limit => 1
    t.integer   "processed",  :limit => 1,  :default => 0,  :null => false
  end

  create_table "multipartinbox", :force => true do |t|
    t.string    "number",     :limit => 20, :default => "", :null => false
    t.datetime  "smsdate",                                  :null => false
    t.timestamp "insertdate",                               :null => false
    t.text      "text"
    t.integer   "phone",      :limit => 1
    t.integer   "processed",  :limit => 1,  :default => 0,  :null => false
    t.integer   "refnum"
    t.integer   "maxnum"
    t.integer   "curnum"
  end

  create_table "municipios", :force => true do |t|
    t.string   "descripcion"
    t.integer  "estado_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "notificaciones", :force => true do |t|
    t.integer  "mes_desde"
    t.integer  "mes_hasta"
    t.date     "fecha"
    t.string   "resultado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "opciones", :force => true do |t|
    t.string "mensaje", :limit => 500, :null => false
  end

  create_table "outbox", :force => true do |t|
    t.string    "number",         :limit => 20,  :default => "",                    :null => false
    t.timestamp "processed_date",                                                   :null => false
    t.datetime  "insertdate",                                                       :null => false
    t.string    "text",           :limit => 160
    t.integer   "phone",          :limit => 1
    t.integer   "processed",      :limit => 1,   :default => 0,                     :null => false
    t.integer   "error",          :limit => 1,   :default => -1,                    :null => false
    t.integer   "dreport",        :limit => 1,   :default => 0,                     :null => false
    t.time      "not_before",                    :default => '2000-01-01 00:00:00', :null => false
    t.time      "not_after",                     :default => '2000-01-01 23:59:59', :null => false
    t.string    "co_cli",         :limit => 20,  :default => ""
    t.date      "fec_venc",                                                         :null => false
  end

  create_table "parroquia", :force => true do |t|
    t.string   "descripcion"
    t.integer  "municipio_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "presupuestos", :force => true do |t|
    t.integer  "cliente_id",                                                 :null => false
    t.string   "instalacion",                 :limit => 50,                  :null => false
    t.float    "inicial",                                                    :null => false
    t.integer  "giros",                                                      :null => false
    t.float    "cuota",                                                      :null => false
    t.integer  "giros_especiales",                                           :null => false
    t.float    "cuota_especial",                                             :null => false
    t.integer  "vendedor",                                                   :null => false
    t.integer  "aprobado_por"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.float    "flete",                                     :default => 0.0
    t.string   "vendedor_id"
    t.string   "comercial_uno_nombre"
    t.boolean  "comercial_uno_estado"
    t.string   "comercial_uno_ano"
    t.string   "comercial_dos_nombre"
    t.boolean  "comercial_dos_estado"
    t.string   "comercial_dos_ano"
    t.string   "fiador_nombre"
    t.string   "fiador_ci"
    t.string   "fiador_nacionalidad"
    t.string   "fiador_estado_civil"
    t.string   "fiador_direccion"
    t.string   "fiador_telefono"
    t.string   "fiador_empleado_en"
    t.string   "fiador_direccion_trabajo"
    t.string   "fiador_tiempo_servicio"
    t.string   "fiador_cargo"
    t.string   "fiador_telefono_trabajo"
    t.string   "fiador_sueldo"
    t.string   "fiador_email"
    t.string   "fiador_comercial_uno_nombre"
    t.boolean  "fiador_comercial_uno_estado"
    t.string   "fiador_comercial_uno_ano"
    t.string   "fiador_comercial_dos_nombre"
    t.boolean  "fiador_comercial_dos_estado"
    t.string   "fiador_comercial_dos_ano"
    t.string   "rowguid"
  end

  create_table "profit_arts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profit_cobros", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profit_reng_cobs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profit_vendedors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "seguimientos", :force => true do |t|
    t.string   "cliente_id",  :limit => 50,  :null => false
    t.string   "motivo",      :limit => 50,  :null => false
    t.string   "observacion", :limit => 500
    t.string   "usuario",     :limit => 50
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.date     "plazo_pago"
    t.string   "factura"
    t.integer  "user_id"
  end

  create_table "servicios", :force => true do |t|
    t.string   "cliente",     :limit => 10,   :null => false
    t.string   "situacion",   :limit => 1000, :null => false
    t.string   "observacion", :limit => 1000, :null => false
    t.datetime "fecha",                       :null => false
    t.integer  "factura",                     :null => false
    t.string   "articulo",    :limit => 30,   :null => false
    t.string   "estado",      :limit => 1,    :null => false
  end

  create_table "telefonos", :force => true do |t|
    t.string "nombre",   :limit => 100, :null => false
    t.string "apellido", :limit => 100, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "name"
    t.string   "profit"
    t.integer  "role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "ventas_presupuestos", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
