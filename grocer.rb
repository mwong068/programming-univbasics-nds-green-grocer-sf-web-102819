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
  #iterate through coupon
  #iterate through cart to check if coupon items exists
  #if coupon items are there/true => count the number of existing items in cart => divide that number by coupon amount
  #add updated items to cart
  
 coupons.each do |coupon|
    coupon_about = find_item_by_name_in_collection(coupon[:item], cart) 
       coupon_about_w_coupon = find_item_by_name_in_collection(coupon[:item] + " W/COUPON", cart) 
      if coupon_about_w_coupon && coupon_about[:count] >= coupon[:num]  
        coupon_about_w_coupon[:count] += coupon[:num]
        coupon_about[:count] -= coupon[:num]
      elsif coupon_about && coupon_about[:count] >= coupon[:num]
        cart.push({
          :item => coupon[:item] + " W/COUPON",
          :price => (coupon[:cost] / coupon[:num]).round(2),
          :clearance => coupon_about[:clearance],
          :count => coupon[:num]
        })
        coupon_about[:count] -= coupon[:num]
      end
    end
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
