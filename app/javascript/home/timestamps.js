function jumpToIntroduction0() {
  let timestamp = document.getElementById('firstview-button0');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe width="560" height="315" src="https://www.youtube.com/embed/Tkr-itfalqw?start=8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction1() {
  let timestamp = document.getElementById('firstview-button1');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe width="560" height="315" src="https://www.youtube.com/embed/Tkr-itfalqw?start=32" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

function jumpToIntroduction2() {
  let timestamp = document.getElementById('firstview-button2');
  if(timestamp) {
    timestamp.addEventListener('click', function() {
    let video = document.getElementById('firstview-video');
    video.innerHTML = '<iframe width="560" height="315" src="https://www.youtube.com/embed/Tkr-itfalqw?start=55" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
    });
  }
}

document.addEventListener('turbo:load', function() {
    jumpToIntroduction0();
    jumpToIntroduction1();
    jumpToIntroduction2();
  });
