/* window.vala
 *
 * Copyright 2024 @sammarxz
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/com/github/sammarxz/ui/window.ui")]
public class Pomerode.Window : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Gtk.Label time_label;

    [GtkChild]
    private unowned Gtk.Button start_button;

    [GtkChild]
    private unowned Gtk.Button reset_button;

    private uint timer_id;
    private int remaining_time;
    private bool is_running;

    public Window (Gtk.Application app) {
        Object (application: app);
        setup_signals ();
        remaining_time = 25 * 60;
        is_running = false;
    }

    private void setup_signals () {
        start_button.clicked.connect (toggle_timer);
        reset_button.clicked.connect (reset_timer);
    }

    private void toggle_timer () {
        if (!is_running) {
            start_timer ();
            start_button.label = "Pause";
        } else {
            stop_timer ();
            start_button.label = "Start";
        }
        is_running = !is_running;
    }

    private void start_timer () {
        timer_id = Timeout.add_seconds (1, () => {
            remaining_time--;
            update_label ();

            if (remaining_time <= 0) {
                stop_timer ();
                var notification = new Notification ("Pomodoro");
                notification.set_body ("Time's up!");
                application.send_notification ("com.github.yourusername.pomodoro", notification);
                return false;
            }
            return true;
        });
    }

    private void stop_timer () {
        if (timer_id != 0) {
            Source.remove (timer_id);
            timer_id = 0;
        }
    }

    private void reset_timer () {
        stop_timer ();
        remaining_time = 25 * 60;
        update_label ();
        start_button.label = "Start";
        is_running = false;
    }

    private void update_label () {
        int minutes = remaining_time / 60;
        int seconds = remaining_time % 60;
        time_label.label = "%02d:%02d".printf (minutes, seconds);
    }

}
