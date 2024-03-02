let timestamp = document.getElementById('timestamp');
timestamp.addEventListener('click', function(){
  let video = document.getElementById('bookmark-video');
  video.innerHTML = `<iframe width="560" height="315" src="https://www.youtube.com/embed/${gon.video_id}?start=60" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>`
})
