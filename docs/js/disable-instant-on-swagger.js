document.addEventListener("DOMContentLoaded", function () {
    const path = window.location.pathname;
    if (path.includes("swagger")) {
      if (window && window.mutationObserver) {
        delete window.mutationObserver;
        window.location.reload();
      }
    }
  });
  