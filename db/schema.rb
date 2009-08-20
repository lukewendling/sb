# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090820145711) do

  create_table "challenge_comments", :force => true do |t|
    t.integer  "friend_id"
    t.integer  "challenge_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenge_comments", ["challenge_id"], :name => "index_challenge_comments_on_challenge_id"
  add_index "challenge_comments", ["friend_id"], :name => "index_challenge_comments_on_friend_id"

  create_table "challenges", :force => true do |t|
    t.integer  "challenger_id",                    :null => false
    t.integer  "challenged_id",                    :null => false
    t.integer  "event_id",                         :null => false
    t.text     "prediction",                       :null => false
    t.integer  "winner_id"
    t.text     "result"
    t.string   "hashed_id",                        :null => false
    t.boolean  "accepted",      :default => false, :null => false
    t.boolean  "contested",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["challenged_id"], :name => "index_challenges_on_challenged_id"
  add_index "challenges", ["challenger_id"], :name => "index_challenges_on_challenger_id"
  add_index "challenges", ["event_id"], :name => "index_challenges_on_event_id"
  add_index "challenges", ["hashed_id"], :name => "index_challenges_on_hashed_id", :unique => true

  create_table "events", :force => true do |t|
    t.string   "description"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "atoken"
    t.string   "asecret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.boolean  "tweets",           :default => true, :null => false
  end

  add_index "friends", ["email"], :name => "index_friends_on_email", :unique => true

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["sender_id"], :name => "index_invitations_on_sender_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
