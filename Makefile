### Build and deploy http://www.thomasdegraaff.nl
all:
	hugo
	@git add .
	@git commit -m "deploying site on `date`"
	@git push origin master
	cd public; git add .; git commit -m "Deploying site on `date`"; git push origin master
