# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_30_064955) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "csv_id"
    t.string "uid"
    t.string "zip_code_prefix"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_id"], name: "index_customers_on_csv_id", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.string "order_csv_id"
    t.integer "csv_id"
    t.string "product_csv_id"
    t.string "seller_csv_id"
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "shipping_limit_at"
    t.float "price"
    t.float "freight_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["seller_id"], name: "index_order_items_on_seller_id"
  end

  create_table "order_payments", force: :cascade do |t|
    t.string "order_csv_id"
    t.bigint "order_id", null: false
    t.integer "payment_sequential"
    t.string "payment_type"
    t.integer "payment_installments"
    t.float "payment_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_payments_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "csv_id"
    t.string "customer_csv_id"
    t.string "status"
    t.bigint "customer_id", null: false
    t.datetime "purchased_at"
    t.datetime "approved_at"
    t.datetime "delivered_to_carrier_at"
    t.datetime "delivered_to_customer_at"
    t.datetime "estimated_delivery_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_id"], name: "index_orders_on_csv_id", unique: true
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "csv_id"
    t.string "category_name"
    t.integer "name_length"
    t.integer "description_length"
    t.integer "photos_qty"
    t.integer "weight_g"
    t.integer "length_cm"
    t.integer "height_cm"
    t.integer "width_cm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_id"], name: "index_products_on_csv_id", unique: true
  end

  create_table "sellers", force: :cascade do |t|
    t.string "csv_id"
    t.string "zip_code_prefix"
    t.string "city"
    t.string "state"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_id"], name: "index_sellers_on_csv_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_items", "sellers"
  add_foreign_key "order_payments", "orders"
  add_foreign_key "orders", "customers"
end
