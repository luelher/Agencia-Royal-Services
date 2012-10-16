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

ActiveRecord::Schema.define(:version => 20121010041956) do

  create_table "acciones", :force => true do |t|
    t.integer  "servicios_id",                 :null => false
    t.string   "accion",       :limit => 1000, :null => false
    t.datetime "fecha",                        :null => false
  end

  create_table "cartas", :force => true do |t|
    t.string   "co_zon",    :limit => 20, :null => false
    t.string   "co_cli",    :limit => 20, :null => false
    t.datetime "entregado",               :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre",               :limit => 50,  :null => false
    t.integer  "ci",                                  :null => false
    t.string   "nacionalidad",         :limit => 50,  :null => false
    t.string   "estado_civil",         :limit => 20,  :null => false
    t.string   "direccion",            :limit => 500, :null => false
    t.string   "telefono",             :limit => 15,  :null => false
    t.string   "empleado_en",          :limit => 50
    t.string   "direccion_trabajo",    :limit => 500
    t.string   "telefono_trabajo",     :limit => 15
    t.integer  "tiempo"
    t.integer  "sueldo"
    t.string   "cargo",                :limit => 50
    t.integer  "subordinados"
    t.string   "otros_ingresos",       :limit => 50
    t.string   "conyugue_nombre",      :limit => 50
    t.integer  "conyugue_ci"
    t.string   "conyugue_empleado_en", :limit => 50
    t.string   "conyugue_telefono",    :limit => 15
    t.integer  "conyugue_tiempo"
    t.integer  "conyugue_sueldo"
    t.string   "conyugue_cargo",       :limit => 50
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "clientes", ["ci", "nombre"], :name => "index_clientes"

  create_table "entregas", :force => true do |t|
    t.integer  "servicios_id",                 :null => false
    t.string   "observacion",  :limit => 1000, :null => false
    t.datetime "fecha",                        :null => false
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
    t.integer   "telefonos_id"
  end

  create_table "profit_cobros", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profit_reng_cobs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
