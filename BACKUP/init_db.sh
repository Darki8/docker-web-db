#!/bin/bash
set -e

# Create SQL statements using environment variables
QUERY1="CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
QUERY2="CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
QUERY3="GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
QUERY4="FLUSH PRIVILEGES;"
QUERY5="USE ${MYSQL_DATABASE}; CREATE TABLE IF NOT EXISTS info (id INT AUTO_INCREMENT PRIMARY KEY, f_name VARCHAR(30) NOT NULL, l_name VARCHAR(30) NOT NULL, pho_no INT NOT NULL);"
QUERY6="USE ${MYSQL_DATABASE}; CREATE TABLE IF NOT EXISTS recipes (id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(30) NOT NULL, image_url VARCHAR(60) NOT NULL, description VARCHAR(100() NOT NULL, ingredients VARCHAR(60) NOT NULL, instructions VARCHAR(255) NOT NULL;"


# Execute SQL queries
echo "Executing SQL queries..."

for QUERY in "$QUERY1" "$QUERY2" "$QUERY3" "$QUERY4" "$QUERY5" "$QUERYS6"; do
    echo "Executing query: $QUERY"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "$QUERY"
    echo "Query executed successfully!" >> /tmp/logfile.txt
done

mysql -u root --password="$MYSQL_ROOT_PASSWORD" ${MYSQL_DATABASE} -e "CREATE TABLE IF NOT EXISTS recipes (
  id INT AUTO_INCREMENT,
  title VARCHAR(255),
  image_url VARCHAR(255),
  description TEXT,
  ingredients TEXT,
  instructions TEXT,
  PRIMARY KEY (id)
)"

# Add example entries
mysql -u root --password="$MYSQL_ROOT_PASSWORD" ${MYSQL_DATABASE} -e "
  INSERT INTO recipes (title, image_url, description, ingredients, instructions)
  VALUES
    ('Classic Beef Hamburgers', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnLEJWFMbNZnNNJHXDrm0P0f16rinrjNrbGQ&s', 'Juicy beef hamburgers topped with melted cheese, crispy bacon, and fresh lettuce, served on a toasted bun.', '1 kg ground beef, 1 medium onion, finely chopped, 3 cloves of garlic, minced, 15 ml Worcestershire sauce, 5 g salt, 2.5 g black pepper, 4 hamburger buns, 4 slices of cheese (American or cheddar), 4 slices of bacon, Lettuce tomato pickles and any other desired toppings', 
    'Preheat a grill or grill pan to medium-high heat. 
    In a large bowl, combine ground beef, chopped onion, minced garlic, Worcestershire sauce, salt, and pepper; Mix well with your hands until just combined. 
    Divide the mixture into 4 equal portions and shape into patties. 
    Grill the patties for 4-5 minutes per side, or until cooked to your desired level of doneness. 
    Meanwhile, toast the hamburger buns on the grill or in a toaster. 
    Assemble the burgers by spreading a slice of cheese on the bottom bun, followed by a cooked patty, a few slices of bacon, lettuce, tomato, pickles, and finally the top bun. 
    Serve immediately and enjoy!
    '),

    ('Creamy Carbonara with Bacon and Eggs',
    'https://ch.media.oswald-info.com/amasty/blog/spaghetti-alla-carbonara-2000x500.jpg',
    'A rich and creamy pasta dish loaded with crispy bacon, soft eggs, and parmesan cheese.',
    '340g spaghetti, 120g bacon, diced, 3 large eggs, 250g grated parmesan cheese, 120ml heavy cream, Salt and black pepper, to taste, Fresh parsley, chopped (optional)',
    'Bring a large pot of salted water to a boil and cook the spaghetti according to package instructions until al dente. In a large skillet, cook the diced bacon over medium heat until crispy. Remove from heat and set aside. In a medium bowl, whisk together the eggs, parmesan cheese, and a pinch of salt and pepper. Add the cooked spaghetti to the bowl and toss with the egg mixture until well combined. Add the heavy cream to the bowl and toss until the spaghetti is coated in a creamy sauce. Add the cooked bacon to the bowl and toss until well combined. Season with salt and black pepper to taste. Serve immediately, garnished with chopped fresh parsley if desired.'
    ),

    (
    'Classic Margherita Pizza',
    'https://example.com/pizza.jpg',
    'A simple yet flavorful pizza topped with fresh tomatoes, creamy mozzarella, and fragrant basil.',
    '450g pizza dough, 400g tomato sauce, 200g fresh mozzarella cheese, sliced, 60g fresh basil leaves, chopped, Salt and pepper, to taste',
    'Preheat the oven to 220°C. Roll out the pizza dough to a thickness of 6 mm and place on a baking sheet. Spread the tomato sauce evenly over the dough, leaving a 2.5 cm border around the edges. Arrange the sliced mozzarella cheese over the sauce. Sprinkle the chopped basil leaves over the cheese. Season with salt and pepper to taste. Bake the pizza in the preheated oven for 12-15 minutes, or until the crust is golden brown and the cheese is melted and bubbly. Remove from the oven and let cool for a few minutes before slicing and serving.'
    ),
    
    ('Recipe 4', 'https://example.com/recipe4.jpg', 'This is a description of recipe 4', 'Ingredient 7, Ingredient 8', 'Instruction 7, Instruction 8'),
    ('Recipe 5', 'https://example.com/recipe5.jpg', 'This is a description of recipe 5', 'Ingredient 9, Ingredient 10', 'Instruction 9, Instruction 10');
"