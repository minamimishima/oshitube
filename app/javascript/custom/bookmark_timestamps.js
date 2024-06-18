const jumpToStartTime = (i) => {
  const timestamp = document.getElementById(`timestamp-${i}`);
  if (timestamp) {
    timestamp.addEventListener('click', () => {
    const video = document.getElementById('bookmark-video');
    video.innerHTML = `<iframe src="https://www.youtube.com/embed/${gon.video_id}?start=${gon.start_time_list[i]}&autoplay=1" class="youtube-video-player" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>`;
    });
  }
}

document.addEventListener('turbo:load', () => {
  for (let i = 0; i <= gon.max_index; i++) {
    jumpToStartTime(i);
  }
});

document.addEventListener('turbo:render', () => {
  for (let i = 0; i <= gon.max_index; i++) {
    jumpToStartTime(i);
  }
});

document.addEventListener('turbo:frame-render', () => {
  for (let i = 0; i <= gon.max_index; i++) {
    jumpToStartTime(i);
  }
});
