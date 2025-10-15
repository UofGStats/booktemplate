<script defer>
document.addEventListener("DOMContentLoaded", function() {
  setTimeout(function() {
    document.querySelectorAll('a.quarto-xref').forEach(function(link) {
      if (link._tippy) {
        // Keep hover, but ignore focus
        const originalOnTrigger = link._tippy.props.onTrigger || function() {};
        link._tippy.setProps({
          trigger: 'mouseenter', // only hover triggers
          onTrigger(instance, event) {
            if (event.type === 'focus') return; // do nothing on focus
            originalOnTrigger(instance, event);  // otherwise behave normally
          }
        });
      }
    });
  }, 50);
});



</script>