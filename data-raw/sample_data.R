## code to prepare `sample_data` dataset goes here

library(simstudy)
library(data.table)
library(usethis)

d1 <- defData(varname = "n", formula = 100, dist = "noZeroPoisson")

d2 <- defDataAdd(varname = "x1", formula = 0, variance = .1,  dist = "normal")
d2 <- defDataAdd(d2, varname = "x2", formula = 0, variance = .1,  dist = "normal")
d2 <- defDataAdd(d2, varname = "x3", formula = 0, variance = .1,  dist = "normal")
d2 <- defDataAdd(d2, varname = "p", formula = "-0.7 + 0.7*x1 - 0.4*x2",
                 dist = "nonrandom", link="logit")

set.seed(93827)

ds <- genData(100, d1, id = "site")
dc <- genCluster(dtClust = ds, cLevelVar = "site", numIndsVar = "n", level1ID = "id")
dc <- addColumns(d2, dc)

dd <- addCorGen(dc, idvar = "site", param1 = "p",
                rho = 0.15, corstr = "cs", dist = "binary", cnames = "y", method = "ep")

sample_data <- dd[, .(id, site, x1, x2, x3, y)]
usethis::use_data(sample_data, overwrite = TRUE)

rm(d1, d2, dc, ds, dd, sample_data)




