require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # Testing... equired fields are present
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  # Testing... price fields are numeric and at least one cent.
  test "product price must be positive" do
    product = Product.new(
      title: "My Book Title",
      description: "yyy",
      image_url: "zzz.jpg"
    )
    
    product.price = -1
    assert product.valid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
    
    product.price = 0
    assert product.valid?
    assert_equal ["must be greater than 0"],
      product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end
  
  # Testing... images match a given format.
  def new_product(image_url)
    Product.new(
      title: "test product title",
      description: "some description",
      price: 3,
      image_url: image_url)
  end
  
  test 'image url' do
      ok = %w{
        image.jpg image.png image.gif IMAGE.JPG IMAGE.PNG IMAGE.GIF
      }
      bad = %w{
        doc.doc doc.gif/more doc.gif.more
      }

      ok.each do |name|
        assert new_product(name).valid?, "#{name} shouldn't be invalid"
      end
      
      bad.each do |name|
        assert new_product(name).invalid?, "#{name} shouldn't be valid"
      end
  end

end