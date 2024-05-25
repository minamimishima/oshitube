function jumpToIntroduction0() {
  let timestamp = document.getElementById('firstview-button0');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/1FGpM4-K7qE?start=8&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction1() {
  let timestamp = document.getElementById('firstview-button1');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/1FGpM4-K7qE?start=26&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction2() {
  let timestamp = document.getElementById('firstview-button2');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/1FGpM4-K7qE?start=42&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

document.addEventListener('turbo:load', function() {
    jumpToIntroduction0();
    jumpToIntroduction1();
    jumpToIntroduction2();
  });
