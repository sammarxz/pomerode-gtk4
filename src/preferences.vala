namespace Pomerode {


[GtkTemplate (ui = "/com/github/sammarxz/ui/preferences.ui")]
    public class PreferencesWindow : Adw.PreferencesWindow {
        [GtkChild]
        private unowned Adw.SpinRow work_duration;

        [GtkChild]
        private unowned Adw.SpinRow break_duration;

        [GtkChild]
        private unowned Adw.SpinRow long_break_duration;

        [GtkChild]
        private unowned Adw.SpinRow intervals_until_long_break;

        [GtkChild]
        private unowned Adw.SwitchRow autostart_intervals;

        public PreferencesWindow (Adw.Window parent) {
            Object (transient_for: parent, modal: true);

            var settings = new Settings ("com.github.sammarxz");

            settings.bind ("work-duration", work_duration, "value", SettingsBindFlags.DEFAULT);
            settings.bind ("break-duration", break_duration, "value", SettingsBindFlags.DEFAULT);
            settings.bind ("long-break-duration", long_break_duration, "value", SettingsBindFlags.DEFAULT);
            settings.bind ("intervals-until-long-break", intervals_until_long_break, "value", SettingsBindFlags.DEFAULT);
            settings.bind ("autostart-intervals", autostart_intervals, "active", SettingsBindFlags.DEFAULT);
        }
    }
}
