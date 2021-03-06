#include <stat_base.hpp>
#include <stat_cAlpha.hpp>
#include <stat_chisq.hpp>
#include <stat_MadsenBrowning.hpp>
#include <stat_LiLeal.hpp>

class stat_allstats : public stat_base
{
private:
  stat_chisq __chisq;
  stat_cAlpha __calpha;
  stat_MadsenBrowning __MB;
  stat_LLcollapse __LLc;
  unsigned esmK;
public:
  stat_allstats( const unsigned & nrows,
		 const Rcpp::IntegerVector & ccstatus,
		 const unsigned & esm_k_value,
		 const double & LLc_maf,
		 const bool & LLc_maf_control = true,
		 const bool & normalize_calpha = false,
		 const bool & simplecounts_calpha = false);
  void update();
  void operator()(const int & genotype,
	     const int & ccstatus);
  Rcpp::List values();
};
