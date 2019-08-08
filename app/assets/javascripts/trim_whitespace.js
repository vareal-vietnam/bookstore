function trimString(i) {
  var list = document.getElementsByClassName("form-control");
  list[i].value = list[i].value.replace (/(^\s*)|(\s*$)/gi, "").replace (/\n +/,"\n");
  return;
};
