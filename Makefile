.PHONY: run

run:
	docker-compose build && docker-compose run --rm web bash -c "bin/rails db:environment:set RAILS_ENV=development && rails db:setup"

setup_local_production:
	make run && docker-compose -f docker-compose-lp.yml build \
	&& docker-compose -f docker-compose-lp.yml run web bash -c \
	"bin/rails db:environment:set RAILS_ENV=local_production \
	&& rake assets:precompile" \
	&& docker-compose -f prometheus/docker-compose.yml build

run_local_production:
	docker-compose -f prometheus/docker-compose.yml up & docker-compose -f docker-compose-lp.yml up
