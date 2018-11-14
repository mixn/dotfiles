module.exports = {
  config: {
    fontSize: 16,
    fontFamily: '"IBMPlexMono-ExtraLight", "Inconsolata", "Anonymous Pro"',
    cursorBlink: true,
    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BEAM',
		padding: '0 15px',
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
		hyperBorder: {
			borderColors: ['#D066D4', '#53A1F7'],
			borderWidth: '1px'
		}
  },
  plugins: [
		// 'hyper-ayu',
    // 'hyper-ayu-mirage',
    // 'hyper-dark-dracula',
    // 'hyper-snazzy',
		// 'hyperterm-duotone-darksea',
		// 'hyper-statusline',
		'hyperborder',
		'hyper-city-lights',
    'hyper-search',
    'hyper-tabs-enhanced',
    'hypercwd',
    'hyperlinks',
    'hyperterm-dibdabs',
    'hyperterm-paste',
  ],
};
