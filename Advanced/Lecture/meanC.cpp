#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double meanC(NumericVector x){
  int n = x.size();
  double total=0;
  
  for(int i =0;i<n;++i){
    total +=x[i];//total=total+x[i];
  }//index also need to tell class
  return total/n;
}



