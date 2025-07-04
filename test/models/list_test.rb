# == Schema Information
#
# Table name: lists
#
#  id          :uuid             not null, primary key
#  color_theme :string           default("blue")
#  description :text
#  is_public   :boolean          default(FALSE)
#  metadata    :json
#  public_slug :string
#  status      :integer          default("draft"), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_lists_on_created_at              (created_at)
#  index_lists_on_is_public               (is_public)
#  index_lists_on_public_slug             (public_slug) UNIQUE
#  index_lists_on_status                  (status)
#  index_lists_on_user_id                 (user_id)
#  index_lists_on_user_id_and_created_at  (user_id,created_at)
#  index_lists_on_user_id_and_status      (user_id,status)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
