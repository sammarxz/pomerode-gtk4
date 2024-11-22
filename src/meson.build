vapi_sources = files(
  'config.vapi',
)

pomerode_vala_args = [
  '--target-glib', '2.72',
  '--vapidir', meson.current_source_dir(),
  '--gresources', resource_files,
  # '--enable-experimental-non-null',
]

pomerode_vala_sources = files(
    'main.vala',
    'application.vala',
    'preferences.vala',
    'window.vala'
)

pomerode_sources = [
    pomerode_vala_sources,
    vapi_sources,
    resources
]

pomerode_vala_args = [
  '--target-glib', '2.72',
  '--vapidir', meson.current_source_dir(),
  '--gresources', resource_files,
  # '--enable-experimental-non-null',
]

pomerode_dependencies = [
    dependency('gtk4'),
    dependency('libadwaita-1'),
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gio-2.0'),

]

executable(
    meson.project_name(),
    pomerode_sources,
    vala_args: pomerode_vala_args,
    dependencies: pomerode_dependencies,
    install: true,
)