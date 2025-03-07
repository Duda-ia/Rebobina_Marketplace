# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Product.destroy_all

# Gerando produtos de exemplo
Product.create!(
  category: "Electronics",
  name: "Smartphone",
  description: "A high-end smartphone with a large display.",
  price: 999.99
)

Product.create!(
  category: "Furniture",
  name: "Sofa",
  description: "A comfortable and stylish sofa for living rooms.",
  price: 450.00
)

Product.create!(
  category: "Books",
  name: "Programming Ruby",
  description: "A comprehensive guide to Ruby programming language.",
  price: 50.00
)

Product.create!(
  category: "Clothing",
  name: "T-Shirt",
  description: "A casual cotton t-shirt in various colors.",
  price: 20.00
)
