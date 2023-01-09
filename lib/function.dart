
int getIntOfString(dynamic data){
  if(data.runtimeType==0.runtimeType){
    return data;
  }else{
    return int.parse(data);
  }
}