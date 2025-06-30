function maybeHideSidebar() {
    const path = window.location.pathname;
    const primary = document.querySelector('.md-sidebar--primary');
    const secondary = document.querySelector('.md-sidebar--secondary');
  
    if ((path === '/' || path === '/index.html') && secondary) {
      secondary.style.display = 'none';
      if (primary) primary.style.display = 'none';  // remove this line if you only want to hide the right (secondary) sidebar
    } else {
      if (secondary) secondary.style.display = '';
      if (primary) primary.style.display = '';
    }
  }
  
  document.addEventListener('DOMContentLoaded', maybeHideSidebar);
  if (window.document$) document$.subscribe(maybeHideSidebar);
  