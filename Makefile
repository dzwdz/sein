.PHONY: install
install:
	gem build sein.gemspec -o sein.gem
	gem install --user sein.gem
