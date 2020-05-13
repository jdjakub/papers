svg.onmousedown = e => {
  if (e.button === 0) change(left_mouse_button_is_down, true);
};

svg.onmouseup = e => {
  if (e.button === 0) change(left_mouse_button_is_down, false);
};

// mousemove => pointer position changed
svg.onmousemove = e => {
  let r = svg.getBoundingClientRect();
  let pos = vsub([e.clientX, e.clientY], [r.left, r.top]);
  change(pointer.position, pos);
};

// mouseover => considering a new object
svg.onmouseover = e => {
  if (svg_userData(e.target) !== undefined)
    change(pointer.is_considering_whom, obj);
};

// mouseout => no longer considering the object
svg.onmouseout = e => {
  if (svg_userData(e.target) !== undefined)
    change(pointer.is_considering_whom), undefined);
};
