all: pdfreactor prince antennahouse vivliostyle

pdfreactor:
	-pdfreactor -v -j index.html pdfreactor.pdf

prince: 
	-prince -v --javascript index.html prince.pdf

vivliostyle: 
	-vivliostyle-formatter index.html 

antennahouse:
	-run.sh -d  index.html -o antennahouse.pdf

clean:
	find . -name \*.pdf -exec rm {} \;

images: FORCE
	mkdir -p images/pdfreactor images/princexml images/antennahouse images/vivliostyle
	echo 1 >images/placeholder
	-convert -density 150 -quality 85 pdfreactor.pdf         images/pdfreactor/pdfreactor.png
	-convert -density 150 -quality 85 prince.pdf             images/princexml/prince.png
	-convert -density 150 -quality 85 antennahouse.pdf       images/antennahouse/antennahouse.png
	-convert -density 150 -quality 85 vivliostyle-output.pdf images/vivliostyle/vivliostyle.png
	-convert -thumbnail 100x100 -background white -alpha remove pdfreactor.pdf          images/pdfreactor/thumb-pdfreactor.png
	-convert -thumbnail 100x100 -background white -alpha remove prince.pdf              images/princexml/thumb-prince.png
	-convert -thumbnail 100x100 -background white -alpha remove antennahouse.pdf        images/antennahouse/thumb-antennahouse.png
	-convert -thumbnail 100x100 -background white -alpha remove vivliostyle-output.pdf  images/vivliostyle/thumb-vivliostyle.png

push: 
	git push


docs: FORCE
	git pull
	virtualenv-2.7 .
	bin/pip install sphinx sphinx-bootstrap-theme ninja sphinxcontrib-googleanalytics
	cd docs; make html
	cp -av docs/build/html/* /var/www/print-css.rocks

FORCE:
