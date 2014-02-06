
#include <Rcpp.h>
#include <iostream>
#include <fstream>
#include <sstream>

using namespace Rcpp;
using namespace std;

string itos(int i) // convert int to string
{
    stringstream s;
    s << i;
    return s.str();
}



// [[Rcpp::export]]
std::string cppReadFile(std::string xmlFile){

  std::string buf;
  std::string xml;
  ifstream file;
  file.open(xmlFile.c_str());

  std::vector<std::string> tokens;
  while (file >> buf)
    xml += buf + ' ';
    
  return xml;
}



// [[Rcpp::export]]
SEXP getVals(CharacterVector x){

  size_t n = x.size();
  std::string xml;
  CharacterVector v(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string vtag = "<v>";
  std::string vtagEnd = "</v>";
  
  for(size_t i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(vtag, 0);
    
    if(pos == std::string::npos){
      v[i] = NA_STRING;
    }else{
      
      endPos = xml.find(vtagEnd, pos+3);
      v[i] = xml.substr(pos+3, endPos-pos-3).c_str();
    
    }
    
  }

  return wrap(v) ;  

}

// [[Rcpp::export]]
SEXP getNodes(std::string xml, std::string tagIn){

  if(xml.length() == 0)
    return wrap(NA_STRING);

  xml = " " + xml;
  std::vector<std::string> r;
  size_t pos = 0;
  size_t endPos = 0;
  std::string tag = tagIn;
  std::string tagEnd = tagIn.insert(1,"/");
  
  size_t k = tag.length();
  size_t l = tagEnd.length();

  while(1){
    
    pos = xml.find(tag, pos+1);
    endPos = xml.find(tagEnd, pos+k);
    
    if((pos == std::string::npos) | (endPos == std::string::npos))
      break;
    
    r.push_back(xml.substr(pos, endPos-pos+l).c_str());
    
  }  

  return wrap(r) ;  

}



// [[Rcpp::export]]
SEXP getChildlessNode(std::string xml, std::string tag){

  size_t k = tag.length();
  if(xml.length() == 0)
    return wrap(NA_STRING);
    
  xml = " " + xml;
    
  std::vector<std::string> r;
  size_t pos = 0;
  size_t endPos = 0;
  std::string tagEnd = "/>";

  while(1){
    
    pos = xml.find(tag, pos+1);
    endPos = xml.find(tagEnd, pos+k);
    
    if(pos == std::string::npos)
      break;
    
    r.push_back(xml.substr(pos, endPos-pos+2).c_str());
    
  }

  return wrap(r) ;  

}



// [[Rcpp::export]]
SEXP getAttr(CharacterVector x, std::string tag){

  size_t n = x.size();
  size_t k = tag.length();
  
  if(n == 0)
    return wrap(-1);
  
  std::string xml;
  CharacterVector r(n);
  size_t pos = 0;
  size_t endPos = 0;
  std::string rtagEnd = "\"";

  for(size_t i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(tag, 0);
    
    if(pos == std::string::npos){
      r[i] = NA_STRING;
    }else{  
      endPos = xml.find(rtagEnd, pos+k);
      r[i] = xml.substr(pos+k, endPos-pos-k).c_str();
    }
  }

  return wrap(r) ;  

}



// [[Rcpp::export]]
SEXP childrenCounter(CharacterVector x){

  size_t n = x.size();
  if(n == 0)
    return wrap(0);
  
  std::string xml;
  IntegerVector nChildren(n);
  size_t pos = 0;
  std::string tag = "<c ";
  
  for(size_t i = 0; i < n; i++){ 
    
    xml = x[i];
    nChildren[i] = 0;
    pos = xml.find(tag, 0);
    
    while(pos != std::string::npos){
      nChildren[i]++;
      pos = xml.find(tag, pos+1);
    }
    
  }

  return wrap(nChildren) ;  

}


// [[Rcpp::export]]
SEXP getCellStyles(CharacterVector x){

  size_t n = x.size();
  
  if(n == 0){
    CharacterVector ret(1);
    ret[0] = NA_STRING;
    return wrap(ret);
  }
    
  
  std::string xml;
  CharacterVector t(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string rtag = " s=";
  std::string rtagEnd = "\"";

  for(size_t i = 0; i < n; i++){ 
    
    xml = x[i];
    pos = xml.find(rtag, 1);
    
    if(pos == std::string::npos){
      t[i] = "n";
    }else{
      endPos = xml.find(rtagEnd, pos+4);
      t[i] = xml.substr(pos+4, endPos-pos-4).c_str();
    }
  }

  return wrap(t) ;  

}


// [[Rcpp::export]]
SEXP getCellTypes(CharacterVector x){

  int n = x.size();
  
  if(n == 0)
    return wrap(-1);
  
  std::string xml;
  CharacterVector t(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string rtag = " t=";
  std::string rtagEnd = "\"";

  for(int i = 0; i < n; i++){ 
    
    xml = x[i];
    pos = xml.find(rtag, 1);
    
    if(pos == std::string::npos){
      t[i] = "n";
    }else{
      endPos = xml.find(rtagEnd, pos+4);
      t[i] = xml.substr(pos+4, endPos-pos-4).c_str();
    }
  }

  return wrap(t) ;  

}


// [[Rcpp::export]]
SEXP getCells(CharacterVector x){

  int n = x.size();
  
  if(n == 0)
    return wrap(-1);
  
  std::string xml;
  CharacterVector r(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string tag = "<c ";
  std::string tagEnd = "</c>";
  std::string tagEnd2 = "/>";

  for(int i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(tag, 0);
    endPos = xml.find(tagEnd, pos+3);

    if(endPos == std::string::npos)
      endPos = xml.find(tagEnd2, pos+3);
        
    r[i] = xml.substr(pos+3, endPos-pos-3).c_str();
    
  }

  return wrap(r) ;  

}


// [[Rcpp::export]]
SEXP getFunction(CharacterVector x){

  int n = x.size();
  
  if(n == 0)
    return wrap(-1);
  
  std::string xml;
  CharacterVector r(n);
  size_t pos = 0;
  size_t endPos = 0;
  
  std::string tag = "<f";
  std::string tagEnd1 = "</f>";
  std::string tagEnd2 = "/>";

  for(int i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(tag, 0);
    
    if(pos == std::string::npos){
      r[i] = NA_STRING;
    }else{
      
      endPos = xml.find(tagEnd1, pos+3);
      if(endPos == std::string::npos){
        endPos = xml.find(tagEnd2, pos+3);
        r[i] = xml.substr(pos, endPos-pos+2).c_str();
      }else{
        r[i] = xml.substr(pos, endPos-pos+4).c_str();
      }
        
    }
  }

  return wrap(r) ;  

}


// [[Rcpp::export]]
SEXP getRefs(CharacterVector x){

  int n = x.size();
  
  if(n == 0)
    return wrap(-1);
  
  std::string xml;
  CharacterVector r(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string rtag = "r=";
  std::string rtagEnd = "\"";

  for(int i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(rtag, 0);
    endPos = xml.find(rtagEnd, pos+3);
    r[i] = xml.substr(pos+3, endPos-pos-3).c_str();
    
  }

  return wrap(r) ;  

}



// [[Rcpp::export]]
SEXP getRefsVals(CharacterVector x, int startRow){

  int n = x.size();
  std::string xml;
  CharacterVector r(n);
  CharacterVector v(n);
  size_t pos = 0;
  size_t endPos = 0;

  std::string rtag = "r=";
  std::string rtagEnd = "\"";

  std::string vtag = "<v>";
  std::string vtagEnd = "</v>";
  
  if(startRow == 1){
    for(int i = 0; i < n; i++){ 
      
      // find opening tag     
      xml = x[i];
      pos = xml.find(rtag, 0);
      endPos = xml.find(rtagEnd, pos+3);
      r[i] = xml.substr(pos+3, endPos-pos-3).c_str();
      
      pos = xml.find(vtag, endPos+1);
      endPos = xml.find(vtagEnd, pos+3);
      v[i] = xml.substr(pos+3, endPos-pos-3).c_str();
      
    }
    
  }else{
    // if a startRow is specified
    // loop throught v, if row is less than startRow, remove from r and v
    int rowN;
    std::string row;
    bool below = true;
  
    for(int i = 0; i < n; i++){
      
      // find opening tag     
      xml = x[i];
      pos = xml.find(rtag, 0);
      endPos = xml.find(rtagEnd, pos+3);
      r[i] = xml.substr(pos+3, endPos-pos-3).c_str();

      if(below){
        row = r[i];
        // remove digits from string
        row.erase(std::remove_if(row.begin(), row.end(), ::isalpha), row.end());
        rowN = atoi(row.c_str());
            
        if(rowN < startRow){
          r[i] = NA_STRING;
          v[i] = NA_STRING;
          
        }else{
          below = false;
          pos = xml.find(vtag, endPos+1);
          endPos = xml.find(vtagEnd, pos+3);
          v[i] = xml.substr(pos+3, endPos-pos-3).c_str();
        }
        
      }else{
        pos = xml.find(vtag, endPos+1);
        endPos = xml.find(vtagEnd, pos+3);
        v[i] = xml.substr(pos+3, endPos-pos-3).c_str();        
      }
      
    } // end of loop
    
    v = na_omit(v);
    r = na_omit(r);
    
  } // end of else
  


  List res(2);
  res[0] = r;
  res[1] = v;

  return wrap(res) ;  

}




// [[Rcpp::export]]
CharacterVector getSharedStrings(CharacterVector x){

  int n = x.size();
  std::string xml;
  
  size_t pos = 0;
  size_t endPos = 0;

  std::string ttag = "<t";
  std::string tag = ">";
  std::string tagEnd = "<";

  CharacterVector s(n);
  for(int i = 0; i < n; i++){ 
    
    // find opening tag     
    xml = x[i];
    pos = xml.find(ttag, 0);
    if(pos != std::string::npos){
      pos = xml.find(tag, pos+1);
      endPos = xml.find(tagEnd, pos+2);
      s[i] = xml.substr(pos+1, endPos-pos - 1).c_str();
    }else{
      s[i] = NA_STRING;
    }
  }


//  s = na_omit(s);
  return wrap(s) ;  

}


// [[Rcpp::export]]
List getNumValues(CharacterVector inFile, int n, std::string tagIn) {
  
  std::string xmlFile = as<std::string>(inFile);
  std::string buf;
  std::string xml;
  ifstream file;
  file.open(xmlFile.c_str());

  std::vector<std::string> tokens;
  while (file >> buf)
    xml += buf;
    
  std::string tag = tagIn;
  std::string tagEnd = tagIn.insert(1,"/");
  
  size_t pos = 0;
  size_t endPos = 0;
  CharacterVector vc(n);
  NumericVector vn(n);
  
  for(int i = 0; i < n; i++){ 
    // find opening tag 
    pos = xml.find(tag, endPos+1);
    
    if (pos != std::string::npos){
      endPos = xml.find(tagEnd, pos+3);    
      vc[i] = xml.substr(pos+3, endPos-pos-3).c_str();
      vn[i] = atof(vc[i]);
    } 
  }
  
  List res(2);
  res[0] = vn;
  res[1] = vc;
    
  return res;

}




// [[Rcpp::export]]
IntegerVector RcppConvertFromExcelRef( CharacterVector x ){

  std::vector<std::string> r = as<std::vector<std::string> >(x);
  int n = r.size();
  int k;
  
  std::string a;
  IntegerVector colNums(n);
  char A = 'A';
  int aVal = (int)A - 1;
  
  for(int i = 0; i < n; i++){
    a = r[i];
    
    // remove digits from string
    a.erase(std::remove_if(a.begin()+1, a.end(), ::isdigit), a.end());
    
    int sum = 0;
    k = a.length();
    
    for (int j = 0; j < k; j++){
        sum *= 26;
        sum += (a[j] - aVal);
        
    }
    colNums[i] = sum;
  }
  
  return colNums;
  
}



// [[Rcpp::export]]
SEXP writeFile(std::string parent, std::string xmlText, std::string parentEnd, std::string R_fileName) {
  
  const char * s = R_fileName.c_str();
    
  std::ofstream xmlFile;
  xmlFile.open (s);
  xmlFile << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
  xmlFile << parent;
  xmlFile << xmlText;
  xmlFile << parentEnd;
  xmlFile.close();

  return 0;
}



// [[Rcpp::export]]
List buildCellList( CharacterVector r, CharacterVector t, CharacterVector v) {
   
  //Valid combinations
  //  r t v	
  //  T	F	F	
  //  T	T	T
  //  F F	F	
   
  int n = r.size();
  List cells(n);
  LogicalVector hasV = !is_na(v);
  LogicalVector hasR = !is_na(r);

    for(int i=0; i < n; i++){
      
      if(hasR[i]){
      
        if(hasV[i]){
          
          cells[i] = CharacterVector::create(
                          Named("r") = r[i],
                          Named("t") = t[i],
                          Named("s") = NA_STRING,
                          Named("v") = v[i],
                          Named("f") = NA_STRING); 
        }else{
          
          
           cells[i] = CharacterVector::create(
                          Named("r") = r[i],
                          Named("t") = NA_STRING,
                          Named("s") = NA_STRING,
                          Named("v") = NA_STRING,
                          Named("f") = NA_STRING); 
        }
      }else{
        
           cells[i] = CharacterVector::create(
                          Named("r") = NA_STRING,
                          Named("t") = NA_STRING,
                          Named("s") = NA_STRING,
                          Named("v") = NA_STRING,
                          Named("f") = NA_STRING);  
      }
      
    } // end of for loop
    
    return wrap(cells) ;
}


// [[Rcpp::export]]
SEXP buildLoadCellList( CharacterVector r, CharacterVector t, CharacterVector v, CharacterVector f) {
   
   //No cases with r is NA as only take cell with children
   
  //Valid combinations
  //  r t	v	f
  //  T	F	F	F
  //  T	T	T	F done
  //  T	T	T	T done

   
  int n = r.size();
  List cells(n);
  LogicalVector hasV = !is_na(v);
  LogicalVector hasF = !is_na(f);
  
    for(int i=0; i < n; i++){
      
    //If we have a function    
    if(hasF[i]){
      
      cells[i] = CharacterVector::create(
                 Named("r") = r[i],
                 Named("t") = t[i],
                 Named("s") = NA_STRING,
                 Named("v") = v[i],
                 Named("f") = f[i]); 
      
      
      }else if(hasV[i]){
        
      cells[i] = CharacterVector::create(
                 Named("r") = r[i],
                 Named("t") = t[i],
                 Named("s") = NA_STRING,
                 Named("v") = v[i],
                 Named("f") = NA_STRING); 
                      
      }else{ //only have s and r
          cells[i] = CharacterVector::create(
                     Named("r") = r[i],
                     Named("t") = NA_STRING,
                     Named("s") = NA_STRING,
                     Named("v") = NA_STRING,
                     Named("f") = NA_STRING);
      }
    } // end of for loop
    
    return cells ;
}







// [[Rcpp::export]]
SEXP constructCellData(IntegerVector cols, std::vector<std::string> LETTERS, std::vector<std::string> rows, CharacterVector t, CharacterVector v) {
      
   //All cells here will have data in them: valid r, valid t and valid v 
   
  int nCols = cols.size();  
  int nRows = rows.size();
  int n = nCols*nRows;
  
  List cells(n);
  std::vector<std::string> res(n);
  
  int x;
  int modulo;
  for(int i = 0; i < nCols; i++){
    x = cols[i];
    string columnName;
    
    while(x > 0){  
      modulo = (x - 1) % 26;
      columnName = LETTERS[modulo] + columnName;
      x = (x - modulo) / 26;
    }
    res[i] = columnName;
  }
  
  CharacterVector names(n);
  int c = 0;
  for(int i=0; i < nRows; i++){
    for(int j=0; j < nCols; j++){
  
      names[c] = rows[i];
      cells[c] = CharacterVector::create(
                 Named("r") = res[j] + rows[i],
                 Named("t") = t[c],
                 Named("s") = NA_STRING,
                 Named("v") = v[c]);
    c++; 
    }
  }
  
  cells.attr("names") = names;
    
  return cells ;
}




// [[Rcpp::export]]
SEXP buildCellList212121(CharacterVector r, CharacterVector t, CharacterVector v, CharacterVector s) {
   
//  r t	s	v	
//  T	F	T	F	
//  T	T	F	T	
//  T	T	T	T	
 
  int n = r.size();
  List cells(n);
  LogicalVector hasV = is_na(v);
  LogicalVector hasS = is_na(s);
  
    for(int i=0; i < n; i++){
      
      if(hasV[i]){

        if(hasS[i]){
          
          cells[i] = CharacterVector::create(
                     Named("r") = r[i],
                     Named("t") = t[i],
                     Named("s") = s[i],
                     Named("v") = v[i],
                     Named("f") = NA_STRING);
                     
        }else{
          cells[i] = CharacterVector::create(
                     Named("r") = r[i],
                     Named("t") = t[i],
                     Named("s") = NA_STRING,
                     Named("v") = v[i],
                     Named("f") = NA_STRING);
        }
      }else{
        
         cells[i] = CharacterVector::create(
                     Named("r") = r[i],
                     Named("t") = NA_STRING,
                     Named("s") = NA_STRING,
                     Named("v") = NA_STRING,
                     Named("f") = NA_STRING);

      }
    } // end of for loop
    
    return cells ;
}


// [[Rcpp::export]]
SEXP convert2ExcelRef(IntegerVector cols, std::vector<std::string> LETTERS){
  
  int n = cols.size();  
  CharacterVector res(n);
  
  int x;
  int modulo;
  for(int i = 0; i < n; i++){
    x = cols[i];
    string columnName;
    
    while(x > 0){  
      modulo = (x - 1) % 26;
      columnName = LETTERS[modulo] + columnName;
      x = (x - modulo) / 26;
    }
    res[i] = columnName;
  }
  
  return res ;
  
}


// [[Rcpp::export]]
SEXP ExcelConvertExpand(IntegerVector cols, std::vector<std::string> LETTERS, std::vector<std::string> rows){
  
  size_t n = cols.size();  
  size_t nRows = rows.size();
  std::vector<std::string> res(n);
  
  size_t x;
  size_t modulo;
  for(size_t i = 0; i < n; i++){
    x = cols[i];
    string columnName;
    
    while(x > 0){  
      modulo = (x - 1) % 26;
      columnName = LETTERS[modulo] + columnName;
      x = (x - modulo) / 26;
    }
    res[i] = columnName;
  }
  
  CharacterVector r(n*nRows);
  CharacterVector names(n*nRows);
  size_t c = 0;
  for(size_t i=0; i < nRows; i++)
    for(size_t j=0; j < n; j++){
    r[c] = res[j] + rows[i];
    names[c] = rows[i];
    c++;
  }
  
  r.attr("names") = names;
  return wrap(r) ;
  
}


// [[Rcpp::export]]
SEXP buildMatrix1(NumericVector v, IntegerVector rowInd, IntegerVector colInd, CharacterVector colNames, int nRows, int nCols){
  
  int k = v.size();
  NumericMatrix m(nRows, nCols);
  for(int i=0;i < k; i++)
      m(rowInd[i], colInd[i]) = v[i];
          
  List dfList(nCols);
  for(int i=0; i < nCols; ++i)
    dfList[i] = m(_,i);
  
  std::vector<int> rowNames(nRows);
  for(int i = 0;i < nRows; ++i)
    rowNames[i] = i+1;
  
  dfList.attr("names") = colNames;
  dfList.attr("row.names") = rowNames;
  dfList.attr("class") = "data.frame";

  return Rcpp::wrap(dfList);


}


// [[Rcpp::export]]
SEXP buildMatrix2(CharacterVector v, IntegerVector rowInd, IntegerVector colInd, CharacterVector colNames, int nRows, int nCols, IntegerVector charCols){
  
  int k = v.size();
  Rcpp::CharacterMatrix m(nRows, nCols);
  
  for(int i=0;i < k; i++)
    m(rowInd[i], colInd[i]) = v[i];

  List dfList(nCols);
  for(int i=0; i < nCols; i++){
    
    // if i in charCols
    if (std::find(charCols.begin(), charCols.end(), i) != charCols.end()){ 
     
      bool logCol = true;
      for(int ri = 0; ri < nRows; ri++){
        if((m(ri, i) != "TRUE") & (m(ri, i) != "FALSE")){
          logCol = false;
          break;
         }
       }
        
      if(logCol){
      
        LogicalVector logtmp(nRows);
        for(int j=0; j < nRows; ++j)
          logtmp[j] = m(j,i) == "TRUE";
      
        dfList[i] = logtmp;
        
      }else{
           
       CharacterVector tmp(nRows);
        for(int j=0; j < nRows; ++j)
          tmp[j] = m(j,i);
        
        dfList[i] = tmp;
      }

    }else{

      IntegerVector ntmp(nRows);
      for(int j=0; j < nRows; ++j)
        ntmp[j] = atof(m(j,i));   
        
      dfList[i] = ntmp;
        
    }
     
  }
    
  std::vector<int> rowNames(nRows);
  for(int i = 0;i < nRows; ++i)
    rowNames[i] = i+1;
  
  dfList.attr("names") = colNames;
  dfList.attr("row.names") = rowNames;
  dfList.attr("class") = "data.frame";

  return Rcpp::wrap(dfList);

}



// [[Rcpp::export]]
IntegerVector matrixInds(IntegerVector indices) {
    
  IntegerVector uRows = sort_unique(indices);
  
  std::vector<int> vo = as< std::vector<int> > (uRows);
  int k = uRows.size();
        
  for(int i = 0; i < k; i++)
    std::replace(indices.begin(), indices.end(), vo[i], i);
  
  return indices;
  
}


// [[Rcpp::export]]
List buildCellMerges(List comps){
 
  size_t nMerges = comps.size(); 
  List res(nMerges);
  
  for(size_t i =0; i < nMerges; i++){
    IntegerVector col = RcppConvertFromExcelRef(comps[i]);  
    CharacterVector comp = comps[i];
    IntegerVector row(2);  

    for(size_t j = 0; j < 2; j++){
      std::string rt(comp[j]);      
      rt.erase(std::remove_if(rt.begin(), rt.end(), ::isalpha), rt.end());
      row[j] = atoi(rt.c_str());
    }

    size_t ca(col[0]);
    size_t ck = size_t(col[1]) - ca + 1;
    
    std::vector<int> v(ck) ;
    for(size_t j = 0; j < ck; j++)
      v[j] = j + ca;

    size_t ra(row[0]);

    size_t rk = int(row[1]) - ra + 1;
    std::vector<int> r(rk) ;
    for(size_t j = 0; j < rk; j++)
      r[j] = j + ra;

    CharacterVector M(ck*rk);
    int ind = 0;
    for(size_t j = 0; j < ck; j++){
      for(size_t k = 0; k < rk; k++){
        char name[30];
        sprintf(&(name[0]), "%d-%d", r[k], v[j]);
        M(ind) = name;
        ind++;
      }
    }
      
    res[i] = M;
  }
               
   return wrap(res) ;

}


// [[Rcpp::export]]
SEXP readWorkbook(CharacterVector v, NumericVector vn, IntegerVector stringInds, CharacterVector r, CharacterVector tR, int nRows, bool hasColNames){
    
  int nCells = r.size();
  IntegerVector colNumbers = RcppConvertFromExcelRef(r);
  int minCol = *std::min_element(colNumbers.begin(), colNumbers.end()); 
  colNumbers = matrixInds(colNumbers);
  int nCols = *std::max_element(colNumbers.begin(), colNumbers.end()) + 1;
  int nStringInds = stringInds.size();  
  
  // Check if first row are all strings
  bool colNamesExist = false;
  if((nCols <= nStringInds) & hasColNames){
    if(nCols == stringInds[nCols-1] + 1)
      colNamesExist = true;
  }
  
  StringVector colNames(nCols);
  if(colNamesExist){
    
    for(int i = 0; i < nCols; i++)
      colNames[i] = v[i];
    
    tR.erase(tR.begin(), tR.begin()+nCols);
    r.erase(r.begin(), r.begin()+nCols);
    --nRows;
    nCells = nCells - nCols;
    
  }else{
    for(int i =0; i < nCols; i++){
      char name[6];
      sprintf(&(name[0]), "X%d", i+1);
      colNames[i] = name;
    }
  }
  
  bool allNumeric = false;
  
  if((tR.size() == 0) | (stringInds[0] == -1)) //If the new resized tR is length 0 there are no more strings
    allNumeric = true;
  
  // getRow numbers from r 
  IntegerVector rowNumbers(nCells);  
  if(nCells == nRows*nCols){
    int count = 0;
    for(int i = 0; i < nRows; i++){
      for(int j = 0; j < nCols; j++){
        rowNumbers[count] = i;
        count++;
      }
    }
    
  }else{
    
    std::vector<std::string> rs = as<std::vector<std::string> >(r);
    for(int i = 0; i < nCells; i++){
      std::string a = rs[i];
      a.erase(std::remove_if(a.begin(), a.end(), ::isalpha), a.end());
      rowNumbers[i] = atoi(a.c_str()) - 1; 
    }
    rowNumbers = matrixInds(rowNumbers);
  }
  
  IntegerVector uRows = unique(rowNumbers);  
  
  SEXP m;
  if(allNumeric){
    
    if(colNamesExist){
      vn.erase(vn.begin(), vn.begin()+nCols);
      colNumbers.erase(colNumbers.begin(), colNumbers.begin()+nCols); 
    }
    
    m = buildMatrix1(vn, rowNumbers, colNumbers, colNames, nRows, nCols);
    
  }else{
    
    if(colNamesExist){
      v.erase(v.begin(), v.begin()+nCols);
      colNumbers.erase(colNumbers.begin(), colNumbers.begin()+nCols); 
    }
    
    IntegerVector charCols = RcppConvertFromExcelRef(tR);
    charCols = unique(charCols);
    
    int nCharCols = charCols.size();
    for(int i=0; i < nCharCols; i++)
      charCols[i] = charCols[i] - minCol;
    
    m = buildMatrix2(v, rowNumbers, colNumbers, colNames, nRows, nCols, charCols);
    
  }
    
  return wrap(m) ;
  
}







// [[Rcpp::export]]
SEXP quickBuildCellXML(std::string prior, std::string post, List sheetData, IntegerVector rowNumbers, std::string R_fileName){

  // open file and write header XML
  const char * s = R_fileName.c_str();
  std::ofstream xmlFile;
  xmlFile.open (s);
  xmlFile << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
  
  // If no data write childless node and return
  if(sheetData.size() == 0){
    xmlFile << prior;
    xmlFile << "<sheetData/>";
    xmlFile << post;
    xmlFile.close();
    return Rcpp::wrap(1);
  }
  
  // write xml prior to stringData and opening tag
  xmlFile << prior;
  xmlFile << "<sheetData>";

  
  //NOTES ON WHY THIS WORKS
  //If no row heights every row has children
  //If data only added once, sheetData will be in order
  // Thus all rows have children (all starting row tags are open) and no need to sort/find
  
  CharacterVector temp = sheetData.attr("names");    
  std::vector<std::string> rows = as<std::vector<std::string> >(temp);
    
  CharacterVector temp2(sort_unique(rowNumbers));
  std::vector<std::string> uniqueRows = as<std::vector<std::string> >(temp2);
  
  size_t n = temp.size();
  size_t k = uniqueRows.size();
  std::string xml;
  
  size_t j=0;
  string currentRow = uniqueRows[0];
  
  for(size_t i=0;i<k;i++){
    
    std::string r(uniqueRows[i]);
    std::string cellXML;
    std::vector<std::string> cVal;
        
    while(currentRow == r){
      
      CharacterVector cValtmp(sheetData[j]);
      LogicalVector attrs = !is_na(cValtmp);
      cVal = as<std::vector<std::string> >(cValtmp);
          
      // cVal[0] is r    
      // cVal[1] is t        
      // cVal[2] is s    
      // cVal[3] is v    
      // cVal[4] is f    
      
      //cell XML strings
      cellXML += "<c r=\"" + cVal[0];
      
      if(attrs[2])
        cellXML += "\" s=\"" + cVal[2];
    
      //If we have a t value we must have a v value
      if(attrs[1]){
          //If we have a c value we might have an f value
        if(attrs[4]){
          cellXML += "\" t=\"" + cVal[1] + "\">" + cVal[4] + "<v>" + cVal[3] + "</v></c>";
        }else{
          cellXML += "\" t=\"" + cVal[1] + "\"><v>" + cVal[3] + "</v></c>";
        }
        
      }else{
        cellXML += "\"/>";
      }
      
      j += 1;
      
      if(j == n)
        break;
      
      currentRow = rows[j];
    }
    
    xmlFile << "<row r=\"" + r + "\">" + cellXML + "</row>";

  }
    
  // write closing tag and XML post sheetData
  xmlFile << "</sheetData>";
  xmlFile << post;
  
  //close file
  xmlFile.close();

  return Rcpp::wrap(1);

}





// [[Rcpp::export]]
CharacterVector buildCellXML(std::string prior, std::string post, List sheetData, List rowHeights, Function order, std::string R_fileName){

  // output file
  const char * s = R_fileName.c_str();
  size_t n = sheetData.size() ;
  
  std::ofstream xmlFile;
  xmlFile.open (s);
  xmlFile << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
  
  if(n == 0){
    xmlFile << prior;
    xmlFile << "<sheetData/>";
    xmlFile << post;
    xmlFile.close();
    return Rcpp::wrap(1);
  }
  
  
  xmlFile << prior;
  xmlFile << "<sheetData>";

  CharacterVector colNamesTemp = sheetData.attr("names");
  CharacterVector cellsRowNames = unique(colNamesTemp) ;
  size_t k = cellsRowNames.size();
  
  // get row heights and names
  size_t h = rowHeights.size();
  
  IntegerVector numRowHeightNames(h);
  CharacterVector heights(h);
  
  if(h > 0){
    CharacterVector rowHeightNames = rowHeights.attr("names");
    for(size_t i = 0; i < h; i++){
      numRowHeightNames[i] = atoi(rowHeightNames[i]);
      heights[i] = as<std::string>(rowHeights[i]);
    }
  }
  
  // Convert row names to integer and sort
  IntegerVector rows(k) ;
  for(size_t i = 0; i < k; i++){
    rows[i] = atoi(cellsRowNames[i]);
  }
  std::sort(rows.begin(), rows.end());
  CharacterVector charRows(rows);
  
  IntegerVector colNames(n) ;
  CharacterVector cols(n) ; 
  for(size_t i = 0; i < n; i++){
    colNames[i] = atoi(colNamesTemp[i]);
    CharacterVector temp = sheetData[i] ;
    cols[i] = temp[0]; // "r"
  } 

  //loop through ordered row names
  for(size_t i = 0; i < k; i++){ 
    
    int r = rows[i]; // used to subset cells
    CharacterVector cellRef; // required for ordering
    IntegerVector cellInd;
    IntegerVector orderInds;

    for(size_t j = 0; j < n; j++){
      if(colNames[j] == r) {
        cellInd.push_back(j);
        cellRef.push_back(cols[j]);
      }
    }
    
    CharacterVector cValtmp;
    std::vector<std::string> cVal;
    int crSize = cellRef.size();
    
    CharacterVector cValtmp1;
    std::vector<std::string> cVal1;
    
    string cellXML;
    
    orderInds = order(cellRef);
      
    //write row XML
    if(h > 0){  // If any row heights
  
      // look for custom row height
      IntegerVector::iterator it = std::find(numRowHeightNames.begin(), numRowHeightNames.end(), r);
      size_t pos =  std::distance(numRowHeightNames.begin(),it); //returns h if not found
     
      if(pos == h){
        xmlFile << "<row r=\"" + charRows[i] + "\""; 
      }else{
        
        xmlFile << "<row r=\"" + charRows[i] + "\" ht=\"" + heights[pos] + "\" customHeight=\"1\"";
        numRowHeightNames.erase(numRowHeightNames.begin());
        heights.erase(heights.begin());
        h = heights.size();
      }
      
    }else{
      xmlFile << "<row r=\"" + charRows[i] + "\"";
    }
    
    if(crSize == 1){
      
      //cell XML strings
      cValtmp1 = sheetData[cellInd[orderInds[0]]] ;
      LogicalVector attrs1 = !is_na(cValtmp1);
      cVal1 = as<std::vector<std::string> >(cValtmp1);
  
      //If only one child and r is NA (we have no children)
      if(!attrs1[0]){
        xmlFile << "/>";
      }else{
        
        //If r is not NA
        cellXML += "><c r=\"" + cVal1[0];
          
        if (attrs1[2])
          cellXML += "\" s=\"" + cVal1[2];
            
        //If we have a t value we must have a v value
        if(attrs1[1]){
            //If we have a c value we might have an f value
          if(attrs1[4]){
            cellXML += "\" t=\"" + cVal1[1] + "\">" + cVal1[4] + "<v>" + cVal1[3] + "</v></c>";
          }else{
            cellXML += "\" t=\"" + cVal1[1] + "\"><v>" + cVal1[3] + "</v></c>";
          }
          
        }else{
          cellXML += "\"/>";
        }
        
        xmlFile << cellXML + "</row>";
        
      }
      // else crSize > 1
    }else{
      
      xmlFile << ">";
              
      for(int j = 0; j < crSize; j++){
            
        cValtmp = sheetData[cellInd[orderInds[j]]] ;
        LogicalVector attrs = !is_na(cValtmp);
        cVal = as<std::vector<std::string> >(cValtmp);
      
            
        //If r is NA
        cellXML += "<c r=\"" + cVal[0];
          
        if (attrs[2])
          cellXML += "\" s=\"" + cVal[2];
            
        //If we have a t value we must have a v value
        if(attrs[1]){
            //If we have a c value we might have an f value
          if(attrs[4]){
            cellXML += "\" t=\"" + cVal[1] + "\">" + cVal[4] + "<v>" + cVal[3] + "</v></c>";
          }else{
            cellXML += "\" t=\"" + cVal[1] + "\"><v>" + cVal[3] + "</v></c>";
          }
          
        }else{
          cellXML += "\"/>";
        }
      }
      
     xmlFile << cellXML + "</row>";
      
    }
         
  } // end for loop through all cells
  
  xmlFile << "</sheetData>";
  xmlFile << post;
  xmlFile.close();

  return Rcpp::wrap(1);
  
}



// [[Rcpp::export]]
IntegerVector WhichMatch( IntegerVector a, int b ){

  int n = a.size();

  IntegerVector res;
  for(int i =0; i < n; i ++){
    if(a[i] == b)
      res.push_back(i);
  }

  return res ;

}




// [[Rcpp::export]]
CharacterVector getCellsWithChildren(std::string xmlFile){

  //read in file without spaces
  std::string xml = cppReadFile(xmlFile);

  std::vector<std::string> r;
  size_t pos = 0;
  size_t endPos1 = 0;
  size_t endPos2 = 0;
  
  std::string tag = "<c ";
  std::string tagEnd1 = ">";
  std::string tagEnd2 = "</c>";

  size_t k = tag.length();
  size_t l = tagEnd1.length();

  //find "<c""
  //find ">" after "<c"
  //If char before > is / break else look for </c
  
  while(1){
    
    pos = xml.find(tag, pos+2);
    endPos1 = xml.find(tagEnd1, pos+k);
    
    if((pos == std::string::npos) | (endPos1 == std::string::npos))
      break;
    
    if(xml[endPos1-1] != '/'){
      endPos2 = xml.find(tagEnd2, pos+k);
      r.push_back(xml.substr(pos, endPos2-pos+l).c_str());
    }
        
  }  

  return wrap(r) ;  

}




// [[Rcpp::export]]
CharacterVector buildTableXML(std::string id, std::string ref, std::vector<std::string> colNames, bool showColNames, std::string tableStyle){
  
  int n = colNames.size();
  std::string table;
  std::string tableCols;
  std::string tableStyleXML = "<tableStyleInfo name=\"" + tableStyle + "\" showFirstColumn=\"0\" showLastColumn=\"0\" showRowStripes=\"1\" showColumnStripes=\"0\"/>";
    
  table = "<table xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\" id=\"" + id + "\" name=\"Table" + id + "\" displayName=\"Table" + id + "\" ref=\"" + ref + "\"";
  
  
  //if colnames are null
  if(!showColNames){
    table += " headerRowCount=\"0\" totalsRowShown=\"0\">";
  }else{
      table += " totalsRowShown=\"0\"><autoFilter ref=\"" + ref + "\"/>";
  }
    

      
  for(int i = 0; i < n; i ++){
    tableCols += "<tableColumn id=\"" + itos(i+1) + "\" name=\"" + colNames[i] + "\"/>";
  }
  
  tableCols = "<tableColumns count=\"" + itos(n) + "\">" + tableCols + "</tableColumns>"; 
   
  table = table + tableCols + tableStyleXML + "</table>";
  
  
  return wrap(table);
  
}
    
    
    
// [[Rcpp::export]]   
List uniqueCellAppend(List sheetData, CharacterVector r, List newCells){
  
  int n = sheetData.size();
  int cn = newCells.size();
  
  // get all r values
  CharacterVector exCells(n);
  CharacterVector tmp;
  for(int i =0; i < n; i ++){
    tmp = sheetData[i];
    exCells[i] = tmp[0];
  }
  
  // find which exCells we keep
  IntegerVector overwrite = match(exCells, r);
  LogicalVector toKeep = is_na(overwrite);
  int k = sum(toKeep);
  
  //If no cells to keep
  if(k == 0){
    newCells.attr("overwrite") = true;
    return wrap(newCells); 
  }
  
  //If keeping all cells (no cells to be overwritten)
  List newSheetData(k + cn);
  CharacterVector exNames = sheetData.attr("names");
  CharacterVector newCellNames = newCells.attr("names");
  CharacterVector newNames(k + cn);
  
  // create new List of toKeep + newCells
  int j = 0;
  for(int i = 0; i < n; i ++){
  
    if(toKeep[i]){
      newSheetData[j] = sheetData[i];
      newNames[j] = exNames[i];
      j++;
    }
  
    if(j == k)
      break;
  }
  
  for(int i = 0; i < cn; i++){
    newSheetData[j] = newCells[i];
    newNames[j] = newCellNames[i];
    j++;
  }
  
  newSheetData.attr("names") = newNames;
  if(k < n){
    newSheetData.attr("overwrite") = true;
  }else{
    newSheetData.attr("overwrite") = false;
  }
  
  return wrap(newSheetData) ;
  
}



// [[Rcpp::export]]   
List writeCellStyles(List sheetData, CharacterVector rows, IntegerVector cols, String styleId, std::vector<std::string> LETTERS){
  

  int nStyleCells = rows.size();
  int n = sheetData.size();

  // cell names
  CharacterVector exCellNames = sheetData.attr("names");
  //new cell names will be elements of rows where styleCell doesn't exist  
  
  
  // create cellRefs from rows & cols
  CharacterVector styleCells(nStyleCells);
  CharacterVector colNames = convert2ExcelRef(cols, LETTERS);

  std::string r;
  std::string c;

  for(int i =0; i < nStyleCells; i++){
    r = rows[i];
    c = colNames[i];
    styleCells[i] = c + r; 
  }
  
  // get refs of existing cells
  CharacterVector exCells(n);
  CharacterVector tmp;
  for(int i =0; i < n; i++){
    tmp = sheetData[i];
    exCells[i] = tmp[0];
  }
  

  // get all existing cells that need to be styled with this ID
  IntegerVector exPos = match(exCells, styleCells);
  LogicalVector toApply = !is_na(exPos);
  
  IntegerVector stylePos = match(styleCells, exCells);
  LogicalVector isNewCell = is_na(stylePos);
  int nNewCells = sum(isNewCell); 
  
  //List for new sheetData
  List newSheetData(n + nNewCells);
  CharacterVector newSheetDataNames(n + nNewCells);
  
  for(int i = 0; i < n; i++){
    if(toApply[i]){
      tmp = sheetData[i];
      tmp[2] = styleId;
      newSheetData[i] = tmp;
    }else{
      newSheetData[i] = sheetData[i];
    }
    newSheetDataNames[i] = exCellNames[i];
  }
  
  int j = n;
  // append new cells with styleId
  for(int i = 0; i < nStyleCells; i++){
  
    if(isNewCell[i]){
      newSheetData[j] = CharacterVector::create(
                        Named("r") = styleCells[i],
                        Named("t") = NA_STRING,
                        Named("s") = styleId,
                        Named("v") = NA_STRING,
                        Named("f") = NA_STRING);
    
      newSheetDataNames[j] = rows[i];
      j++;
    }
  
  }

  newSheetData.attr("names") = newSheetDataNames;
  
  return wrap(newSheetData);

}
