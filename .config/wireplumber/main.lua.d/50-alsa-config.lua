  -- Custom DAC rule
  -- This sets the bit depth of my M2 to 24 bits manually
  {
    matches = {
      {
        { "alsa.card_name", "matches", "M2" },
        { "node.name", "matches", "alsa_output.*" },
      }
    },
    apply_properties = {
      ["audio.format"] = "S24LE",
    },
  },
}
