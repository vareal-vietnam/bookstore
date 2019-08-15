function changeImageOnClick(event) {
  event = event || window.event;
  var targetElement = event.target || event.srcElement;
  if(targetElement.tagName == "IMG") {
    main_image.src = targetElement.getAttribute("src");    
  }
}
