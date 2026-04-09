// We use 'capture' phase (true) to catch the event before the website's 
// own scripts can react to it.
window.addEventListener('keydown', function(e) {
  if (e.key === 'Enter' && !e.ctrlKey && !e.altKey && !e.metaKey) {
    // If the event is our own "fake" event, don't intercept it (avoid infinite loop)
    if (e.composedPath().some(el => el.isFakeEvent)) return;

    // Determine the new shift state
    const newShiftState = !e.shiftKey;

    // Stop the original event dead in its tracks
    e.stopImmediatePropagation();
    e.preventDefault();

    // Create and dispatch the swapped event
    const swappedEvent = new KeyboardEvent('keydown', {
      key: 'Enter',
      code: 'Enter',
      keyCode: 13,
      which: 13,
      bubbles: true,
      cancelable: true,
      shiftKey: newShiftState,
      ctrlKey: e.ctrlKey,
      altKey: e.altKey,
      metaKey: e.metaKey,
      view: window
    });

    // Mark it so we don't catch it again
    swappedEvent.isFakeEvent = true;

    e.target.dispatchEvent(swappedEvent);
  }
}, true);
