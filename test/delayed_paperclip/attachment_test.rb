require 'test_helper'

class AttachmentTest < Test::Unit::TestCase

  def setup
    super
    DelayedPaperclip.options[:url_with_processing] = true
    reset_dummy
  end

  def test_post_processing_with_delay=
    dummy = Dummy.new(:image => File.open("#{ROOT}/test/fixtures/12k.png"))
    assert !dummy.image.post_processing_with_delay, "post processing with delay is false"
    dummy.image.post_processing_with_delay = true
    assert_equal dummy.image.post_processing_with_delay, true
  end

  def test_post_processing_with_delay_for_normal_paperclip
    reset_dummy :with_processed => false
    dummy = Dummy.new(:image => File.open("#{ROOT}/test/fixtures/12k.png"))
    dummy.image.post_processing_with_delay = nil
    assert dummy.image.post_processing_with_delay, "post processing with delay is false"
  end
end