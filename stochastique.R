### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2019 Vincent Goulet, Frédérick Guillot, Mathieu Pigeon
##
## Ce fichier fait partie du projet
## «Provisionnement en assurance IARD»
## https://gitlab.com/vigou3/provisionnement-assurance-iard
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

## Charger le package ChainLadder dans la session de travail.
library(ChainLadder)

###
### MODÈLE DE MACK  `\labelline{stochastique:mack}`
###

## Triangle cumulatif des données
tri <- matrix(c(200, 210, 250, 230, 220, NA, 260, NA, NA), ncol = 3)

## Ajustement du modèle de Mack aux données
model1 <- MackChainLadder(tri)

## Sommaire des résultats
summary(model1)

## On peut aussi extraire les facteurs de développement...
model1$f

### ... les sigmas au carré
model1$sigma^2

### ... et le triangle complété
model1$FullTriangle

### Triangle des paiements cumulés
tri <- matrix(c(35,4,38,61,43,85,49,52,55,47,37,69,41,61,47,30,53,33,
                NA,39,13,43,37,49,45,NA,NA,39,76,44,56,NA,NA,NA,40,16,
                NA,NA,NA,NA),ncol = 5)

## Estimation des paramètres
model1 <-  MackChainLadder(tri)
summary(model1)

## Les facteurs de développement
model1$f

### les sigmas au carré
model1$sigma^2

## Écart-type de la réserve totale
model1$Total.Mack.S.E                   #-*- `\labelline{stochastique:mack:fin}`

###
### MODÈLE DE POISSON  `\labelline{stochastique:poisson}`
###

## Création de la base de données
pmt <- c(100,200,325,350,125,225,335,75,175,50)
Year <- c(1,2,3,4,1,2,3,1,2,1)
Delay <- c(1,1,1,1,2,2,2,3,3,4)
dda <- data.frame(ptm = pmt, Year = Year, Delay = Delay)

### Ajustement du modèle quasi-Poisson
model2 <- glm(pmt ~ as.factor(Year) + as.factor(Delay),
              family = quasipoisson, data = dda)
summary(model2)

## Pour réaliser les prédictions de chacune des cellules
ddaNEW <- c(Year = c(1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4),
            Delay = c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4))

ddaNEW$pred <- predict(model2, newdata = ddaNEW, type =  "response")
ddaNEW

## Triangle incrémental complété
matrix(ddaNEW$pred, ncol = 4)           #-*- `\labelline{stochastique:poisson:fin}`
