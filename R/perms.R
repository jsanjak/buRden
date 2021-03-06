#' Estimate ESM_K p-value by permutation
#' @param ccdata A matrix of markers (columns) and individuals (rows).  Data are coded as the number of copies of the minor allele.
#' @param ccstatus A vector of binary phenotype labels.  0 = control, 1 = case.
#' @param nperms Number of permutations to perform
#' @param k Number of markers to use for ESM_K statistic
#' @return The test statistic, Monte-carlo estimate of P(perm stat >= observed data), and a Z-score based on the permutation distribution.
#' @references Thornton, K. R., Foran, A. J., & Long, A. D. (2013). Properties and Modeling of GWAS when Complex Disease Risk Is Due to Non-Complementing, Deleterious Mutations in Genes of Large Effect. PLoS Genetics, 9(2), e1003258. doi:10.1371/journal.pgen.1003258
#' @examples
#' data(rec.ccdata)
#' rec.ccdata.status = c( rep(0,rec.ccdata$ncontrols),rep(1,rec.ccdata$ncases))
#' #Filter sites: 0 <= MAF in cases < 0.05 && r^2 between pairs < 0.8
#' keep = filter_sites(rec.ccdata$genos,rec.ccdata.status,0,5e-2,0.8)
#' rec.ccdata.esm.p = esm.p.perm( rec.ccdata$genos[,which(keep==1)], rec.ccdata.status, 10, 50 )
esm.p.perm = function( ccdata, ccstatus, nperms, k )
  {
    stat = esm_chisq(ccdata,ccstatus,k)
    perms = esm_perm_binary(ccdata,ccstatus,nperms,k)
    return( list("statistic" = stat,
                 "p.value" = length( which( perms  >= stat) )/nperms,
                 "z" = ( stat - mean(perms) )/sd(perms) )
           )
  }

#' Estimate c-alpha p-value by permutation
#' @param ccdata A matrix of markers (columns) and individuals (rows).  Data are coded as the number of copies of the minor allele.
#' @param ccstatus A vector of binary phenotype labels.  0 = control, 1 = case.
#' @param nperms Number of permutations to perform
#' @param simple.counts See Details.
#' @return The test statistic, Monte-carlo estimate of P(perm stat >= observed data), and a Z-score based on the permutation distribution.
#' @references Neale, B. M., Rivas, M. A., Voight, B. F., Altshuler, D., Devlin, B., Orho-Melander, M., et al. (2011). Testing for an Unusual Distribution of Rare Variants. PLoS Genetics, 7(3), e1001322. doi:10.1371/journal.pgen.1001322
#' @details  When simplecounts = FALSE, heterozygous and homozygous genotypes are treated as different numbers of observations
#' of the mutation.  In other wordes, simplecounts = FALSE is equivalent to colSums( ccdata[status==1,] ).  When simplecounts=TRUE,
#' all nonzero genotype values are treated as the value 1, equivalent to  apply(data[status==1,], 2, function(x) sum(x>0, na.rm=TRUE)).
#' The latter method is used by the R package AssotesteR.
#' @examples
#' data(rec.ccdata)
#' rec.ccdata.status = c( rep(0,rec.ccdata$ncontrols),rep(1,rec.ccdata$ncases))
#' #Filter sites: 0 <= MAF in cases < 0.05 && r^2 between pairs < 0.8
#' keep = filter_sites(rec.ccdata$genos,rec.ccdata.status,0,5e-2,0.8)
#' rec.ccdata.calpha.p = calpha.p.perm( rec.ccdata$genos[,which(keep==1)], rec.ccdata.status, 10 )
calpha.p.perm = function( ccdata, ccstatus, nperms, simple.counts = FALSE )
  {
    stat = cAlpha(ccdata,ccstatus,simple.counts)
    perms = cAlpha_perm(ccdata,ccstatus,nperms,simple.counts)
    return( list("statistic" = stat,
                 "p.value"=length( which( perms >= stat ) )/nperms,
                 "z" = (stat-mean(perms))/sd(perms))
           )
  }

#' Estimate Madsen-Browning p-value by permutation
#' @param ccdata A matrix of markers (columns) and individuals (rows).  Data are coded as the number of copies of the minor allele.
#' @param ccstatus A vector of binary phenotype labels.  0 = control, 1 = case.
#' @param nperms Number of permutations to perform
#' @return A list of statistics, p-values, and Z-scores, one for each of the three models
#' @references Madsen, B. E., & Browning, S. R. (2009). A groupwise association test for rare mutations using a weighted sum statistic. PLoS Genetics, 5(2), e1000384. doi:10.1371/journal.pgen.1000384
#' @examples
#' data(rec.ccdata)
#' rec.ccdata.status = c( rep(0,rec.ccdata$ncontrols),rep(1,rec.ccdata$ncases))
#' #Filter sites: 0 <= MAF in cases < 0.05 && r^2 between pairs < 0.8
#' keep = filter_sites(rec.ccdata$genos,rec.ccdata.status,0,5e-2,0.8)
#' rec.ccdata.MB.p = MB.p.perm( rec.ccdata$genos[,which(keep==1)], rec.ccdata.status, 10 )
MB.p.perm = function(ccdata, ccstatus, nperms )
  {
    stats = MBstat(ccdata,ccstatus)
    perms = MB_perm( ccdata,ccstatus,nperms )
    return( list("stat.general" = stats$general,
                 "stat.recessive" = stats$recessive,
                 "stat.dominant" = stats$dominant,
                 "p.value.general" = length(which(perms$general >= stats$general))/nperms,
                 "p.value.recessive" = length(which(perms$recessive >= stats$recessive))/nperms,
                 "p.value.dominant" = length(which(perms$dominant >= stats$dominant))/nperms,
                 "z.general" = (stats$general - mean(perms$general))/sd(perms$general),
                 "z.recessive" = (stats$recessive - mean(perms$recessive))/sd(perms$recessive),
                 "z.dominant" = (stats$dominant - mean(perms$dominant))/sd(perms$dominant)
                 )
           )
  }

#' Estimate p-values for all burden statistics by permutation
#' @param ccdata A matrix of markers (columns) and individuals (rows).  Data are coded as the number of copies of the minor allele.
#' @param ccstatus A vector of binary phenotype labels.  0 = control, 1 = case.
#' @param nperms Number of permutations to perform
#' @param esm.K.value The number of markers to use in the calculation of ESM_K
#' @param LLc.maf For Li and Leal's statistic, only consider variants whose minor allele frequencies are <= maf
#' @param LLc.maf.controls  For Li and Leal's statistic, calculate MAF from controls only if TRUE, otherwise from entire sample
#' @param calpha.simple.counts see Details
#' @return A list of (one-tailed) p-values and Z-scores for all burden statistics.
#' @references Li, B., & Leal, S. (2008). Methods for detecting associations with rare variants for common diseases: application to analysis of sequence data. The American Journal of Human Genetics, 83(3), 311-321.
#' @references Neale, B. M., Rivas, M. A., Voight, B. F., Altshuler, D., Devlin, B., Orho-Melander, M., et al. (2011). Testing for an Unusual Distribution of Rare Variants. PLoS Genetics, 7(3), e1001322. doi:10.1371/journal.pgen.1001322
#' @references Madsen, B. E., & Browning, S. R. (2009). A groupwise association test for rare mutations using a weighted sum statistic. PLoS Genetics, 5(2), e1000384. doi:10.1371/journal.pgen.1000384
#' @references Thornton, K. R., Foran, A. J., & Long, A. D. (2013). Properties and Modeling of GWAS when Complex Disease Risk Is Due to Non-Complementing, Deleterious Mutations in Genes of Large Effect. PLoS Genetics, 9(2), e1003258. doi:10.1371/journal.pgen.1003258
#' @details  When calpha.simple.counts = FALSE, heterozygous and homozygous genotypes are treated as different numbers of observations
#' of the mutation.  In other wordes, simplecounts = FALSE is equivalent to colSums( ccdata[status==1,] ).  When simplecounts=TRUE,
#' all nonzero genotype values are treated as the value 1, equivalent to  apply(data[status==1,], 2, function(x) sum(x>0, na.rm=TRUE)).
#' The latter method is used by the R package AssotesteR.
#' @examples
#' data(rec.ccdata)
#' rec.ccdata.status = c( rep(0,rec.ccdata$ncontrols),rep(1,rec.ccdata$ncases))
#' #Filter sites: 0 <= MAF in cases < 0.05 && r^2 between pairs < 0.8
#' keep = filter_sites(rec.ccdata$genos,rec.ccdata.status,0,5e-2,0.8)
#' all.p = allBurdenStats.p.perm(rec.ccdata$genos[,which(keep==1)],rec.ccdata.status,10,50,5e-2)
allBurdenStats.p.perm = function( ccdata, ccstatus, nperms, esm.K.value, LLc.maf,LLc.maf.controls = TRUE ,calpha.simple.counts = FALSE )
  {
    stats = allBurdenStats(ccdata,ccstatus,esm.K.value,LLc.maf,LLc.maf.controls,simplecount_calpha = calpha.simple.counts)
    perms = allBurdenStatsPerm(ccdata,ccstatus,nperms,esm.K.value,LLc.maf,LLc.maf.controls,simplecount_calpha = calpha.simple.counts)
    rv = list(esm.p.value = length(which(perms$esm.permdist >= stats$esm.stat))/nperms,
      esm.z.value = ( stats$esm.stat - mean(perms$esm.permdist) )/sd(perms$esm.permdist),
      calpha.p.value = length(which(perms$calpha.permdist >= stats$calpha.stat))/nperms,
      calpha.z.value = ( stats$calpha.stat - mean(perms$calpha.permdist) )/sd(perms$calpha.permdist),
      MB.general.p.value = length(which(perms$MB.general.permdist >= stats$MB.general.stat))/nperms,
      MB.general.z.value = ( stats$MB.general.stat - mean(perms$MB.general.permdist) )/sd(perms$MB.general.permdist),
      MB.recessive.p.value = length(which(perms$MB.recessive.permdist >= stats$MB.recessive.stat))/nperms,
      MB.recessive.z.value = ( stats$MB.recessive.stat - mean(perms$MB.recessive.permdist) )/sd(perms$MB.recessive.permdist),
      MB.dominant.p.value = length(which(perms$MB.dominant.permdist >= stats$MB.dominant.stat))/nperms,
      MB.dominant.z.value = ( stats$MB.dominant.stat - mean(perms$MB.dominant.permdist) )/sd(perms$MB.dominant.permdist),
      LL.collapse.p.value = length(which(perms$LL.collapse.permdist >= stats$LL.collapse.stat))/nperms,
      LL.collapse.z.value = ( stats$LL.collapse.stat - mean(perms$LL.collapse.permdist) )/sd(perms$LL.collapse.permdist))
    
    return(rv)
  }
