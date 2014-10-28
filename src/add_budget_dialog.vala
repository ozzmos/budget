

public class AddBudgetDialog : Gtk.Dialog {

    /* variables used by the constuctor */
    public Gtk.Entry budget_entry;


  
    
    public AddBudgetDialog () {  // constructor
        this.title = "Add budget";
        this.set_position (Gtk.WindowPosition.CENTER);
        this.set_default_size (350, 400);
        this.border_width = 20;
       
        
        create_widgets ();
        //connect_signals ();
    
    }
    
    private void create_widgets () {

    
        /* layout */
        Gtk.Box dbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 10); 
        
        /* widgets */
        Gtk.Label budget_label = new Gtk.Label ("Budget name");
        budget_label.set_alignment (0,0);
        
        this.budget_entry = new Gtk.Entry ();
        Gtk.Label date_choice_label = new Gtk.Label ("Close event automatically");
        date_choice_label.set_alignment (0, 0);

        Gtk.Switch date_choice_switch = new Gtk.Switch ();
        date_choice_switch.set_active (false);
        Gtk.Revealer revealer = new Gtk.Revealer ();
        Granite.Widgets.DatePicker date_picker = new Granite.Widgets.DatePicker ();
        revealer.add (date_picker);
        

        
        dbox.pack_start (budget_label,false, false, 0);
        dbox.pack_start (budget_entry, false, false, 0);
        dbox.pack_start (date_choice_label, false, false, 0);
        dbox.pack_start (date_choice_switch, false, false, 0);
        dbox.pack_start (revealer, false, false, 0);
        

        
        date_choice_switch.notify["active"].connect ( ()=> {
            if (date_choice_switch.active) {
                revealer.set_reveal_child (true);
            } else {
                revealer.set_reveal_child (false);
            }
        });
        

        Gtk.Box content = get_content_area () as Gtk.Box;
        content.pack_start (dbox, false, false, 5);

        /* buttons at bottom */
        add_button (Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL);
        add_button (Gtk.Stock.SAVE, Gtk.ResponseType.APPLY);

        this.show_all ();

    }

  
}