all:
	cp ./pandoc_resume/resume.html ./_includes/resume.html
	tail -n +2 ./pandoc_resume/resume.html > ./_includes/resume.html
serve:
	make
	cp _config.yml _test_config.yml
	echo "url: \"http://localhost:4000\"" >> _alt_config.yml
	jekyll serve --config _test_config.yml
build:
	make
	jekyll build
deploy:
	make 
	cp _config.yml _alt_config.yml
	echo "url: \"http://gpwclark.net\"" >> _alt_config.yml
	jekyll build --config _alt_config.yml
	rsync -v -rz --checksum _site/ price@gpwclark.net:/var/www/html 
clean:
	rm -rf _site
	rm -rf ./_includes/resume.html
	rm -rf _alt_config.yml
	rm -rf _test_config.yml
