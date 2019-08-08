function trimString() {
  var list = document.getElementsByClassName("form-control");
  list[0].value = list[0].value.replace (/(^\s*)|(\s*$)/gi, "").replace (/[ ]{2,}/gi," ").replace (/\n +/,"\n");
  list[1].value = list[1].value.replace (/(^\s*)|(\s*$)/gi, "").replace (/[ ]{2,}/gi," ").replace (/\n +/,"\n");
  list[2].value = list[2].value.replace (/(^\s*)|(\s*$)/gi, "").replace (/[ ]{2,}/gi," ").replace (/\n +/,"\n");
  return;
};
