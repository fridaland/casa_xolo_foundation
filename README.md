
# Casa Xolo Foundation

A Ruby on Rails 8.1 application for Casa Xolo Foundation.

## Requirements

- Ruby 3.4.1 (see `.ruby-version`)
- PostgreSQL
- Node.js (for JS tooling, if needed)
- Redis (optional, for ActionCable if enabled)
- Bundler (`gem install bundler`)

## Setup

1. **Clone the repository:**
	 ```sh
	 git clone <repo-url>
	 cd casa_xolo_foundation
	 ```

2. **Install dependencies:**
	 ```sh
	 bin/setup
	 ```
	 This will:
	 - Install Ruby gems (`bundle install`)
	 - Prepare the database (`rails db:prepare`)
	 - Clear logs and temp files

3. **Start the development server:**
	 ```sh
	 bin/dev
	 ```
	 This runs the Rails server and Tailwind CSS watcher (see `Procfile.dev`).

## Running the App

- **Development:**  
	`bin/dev` (runs Rails server and Tailwind watcher)

## Linting

- **Ruby style:**  
	`bin/standardrb`
- **Security (Brakeman):**  
	`bin/brakeman`
- **Rubocop (optional):**  
	`rubocop` (uses `.rubocop.yml`)

## Testing

- **RSpec:**  
	```sh
	bundle exec rspec
	```
