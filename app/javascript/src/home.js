// var tlRocket = new TimelineMax({onUpdate:updatePercentage});
var tlRocket = new TimelineMax();
const controller = new ScrollMagic.Controller();

function updatePercentage() {
  // percent.innerHTML = (tlRocket.progress() *100 ).toFixed();
  tlRocket.progress();
  // console.log(tlRocket.progress());
}

tlRocket.from("#rocket", 1, {
    ease: Elastic.easeOut,
    opacity: 1, scale: 1
  }
);
tlRocket.to("#rocket", 1, {
    ease: Elastic.easeOut,
    scale: 2,
  }
);

const sceneRocket = new ScrollMagic.Scene({
  triggerElement: "#subRocket"
})
  .setTween(tlRocket)
  .addTo(controller);
