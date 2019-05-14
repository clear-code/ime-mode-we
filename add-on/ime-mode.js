var focusedContext = null;

function setIMEMode(mode) {
  browser.runtime.sendMessage({"ime-mode": mode});
};

function focusCallback(event) {
  let target = event.target;
  if (focusedContext == target)
    return;
  focusedContext = target;
  let style = window.getComputedStyle(target);
  let mode = style.getPropertyValue("ime-mode");
  setIMEMode(mode);
};

function setFocusCallback(target) {
  if (target.tagName == "INPUT" || target.tagName == "TEXTAREA")
    target.addEventListener('focus', focusCallback);
  let elements = target.querySelectorAll('input, textarea');
  elements.forEach(element => {
    element.addEventListener('focus', focusCallback);
  });
};

const observer = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    mutation.addedNodes.forEach(node => {
      setFocusCallback(node);
    });
  });
});

setFocusCallback(document);
observer.observe(document.body, { childList: true, subtree: true });
