require 'spec_helper'

class Post
  extend ActiveModel::Translation
  include ActiveModel::Validations
  attr_accessor :article_page
end

describe "check url" do
  before :each do
    @post = Post.new
  end

  context "[simple checking]" do
    it "should accept nil if :allow_nil is set" do
      @validator = HasUrl.new(:attributes => [ :article_page ], :allow_nil => true)
      @validator.validate_each(@post, :article_page, nil)
      expect(@post.errors).to be_empty

    end

    it "should accept \"\" if :allow_blank is set" do
      @validator = HasUrl.new(:attributes => [ :field ], :allow_blank => true)
      @validator.validate_each(@post, :article_page, "")
      expect(@post.errors).to be_empty
    end
  end

  context "[url checking]" do
    it "no errors for valid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "http://google.com")
      expect(@post.errors).to be_empty
    end

    it "no errors for valid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "http://google.com/make_sense")
      expect(@post.errors).to be_empty
    end 

    pending "errors for invalid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "http://www.sdfdsfdsfdsfdsfsdfsd.com/")
      expect(@post.errors.size).to eql(1)
    end

    it "errors for invalid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "google")
      expect(@post.errors.size).to eql(1)
    end

    it "errors for invalid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "google")
      expect(@post.errors.size).to eql(1)
    end

    it "errors for invalid urls" do
      @validator = HasUrl.new(:attributes => [ :article_page ])
      @validator.validate_each(@post, :article_page, "h:oogle")
      expect(@post.errors.size).to eql(1)
    end

  end

end