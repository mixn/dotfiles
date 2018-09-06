module.exports = {
  config: {
    fontSize: 18,
    fontFamily: '"IBMPlexMono-ExtraLight", "Fira Code", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
    cursorBlink: true,
    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BEAM',
    padding: '15px',
    shellArgs: ['--login'],
    env: {},
    bell: false,
    copyOnSelect: true,
    // Plugins
    hyperTabs: {
      border: true,
      tabIconsColored: true,
      closeAlign: 'right',
      activityPulse: false,
    },
  },
  plugins: [
    "hyper-ayu",
    "hyper-search",
    "hyper-tabs-enhanced",
    "hypercwd",
    "hyperlinks",
    "hyperterm-dibdabs",
    "hyperterm-paste",
    // "hyper-ayu-mirage",
    // "hyper-dark-dracula",
    // "hyper-snazzy",
    // "hyperterm-duotone-darksea",
  ],
};