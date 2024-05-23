function jumpToIntroduction0() {
  let timestamp = document.getElementById('firstview-button0');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/Tkr-itfalqw?start=9&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction1() {
  let timestamp = document.getElementById('firstview-button1');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/Tkr-itfalqw?start=34&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction2() {
  let timestamp = document.getElementById('firstview-button2');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe src="https://www.youtube.com/embed/Tkr-itfalqw?start=57&autoplay=1" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

document.addEventListener('turbo:load', function() {
    jumpToIntroduction0();
    jumpToIntroduction1();
    jumpToIntroduction2();
  });
