public class AddContributionDialog : Gtk.Dialog {

    private Gtk.Entry amount_entry;

    public AddContributionDialog () {
        this.title = "Add purchase";
        this.set_position (Gtk.WindowPosition.CENTER);
        this.set_default_size (450, 500);
        this.border_width = 20;

        create_widgets ();
    }

    private void create_widgets () {
        /* layout */
        Gtk.Box dbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 10); 
        
        /* widgets */
        Gtk.Label amount_label = new Gtk.Label ("Amount");
        amount_label.set_alignment (0, 0);
        
        this.amount_entry = new Gtk.Entry ();

        Gtk.Label contributors_label = new Gtk.Label ("Contributors");
        contributors_label.set_alignment (0, 0);

        Gtk.ComboBoxText contributors_entry = new Gtk.ComboBoxText.with_entry ();
        
        Gtk.Label contribution_label = new Gtk.Label ("Label of the contribution");
        contribution_label.set_alignment (0, 0);

        Gtk.Entry contribution_entry = new Gtk.Entry ();

        Gtk.Label date_label = new Gtk.Label ("Date of the contribution");
        date_label.set_alignment (0, 0);

        Granite.Widgets.DatePicker date_picker = new Granite.Widgets.DatePicker ();

        
        



        dbox.pack_start (amount_label,false, false, 0);
        dbox.pack_start (amount_entry, false, false, 0);
        dbox.pack_start (contributors_label, false, false, 0);
        dbox.pack_start (contributors_entry, false, false, 0);
        dbox.pack_start (contribution_label, false, false, 0);
        dbox.pack_start (contribution_entry, false, false, 0);
        dbox.pack_start (date_label, false, false, 0);
        dbox.pack_start (date_picker, false, false, 0);

        Gtk.Box content = get_content_area () as Gtk.Box;
        content.pack_start (dbox, false, false, 5);

        /* buttons at bottom */
        add_button (Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL);
        add_button (Gtk.Stock.SAVE, Gtk.ResponseType.APPLY);

        this.show_all ();
    }
}