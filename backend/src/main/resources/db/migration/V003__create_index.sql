INSERT INTO 
    orders (
        id
        ,status
        ,date_created) 
    SELECT 
        i
        ,(array['pending', 'shipped', 'cancelled'])[floor(random() * 3 + 1)]
        ,DATE(NOW() - (random() * (NOW()+'90 days' - NOW()))) 
    FROM generate_series(1, 10000000) s(i);
INSERT INTO 
    order_product (
        quantity
        ,order_id
        ,product_id) 
    SELECT 
        floor(1+random()*50)::int
        ,i
        ,1 + floor(random()*6)::int % 6 
    FROM generate_series(1, 10000000) s(i);
