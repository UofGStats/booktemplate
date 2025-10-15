// code-toggle.js

// Global tab switching
function switchAllTabs(lang) {
  document.querySelectorAll(".panel-tabset").forEach(function(tabset){
    tabset.querySelectorAll(".nav-link").forEach(function(link){
      if(link.textContent.trim().toLowerCase() === lang.toLowerCase()){
        link.click();
      }
    });
  });
  
  // Move focus to global button
  const btn = document.querySelector(`#global-toggle button[onclick*="${lang}"]`);
  if (btn) btn.focus();
}

// Keypress support
document.addEventListener("keydown", function(event){
  const key = event.key.toLowerCase();
  if(key === "p") switchAllTabs("python");
  if(key === "r") switchAllTabs("r");
});
