require 'test_helper.rb'

class LinkTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "new link requires title and url" do
    link = Link.new
    assert !link.save
  end
end
