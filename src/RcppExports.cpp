// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// chisq_per_marker
NumericVector chisq_per_marker(const IntegerMatrix& ccdata, const IntegerVector& ccstatus);
RcppExport SEXP buRden_chisq_per_marker(SEXP ccdataSEXP, SEXP ccstatusSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< const IntegerMatrix& >::type ccdata(ccdataSEXP );
        Rcpp::traits::input_parameter< const IntegerVector& >::type ccstatus(ccstatusSEXP );
        NumericVector __result = chisq_per_marker(ccdata, ccstatus);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// esm_perm_binary
NumericVector esm_perm_binary(const IntegerMatrix& ccdata, const IntegerVector& ccstatus, const unsigned& nperms, const unsigned& k);
RcppExport SEXP buRden_esm_perm_binary(SEXP ccdataSEXP, SEXP ccstatusSEXP, SEXP npermsSEXP, SEXP kSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< const IntegerMatrix& >::type ccdata(ccdataSEXP );
        Rcpp::traits::input_parameter< const IntegerVector& >::type ccstatus(ccstatusSEXP );
        Rcpp::traits::input_parameter< const unsigned& >::type nperms(npermsSEXP );
        Rcpp::traits::input_parameter< const unsigned& >::type k(kSEXP );
        NumericVector __result = esm_perm_binary(ccdata, ccstatus, nperms, k);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// esm
double esm(const NumericVector& scores, const unsigned& K);
RcppExport SEXP buRden_esm(SEXP scoresSEXP, SEXP KSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< const NumericVector& >::type scores(scoresSEXP );
        Rcpp::traits::input_parameter< const unsigned& >::type K(KSEXP );
        double __result = esm(scores, K);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// filter_sites
Rcpp::IntegerVector filter_sites(const Rcpp::IntegerMatrix& ccdata, const Rcpp::IntegerVector& ccstatus, const double& minfreq, const double& maxfreq, const double& rsq_cutoff);
RcppExport SEXP buRden_filter_sites(SEXP ccdataSEXP, SEXP ccstatusSEXP, SEXP minfreqSEXP, SEXP maxfreqSEXP, SEXP rsq_cutoffSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< const Rcpp::IntegerMatrix& >::type ccdata(ccdataSEXP );
        Rcpp::traits::input_parameter< const Rcpp::IntegerVector& >::type ccstatus(ccstatusSEXP );
        Rcpp::traits::input_parameter< const double& >::type minfreq(minfreqSEXP );
        Rcpp::traits::input_parameter< const double& >::type maxfreq(maxfreqSEXP );
        Rcpp::traits::input_parameter< const double& >::type rsq_cutoff(rsq_cutoffSEXP );
        Rcpp::IntegerVector __result = filter_sites(ccdata, ccstatus, minfreq, maxfreq, rsq_cutoff);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// ProductMoment
std::iterator_traits<NumericVector::const_iterator>::value_type ProductMoment(const NumericVector& x, const NumericVector& y);
RcppExport SEXP buRden_ProductMoment(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< const NumericVector& >::type x(xSEXP );
        Rcpp::traits::input_parameter< const NumericVector& >::type y(ySEXP );
        std::iterator_traits<NumericVector::const_iterator>::value_type __result = ProductMoment(x, y);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
