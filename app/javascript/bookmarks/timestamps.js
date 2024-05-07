function jumpToStartTime (i) {
  let timestamp = document.getElementById(`timestamp-${i}`);
  if (timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('bookmark-video');
    video.innerHTML = `<iframe src="https://www.youtube.com/embed/${gon.video_id}?start=${gon.start_time_list[i]}" class="youtube-video-player" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>`;
    });
  }
}

document.addEventListener('turbo:render', function() {
  for (let i = 0; i <= 9; i++) {
    jumpToStartTime(i);
  }
});

document.addEventListener('turbo:load', function() {
  for (let i = 0; i <= 9; i++) {
    jumpToStartTime(i);
  }
});

document.addEventListener('turbo:frame-render', function() {
  for (let i = 0; i <= 9; i++) {
    jumpToStartTime(i);
  }
});
