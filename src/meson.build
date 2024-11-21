pomerode_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'preferences.vala',
]

pomerode_deps = [
  config_dep,
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

pomerode_sources += gnome.compile_resources(
  'pomerode-resources',
  'pomerode.gresource.xml',
  c_name: 'pomerode'
)

executable('pomerode', pomerode_sources,
  dependencies: pomerode_deps,
  include_directories: config_inc,
  install: true
)
