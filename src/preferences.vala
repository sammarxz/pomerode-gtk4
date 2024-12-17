namespace Pomerode {

[GtkTemplate (ui = "/com/github/sammarxz/pomerode/ui/preferences.ui")]    
public class PreferencesWindow : Adw.PreferencesWindow {
    [GtkChild]
    private unowned Gtk.Entry work_duration_entry;
    [GtkChild]
    private unowned Gtk.Button work_duration_minus;
    [GtkChild]
    private unowned Gtk.Button work_duration_plus;

    [GtkChild]
    private unowned Gtk.Entry break_duration_entry;
    [GtkChild]
    private unowned Gtk.Button break_duration_minus;
    [GtkChild]
    private unowned Gtk.Button break_duration_plus;

    [GtkChild]
    private unowned Gtk.Entry long_break_duration_entry;
    [GtkChild]
    private unowned Gtk.Button long_break_duration_minus;
    [GtkChild]
    private unowned Gtk.Button long_break_duration_plus;

    [GtkChild]
    private unowned Gtk.Entry intervals_until_long_break_entry;
    [GtkChild]
    private unowned Gtk.Button intervals_until_long_break_minus;
    [GtkChild]
    private unowned Gtk.Button intervals_until_long_break_plus;

    [GtkChild]
    private unowned Gtk.Switch autostart_intervals_switch;

    private Settings settings;
    private const int MIN_DURATION = 1;
    private const int MAX_WORK_DURATION = 60;
    private const int MAX_BREAK_DURATION = 30;
    private const int MAX_LONG_BREAK_DURATION = 60;
    private const int MAX_INTERVALS = 10;

    public PreferencesWindow (Adw.Window parent) {
        Object (transient_for: parent, modal: true);
        setup_settings();
        connect_signals();
        update_entries();
    }

    private void setup_settings() {
        settings = new Settings ("com.github.sammarxz.pomerode");
        settings.bind("autostart-intervals",
                    autostart_intervals_switch,
                    "active",
                    SettingsBindFlags.DEFAULT);
    }

    private void connect_signals() {
        connect_duration_controls("work-duration",
                                work_duration_entry,
                                work_duration_minus,
                                work_duration_plus,
                                MIN_DURATION,
                                MAX_WORK_DURATION);

        connect_duration_controls("break-duration",
                                break_duration_entry,
                                break_duration_minus,
                                break_duration_plus,
                                MIN_DURATION,
                                MAX_BREAK_DURATION);

        connect_duration_controls("long-break-duration",
                                long_break_duration_entry,
                                long_break_duration_minus,
                                long_break_duration_plus,
                                MIN_DURATION,
                                MAX_LONG_BREAK_DURATION);

        connect_duration_controls("intervals-until-long-break",
                                intervals_until_long_break_entry,
                                intervals_until_long_break_minus,
                                intervals_until_long_break_plus,
                                MIN_DURATION,
                                MAX_INTERVALS);
    }

    private void connect_duration_controls(string key,
                                        Gtk.Entry entry,
                                        Gtk.Button minus,
                                        Gtk.Button plus,
                                        int min_value,
                                        int max_value) {
    minus.clicked.connect(() => {
        update_setting(key, -1, min_value, max_value);
    });

    plus.clicked.connect(() => {
        update_setting(key, 1, min_value, max_value);
    });

    entry.activate.connect(() => {
        update_from_entry(key, entry, min_value, max_value);
    });

    entry.notify["has-focus"].connect(() => {
        if (!entry.has_focus) {
            update_from_entry(key, entry, min_value, max_value);
        }
    });
}

    private void update_setting(string key, int change, int min_value, int max_value) {
        int current = settings.get_int(key);
        int new_value = current + change;

        if (new_value >= min_value && new_value <= max_value) {
            settings.set_int(key, new_value);
            update_entries();
        }
    }

    private void update_from_entry(string key, Gtk.Entry entry, int min_value, int max_value) {
        int value;
        if (int.try_parse(entry.text, out value)) {
            value = int.max(min_value, int.min(value, max_value));
            settings.set_int(key, value);
        }
        update_entries();
    }

    private void update_entries() {
        work_duration_entry.text = settings.get_int("work-duration").to_string();
        break_duration_entry.text = settings.get_int("break-duration").to_string();
        long_break_duration_entry.text = settings.get_int("long-break-duration").to_string();
        intervals_until_long_break_entry.text = settings.get_int("intervals-until-long-break").to_string();
    }
}
    
} // namespace Pomerode