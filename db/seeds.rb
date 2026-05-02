require "open-uri"

# ----------------------------------------------------------------
# Users
# ----------------------------------------------------------------
User.find_or_create_by!(email: "admin@casaxolo.org") do |u|
  u.name = "Casa Xolo Admin"
  u.password = "password"
  u.password_confirmation = "password"
end

# ----------------------------------------------------------------
# Pets
# ----------------------------------------------------------------
def attach_remote_image(pet, url, filename)
  return if pet.photos.attached?

  file = URI.open(url)  # rubocop:disable Security/Open
  pet.photos.attach(io: file, filename: filename, content_type: "image/jpeg")
rescue => e
  Rails.logger.warn("[seeds] Could not attach photo for #{pet.name}: #{e.message}")
end

pets_data = [
  {
    name: "Luna",
    species: :dog,
    breed: "Mixed Breed",
    sex: :female,
    color: "Black",
    age: 2,
    size: :medium,
    status: :available,
    description: "Luna is a gentle and affectionate mixed-breed dog who loves long walks and cuddles. She gets along well with other dogs and older children.",
    photo_url: "https://loremflickr.com/640/480/dog,puppy?lock=1",
    photo_filename: "luna.jpg"
  },
  {
    name: "Simba",
    species: :cat,
    breed: "Domestic Shorthair",
    sex: :male,
    color: "Cream",
    age: 1,
    size: :small,
    status: :available,
    description: "Simba is a playful and curious cat who enjoys chasing toys and lounging in sunny spots. He's great with calm households.",
    photo_url: "https://loremflickr.com/640/480/cat,kitten?lock=2",
    photo_filename: "simba.jpg"
  },
  {
    name: "Coco",
    species: :dog,
    breed: "Chihuahua Mix",
    sex: :female,
    color: "Brown",
    age: 3,
    size: :small,
    status: :available,
    description: "Coco is a tiny but spirited pup with a huge personality. She bonds deeply with her people and loves being carried on adventures.",
    photo_url: "https://loremflickr.com/640/480/dog,chihuahua?lock=3",
    photo_filename: "coco.jpg"
  },
  {
    name: "Mochi",
    species: :cat,
    breed: "Tabby Mix",
    sex: :female,
    color: "Orange",
    age: 2,
    size: :small,
    status: :available,
    description: "Mochi is a sweet tabby who purrs at the drop of a hat. She loves being brushed and will follow you from room to room.",
    photo_url: "https://loremflickr.com/640/480/cat,tabby?lock=4",
    photo_filename: "mochi.jpg"
  },
  {
    name: "Bruno",
    species: :dog,
    breed: "Labrador Mix",
    sex: :male,
    color: "Chocolate",
    age: 4,
    size: :large,
    status: :urgent,
    description: "Bruno is a big-hearted lab mix who needs a home ASAP. He's fully vaccinated, neutered, and great with kids.",
    photo_url: "https://loremflickr.com/640/480/dog,labrador?lock=5",
    photo_filename: "bruno.jpg"
  },
  {
    name: "Pilar",
    species: :cat,
    breed: "Siamese Mix",
    sex: :female,
    color: "Cream and Brown",
    age: 5,
    size: :medium,
    status: :adopted,
    description: "Pilar found her forever home! A vocal and loving Siamese mix who stole her adopter's heart on day one.",
    photo_url: "https://loremflickr.com/640/480/cat,siamese?lock=6",
    photo_filename: "pilar.jpg"
  }
]

pets_data.each do |attrs|
  photo_url = attrs.delete(:photo_url)
  photo_filename = attrs.delete(:photo_filename)

  pet = Pet.find_or_initialize_by(name: attrs[:name])
  pet.assign_attributes(attrs) if pet.new_record?
  pet.save!

  attach_remote_image(pet, photo_url, photo_filename)

  puts "[seeds] #{pet.new_record? ? "Created" : "Found"} pet: #{pet.name} (#{pet.status})"
end

puts "[seeds] Done — #{Pet.count} pets, #{User.count} users."

# ----------------------------------------------------------------
# Events
# ----------------------------------------------------------------
events_data = [
  {
    name: "Community Adoption Day",
    event_date: Time.zone.local(2026, 6, 20, 10, 0),
    location: "Casa Xolo Foundation — Future Location",
    description: "Join us for a special adoption event featuring all of our available pets. Meet and greet potential new family members!"
  },
  {
    name: "Volunteer Orientation",
    event_date: Time.zone.local(2026, 6, 27, 14, 0),
    location: "Online Virtual Event",
    description: "Learn how you can help make a difference in the lives of rescued animals. All volunteers welcome!"
  },
  {
    name: "Trail Walk & Community Meetup",
    event_date: Time.zone.local(2026, 7, 12, 9, 0),
    location: "Barton Creek Greenbelt, Austin TX",
    description: "Bring your dogs and join us for a scenic group walk celebrating our love of animals, nature, and community."
  },
  {
    name: "Cultural Workshop: Día de los Muertos",
    event_date: Time.zone.local(2026, 11, 1, 11, 0),
    location: "Casa Xolo Foundation — Future Location",
    description: "A hands-on workshop honoring our heritage through storytelling, art, and the animals we love."
  }
]

events_data.each do |attrs|
  event = Event.find_or_initialize_by(name: attrs[:name])
  event.assign_attributes(attrs) if event.new_record?
  event.save!
  puts "[seeds] #{event.previously_new_record? ? "Created" : "Found"} event: #{event.name}"
end

puts "[seeds] Done — #{Event.count} events."
