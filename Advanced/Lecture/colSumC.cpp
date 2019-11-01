#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
NumericVector colSumC(NumericMatrix z){
  int nrow =z.nrow();
  int ncol =z.ncol();
  // int nrow=z.nrow(), ncol=z.ncol();
  NumericVector out(ncol);
  
  for (int j=0; j < ncol; j++){
    double total = 0;
    for(int i =0; i<nrow; i++){
      total +=z(i,j);
    }
    out[j]=total;
  }
  
  return out;
}




