# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Crear un usuario
  user = User.create!(
    email: 'user@example.com',
    password: 'password123',
    password_confirmation: 'password123'
)

# Ahora creamos 50 posts asociados 
50.times do |i|
    Post.create!(
        user: user,
        title: "La brisa suave de la mañana para el post: #{i + 1}",
        content: "Para el contenido de la post: #{i + 1}, tenemos que 
                La brisa suave del atardecer acariciaba los rostros de los transeúntes, 
                mientras las hojas doradas caían lentamente de los árboles. En la 
                distancia, se escuchaba el murmullo del río, y las luces de la ciudad 
                comenzaban a encenderse, creando un espectáculo de colores en el 
                horizonte que anunciaba el fin del día."
    )
end



