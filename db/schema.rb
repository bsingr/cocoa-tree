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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140220203214) do

  create_table "cocoa_pods", force: true do |t|
    t.string   "name"
    t.string   "website_url"
    t.string   "doc_url"
    t.string   "source_url"
    t.integer  "stars"
    t.datetime "pushed_at"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
    t.string   "category"
    t.string   "wiki_url"
  end

end
