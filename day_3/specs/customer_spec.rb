require("minitest/autorun")
require("minitest/reporters")
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../customer")
require_relative("../pub")
require_relative("../drink")

class CustomerTest < MiniTest::Test
  def setup()
    @customer = Customer.new("Bob", 50, 90)
    @customer2 = Customer.new("Hobo", 0, 1000)
    @customer3 = Customer.new("Kiddo", 500, 10)
    @pub = Pub.new("Friendly Arm Inn", 1000, [])
    @drink = Drink.new("Vodka", 10,5)
    @drink2 = Drink.new("Free Grog", 0,1)
  end

  def test_get_name
    assert_equal("Bob", @customer.name)
  end

  def test_get_age
    assert_equal(10, @customer3.age)
  end

  def test_get_wallet__has_money
    assert_equal(50, @customer.wallet)
  end

  def test_get_wallet__has_no_money
    assert_equal(0, @customer2.wallet)
  end

  def test_get_drunkenness
    assert_equal(0, @customer2.drunkenness)
  end

  def test_decrease_wallet_amount()
    assert_equal(40, @customer.decrease_wallet_amount(10))
  end

  def test_buy_drink
    drink = @drink.price
    @customer.buy_drink(@pub, drink)
    assert_equal(1010, @pub.till)
    assert_equal(40, @customer.wallet)
  end

  def test_buy_drink__too_young
    drink = @drink.price
    assert_equal("You are too young to buy drinks", @customer3.buy_drink(@pub, drink))
  end

  def test_buy_drink__wrong_price
    assert_nil(@customer.buy_drink(@pub, -100))
  end


  def test_increase_drunkenness()
    drink = @drink.alcohol_level()
    @customer.increase_drunkenness(drink)
    @customer.increase_drunkenness(drink)
    assert_equal(10, @customer.drunkenness)
  end


  def test_too_drunk_to_buy()
    drink = @drink.alcohol_level()
    @customer.increase_drunkenness(drink)
    @customer.increase_drunkenness(drink)
    @customer.increase_drunkenness(drink)
    @customer.increase_drunkenness(drink)
    @customer.increase_drunkenness(drink)
    assert_equal("You are too drunk to buy a drink", @customer.buy_drink(@pub, @drink))
  end


end
