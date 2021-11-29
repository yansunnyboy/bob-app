usage:
	@echo "make db-migrate"

db-migrate:
	RAILS_ENV=test bundle exec rails db:drop db:create db:migrate