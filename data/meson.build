# GResource
resources = gnome.compile_resources(
    'com.github.sammarxz.pomerode',
    'com.github.sammarxz.pomerode.gresource.xml',
    c_name: 'pomerode'
)

# GSchema
install_data(
    'com.github.sammarxz.pomerode.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

# Desktop file
desktop_file = configure_file(
    input: 'com.github.sammarxz.pomerode.desktop.in',
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
    'com.github.sammarxz.pomerode.metainfo.xml',
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

# Icons
icon_sizes = ['16', '32', '48', '64', '128']

foreach size : icon_sizes
    install_data(
        join_paths('icons', size + 'x' + size, 'com.github.sammarxz.pomerode.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', size + 'x' + size, 'apps')
    )
endforeach

install_data(
    'icons/hicolor/symbolic/apps/com.github.sammarxz.pomerode-symbolic.svg',
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'symbolic', 'apps')
)
