import db
from query import add_category,get_category,get_product,add_prdoucts,update_product,delete_product,get_products_with_category
import json

db_conn = db.mysqlconnect()

product_data = [
    ('Laptop',2),
    ('Smartphone',2),
    ('Table',3),
    ('Chair',3),
    ('Kids Bed Time Story',1),
]

#1 add category function 
# add_category(db_conn)

#2 add product function 
# add_prdoucts(db_conn,product_data)

# update 2 products
# "Laptop" to "Gaming Laptop"
# "Chair" to "computer chair"
# update_product(db_conn,'Gaming Laptop','Laptop')
# update_product(db_conn,'computer Chair','Chair')

# delete 1 product
# "Kids Bed Time Story"
# delete_product(db_conn,'Kids Bed Time Story')

# category = get_category(db_conn)
# products = get_product(db_conn)
# product_with_cat_name = get_products_with_category(db_conn)
# print(
#   json.dumps(category, default=str, indent=4)
# )
# print(
#   json.dumps(products, default=str, indent=4)
# )

# print(
#   json.dumps(product_with_cat_name, default=str, indent=4)
# )

def main():
    num=10
    while int(num):
        # print(num)
        num = input('please enter number between (1 to 7) and 0 for exit: ')
        if int(num) == 1:
            category_name = input('Enter category name: ')
            add_category(db_conn,category_name)
        elif int(num) == 2:
            product_name = input('Enter product name: ')
            cat_id = input('Enter category id : ')
            add_prdoucts(db_conn,product_name,int(cat_id))
        elif int(num)==3:
            product_name = input('Enter product name: ')
            product_id = input('Enter product id : ')
            update_product(db_conn,product_name,product_id)
        elif int(num)==4:
            product_id = input('Enter product id : ')
            delete_product(db_conn,product_id)
        elif int(num)==5:
            category = get_category(db_conn)
            print(
              json.dumps(category, default=str, indent=4)
            )
        elif int(num)==6:
            product = get_product(db_conn)
            print(
              json.dumps(product, default=str, indent=4)
            )
        elif int(num)==7:
            product_with_category = get_products_with_category(db_conn)
            print(
              json.dumps(product_with_category, default=str, indent=4)
            )      
        # num = input('please enter number between 1 to 7: ')
            
    
main()    