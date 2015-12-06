require 'rails_helper'

RSpec.describe Endorsement, type: :model do
  it{ should belong_to :review }
end