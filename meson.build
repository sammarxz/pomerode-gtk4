project('com.github.sammarxz.pomerode', ['c', 'vala'],
    version: '0.1.0',
)

app_id = 'com.github.sammarxz.pomerode'

gnome = import('gnome')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

# Dependencies
dependencies = [
    dependency('gtk4'),
    dependency('libadwaita-1'),
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gio-2.0'),
]

# Sources
sources = files(
    'src/main.vala',
    'src/application.vala',
    'src/preferences.vala',
    'src/window.vala',
)

# GResource
gresource = gnome.compile_resources(
    'com.github.sammarxz.pomerode',
    join_paths('data', 'com.github.sammarxz.pomerode.gresource.xml'),
    source_dir: 'data',
    c_name: 'pomerode'
)

# GSchema
install_data(
    'data/com.github.sammarxz.pomerode.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

# Compile schemas
meson.add_install_script('build-aux/meson/postinstall.py')

# Desktop file
desktop_file = configure_file(
    input: 'data/com.github.sammarxz.pomerode.desktop.in',
    output: 'com.github.sammarxz.pomerode.desktop',
    configuration: configuration_data({
        'icon': app_id,
        'binary': app_id
    }),
)

install_data(
    desktop_file,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

# Metainfo
install_data(
    'data/com.github.sammarxz.pomerode.metainfo.xml',
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

# Icons
icon_sizes = ['16', '32', '48', '64', '128']

foreach size : icon_sizes
    install_data(
        join_paths('data/icons', size + 'x' + size, 'com.github.sammarxz.pomerode.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', size + 'x' + size, 'apps')
    )
endforeach

install_data(
    'data/icons/hicolor/symbolic/apps/com.github.sammarxz.pomerode-symbolic.svg',
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'symbolic', 'apps')
)

# Executable
executable(
    'pomerode',
    sources,
    gresource,
    dependencies: dependencies,
    install: true
)
