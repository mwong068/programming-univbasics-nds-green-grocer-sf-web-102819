def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  collection.each do |things|
    if things[:item] === name
      return things
    end
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  fresh_cart = []
    cart.each do |things|
      name = things[:item]
      about = find_item_by_name_in_collection(name, fresh_cart)
      if about != nil
        about[:count] += 1
      else
        fresh_cart.push({
          :item => name,
          :price => things[:price],
          :clearance => things[:clearance],
          :count => 1
        })
      end
    end
  fresh_cart
  end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon_thing|
    coupony = find_item_by_name_in_collection(coupon_thing[:item], cart)
    coupony_w_coupon = find_item_by_name_in_collection(coupon_thing[:item] + "w/coupon", cart)
      if coupony[:count] && coupony_w_coupon >= coupon_thing[:num]   #if cart contains coupon item
        coupony_w_coupon[:count] += coupon_thing[:num]
        
  
  
  
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |thing|
    if thing[:clearance]
      thing[:price] *= 0.8
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  done_shopping = consolidate_cart(cart)
  final_cart_w_coupons = apply_coupons(done_shopping, coupons)
  final_cart = apply_clearance(final_cart_w_coupons)
  
  checkout_total = 0
  final_cart.each do |thing|
    checkout_total += thing[:price]*thing[:count]
  end
  
  if checkout_total > 100
    checkout_total *= 0.9
  end
  return checkout_total.round(2)
end