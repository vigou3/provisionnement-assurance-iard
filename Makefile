### -*-Makefile-*- pour préparer "Provisionnement en assurance IARD"
##
## Copyright (C) 2018 Vincent Goulet
##
## 'make pdf' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave et compile le document maître avec XeLaTeX.
##
## 'make tex' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave.
##
## 'make contrib' crée le fichier COLLABORATEURS.
##
## 'make zip' crée l'archive de la distribution.
##
## 'make release' crée une nouvelle version dans GitHub, téléverse le
## fichier .zip et modifie les liens de la page web.
##
## 'make all' est équivalent à 'make pdf' question d'éviter les
## publications accidentelles.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet
## "Provisionnement en assurance IARD"
## http://github.com/vigou3/provisionnement-assurance-iard

## Principaux fichiers
MASTER = provisionnement-assurance-iard.pdf
ARCHIVE = ${MASTER:.pdf=.zip}
README = README.md
COLLABORATEURS = COLLABORATEURS
OTHER = LICENSE

## Le document maître dépend de tous les fichiers .Rnw et des fichiers
## .tex et .R mentionnés ci-dessous.
RNWFILES = $(wildcard *.Rnw)
TEXFILES = \
	couverture-avant.tex \
	notices.tex \
	introduction.tex \
	solutions.tex \
	colophon.tex \
	couverture-arriere.tex
SCRIPTS =

## Informations de publication extraites du fichier maître
TITLE = $(shell grep "\\\\title" ${MASTER:.pdf=.tex} \
	| cut -d { -f 2 | tr -d })
URL = $(shell grep "newcommand{\\\\ghurl" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
YEAR = $(shell grep "newcommand{\\\\year" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

## Auteurs à exclure du fichier COLLABORATEURS (regex)
OMITAUTHORS = Vincent Goulet|Inconnu|unknown

## Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf

## Dossier temporaire pour construire l'archive
TMPDIR = tmpdir

## Dépôt GitHub et authentification
REPOSURL = https://api.github.com/repos/vigou3/provisionnement-assurance-iard
OAUTHTOKEN = $(shell cat ~/.github/token)


all: pdf

.PHONY: tex pdf zip release create-release upload publish clean

FORCE: ;

pdf: $(MASTER)

tex: $(RNWFILES:.Rnw=.tex)

Rout: $(SCRIPTS:.R=.Rout)

contrib: ${COLLABORATEURS}

release: zip create-release upload publish

%.tex: %.Rnw
	$(SWEAVE) '$<'

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< > $<.tmp
	$(RBATCH) $<.tmp $@
	$(RM) $<.tmp

$(MASTER): $(MASTER:.pdf=.tex) $(RNWFILES:.Rnw=.tex) $(TEXFILES) $(SCRIPTS)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

${COLLABORATEURS}: FORCE
	git log --pretty="%an%n" | sort | uniq | \
	  grep -v -E "${OMITAUTHORS}" | \
	  awk 'BEGIN { print "Les personnes dont le nom [1] apparait ci-dessous ont contribué à\nl'\''amélioration de «${TITLE}»." } \
	       { print $$0 } \
	       END { print "\n[1] Noms tels qu'\''ils figurent dans le journal du dépôt Git\n    ${URL}" }' > ${COLLABORATEURS}

zip: ${MASTER} ${README} ${SCRIPTS} ${SCRIPTS:.R=.Rout} ${OTHER} ${COLLABORATEURS}
	if [ -d ${TMPDIR} ]; then ${RM} ${TMPDIR}; fi
	mkdir -p ${TMPDIR}
	touch ${TMPDIR}/${README} && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Auteur/ { printf("## Édition\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${TMPDIR}/${README}
	cp ${MASTER} ${SCRIPTS} ${SCRIPTS:.R=.Rout} ${OTHER} ${COLLABORATEURS} ${TMPDIR}
	cd ${TMPDIR} && zip --filesync -r ../${ARCHIVE} *
	${RM} ${TMPDIR}

create-release :
	@echo ----- Creating release on GitHub...
	@if [ -n "$(shell git status --porcelain | grep -v '^??')" ]; then \
	     echo "uncommitted changes in repository; not creating release"; exit 2; fi
	@if [ -n "$(shell git log origin/master..HEAD)" ]; then \
	    echo "unpushed commits in repository; pushing to origin"; \
	     git push; fi
	if [ -e relnotes.in ]; then rm relnotes.in; fi
	touch relnotes.in
	awk 'BEGIN { ORS = " "; print "{\"tag_name\": \"v${VERSION}\"," } \
	      /^$$/ { next } \
	      /^## Historique/ { state = 1; next } \
              (state == 1) && /^### / { \
		state = 2; \
		out = $$2; \
	        for(i = 3; i <= NF; i++) { out = out" "$$i }; \
	        printf "\"name\": \"Édition %s\", \"body\": \"", out; \
	        next } \
	      (state == 2) && /^### / { exit } \
	      state == 2 { printf "%s\\n", $$0 } \
	      END { print "\", \"draft\": false, \"prerelease\": false}" }' \
	      README.md >> relnotes.in
	curl --data @relnotes.in ${REPOSURL}/releases?access_token=${OAUTHTOKEN}
	rm relnotes.in
	@echo ----- Done creating the release

upload :
	@echo ----- Getting upload URL from GitHub...
	$(eval upload_url=$(shell curl -s ${REPOSURL}/releases/latest \
	 			  | awk -F '[ {]' '/^  \"upload_url\"/ \
	                                    { print substr($$4, 2, length) }'))
	@echo ${upload_url}
	@echo ----- Uploading PDF and archive to GitHub...
	curl -H 'Content-Type: application/zip' \
	     -H 'Authorization: token ${OAUTHTOKEN}' \
	     --upload-file ${ARCHIVE} \
             -i "${upload_url}?&name=${ARCHIVE}" -s
	@echo ----- Done uploading files

publish :
	@echo ----- Publishing the web page...
	${MAKE} -C docs
	@echo ----- Done publishing

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	      *-[0-9][0-9][0-9].pdf \
	      *.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps


