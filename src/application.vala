public class Pomerode.Application : Adw.Application {
    public Application () {
        Object (
            application_id: "com.github.sammarxz.pomerode",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    construct {
        ActionEntry[] action_entries = {
            { "about", this.on_about_action },
            { "preferences", this.on_preferences_action },
            { "quit", this.quit }
        };
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", {"<primary>q"});
    }

    public override void activate () {
        base.activate ();
        var win = this.active_window ?? new Pomerode.Window (this);
        win.present ();
    }

    private void on_about_action () {
        var about = new Gtk.AboutDialog () {
            program_name = "Pomerode",
            logo_icon_name = "com.github.sammarxz.pomerode",
            version = "0.1.0",
            authors = { "@sammarxz" },
            copyright = "© 2024 @sammarxz",
            license_type = Gtk.License.GPL_3_0,
            website = "https://github.com/sammarxz/pomerode",
            website_label = "Project Website",
            comments = "A simple focus timer app",
            translator_credits = "translator-credits",
            transient_for = this.active_window
        };
        about.present ();
    }

    private void on_preferences_action () {
        var preferences = new Pomerode.PreferencesWindow ((Adw.ApplicationWindow) this.active_window);
        preferences.present ();
    }
}
