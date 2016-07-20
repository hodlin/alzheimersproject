# Should be executed once
# source("http://bioconductor.org/biocLite.R")
# biocLite("PAA")
source("http://bioconductor.org/biocLite.R")
biocLite("limma")
source("http://bioconductor.org/biocLite.R")
biocLite("vsn")

library("PAA")
#downloading data
elist  <- loadGPR(gpr.path="~/R_projects/alzheimersproject/data",targets.path="~/R_projects/alzheimersproject/data/targets.txt", array.type="ProtoArray")

plotArray(elist=elist, idx=3, data.type="bg", log=FALSE, normalized=FALSE,
          aggregation="min", colpal="topo.colors")

#substract background
library("limma")
elist <- backgroundCorrect(elist, method="normexp",normexp.method="saddle")

plotArray(elist=elist, idx=3, data.type="bg", log=FALSE, normalized=FALSE,
          aggregation="min", colpal="topo.colors")

elist <- normalizeArrays(elist=elist, method="cyclicloess", cyclicloess.method="fast")

str(object_1)
str(object_bg)

library("vsn")
plotMAPlots(elist=elist, idx=10)

elist <- batchAdjust(elsit=elist, log=TRUE)
plotArray(elist=elist, idx=3, data.type="fg", log=TRUE, normalized=TRUE,
          aggregation="min", colpal="topo.colors")

elist.unlog <- elist
elist.unlog$E <- 2^(elist$E)

c1 <- elist$targets$ArrayID[elist$targets$Group=="AD"]
c2 <- elist$targets$ArrayID[elist$targets$Group=="NDC"]
volcanoPlot(elist=elist, group1=c1, group2=c2, log=TRUE, method="tTest", p.thresh=0.01, fold.thresh=2)

mMs.matrix1 <- mMs.matrix2 <- mMsMatrix(x=20, y=20)
volcanoPlot(elist=elist.unlog, group1=c1, group2=c2, log=FALSE, method="mMs",
            p.thresh=0.01, fold.thresh=2, mMs.matrix1=mMs.matrix1,
            mMs.matrix2=mMs.matrix2, above=1500, between=400)




