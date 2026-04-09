function swapEnter(e) {
  // 1. Only care about Enter
  if (e.key !== 'Enter') return;
  
  // 2. Ignore if it's our own fake event to prevent infinite loops
  if (e.isSwapped) return;

  // 3. Stop the real event immediately
  e.stopImmediatePropagation();
  
  // 4. Create the twin event with the Shift key flipped
  const newEvent = new KeyboardEvent(e.type, {
    ...e, // Copy all properties (bubbles, cancelable, etc.)
    key: "Enter",
    code: "Enter",
    keyCode: 13,
    which: 13,
    shiftKey: !e.shiftKey, // THE SWAP
    view: window
  });

  // Mark it so we don't intercept it again
  newEvent.isSwapped = true;

  // 5. Fire it off
  e.target.dispatchEvent(newEvent);
  
  // Prevent default behavior of the original event
  e.preventDefault();
}

// Catch it at the very start of the event chain
window.addEventListener('keydown', swapEnter, true);
window.addEventListener('keypress', swapEnter, true);
window.addEventListener('keyup', swapEnter, true);
