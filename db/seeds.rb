# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

role = Role.create(
  name: 'Admin',
  code: 'ADMIN'
)

Role.create(
  name: 'Holder',
  code: 'HOLDER'
)

User.create!(
  name: 'Juan Carlos Estebes',
  email: 'estebes-admin@example.com',
  password: 'contrasena-no-segura',
  role_id: role.id
)
