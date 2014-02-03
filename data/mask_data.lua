local w, h = game.tile_width, game.tile_height
local square = {
  0, 0,
  w, 0,
  w, h,
  0, h,
}
local ru_tri = {
  0, 0,
  w, 0,
  w, h,
}
local rd_tri = {
  w, 0,
  w, h,
  0, h,
}
local lu_tri = {
  0, 0,
  w, 0,
  0, h,
}
local ld_tri = {
  0, h,
  0, 0,
  w, h,
}


return {
  [0] = {
    color = COLORS.clear,
    geometry = square
  },
  [1] = {
    color = COLORS.clear,
    geometry = square
  },
  [2] = {
    color = COLORS.clear,
    geometry = square
  },
  [3] = {
    color = COLORS.white,
    geometry = lu_tri
  },
  [4] = {
    color = COLORS.clear,
    geometry = square
  },
  [5] = {
    color = COLORS.white,
    geometry = ld_tri
  },
  [6] = {
    color = COLORS.white,
    geometry = square
  },
  [7] = {
    color = COLORS.white,
    geometry = square
  },
  [8] = {
    color = COLORS.clear,
    geometry = square
  },
  [9] = {
    color = COLORS.clear,
    geometry = square
  },
  [10] = {
    color = COLORS.white,
    geometry = ru_tri
  },
  [11] = {
    color = COLORS.white,
    geometry = square
  },
  [12] = {
    color = COLORS.white,
    geometry = rd_tri
  },
  [13] = {
    color = COLORS.white,
    geometry = square
  },
  [14] = {
    color = COLORS.white,
    geometry = square
  },
  [15] = {
    color = COLORS.white,
    geometry = square
  },
}