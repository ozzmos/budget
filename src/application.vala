
using Gtk;
using Granite.Widgets;


    public class Budget : Granite.Application{
    
        private Window window;
        private Gtk.Grid layout;
        private AddBudgetDialog add_budget_dialog;
        
        construct {
            application_id = "com.budget";
            program_name = "Budget";
            app_years = "2014";

            build_version = "0.0";
            //app_icon = "text-editor";
            main_url = "https://launchpad.net/budget";
            bug_url = "https://bugs.launchpad.net/budget";
            help_url = "https://answers.launchpad.net/budget";
            translate_url = "https://translations.launchpad.net/";

            about_documenters = {"Valadoc", null };
            about_authors = {"Christophe Bastin <bastin.chris@gmail.com>",
                         null
                         };

            about_comments = "Manage your budget";
            about_translators = "Launchpad Translators";
            about_license_type = Gtk.License.GPL_3_0;
        }

  

        public override void activate () {
            window = new Gtk.Window ();
            window.title = "Budget";
            window.window_position = Gtk.WindowPosition.CENTER;

            window.delete_event.connect (() => {
                Gtk.main_quit ();
                return false;
            });
     
             // Layout
            layout = new Gtk.Grid ();
            layout.expand = true;
            layout.orientation = Gtk.Orientation.VERTICAL;
            
            // Menu for Elementary OS Luna
            // Toolbar
            //var toolbar = new Gtk.Toolbar ();
            //toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);
            //toolbar.hexpand = true;
            //toolbar.vexpand = false;
            //var separator = new SeparatorToolItem ();
            //separator.set_draw(false);
            // separator.set_expand (true);
            // App Menu (give access to the about dialog)
            //var menu = create_appmenu (new Gtk.Menu ());
            //toolbar.add(separator);
            //toolbar.add(menu);
            
            // Headerbar 
            var headerbar = new Gtk.HeaderBar ();
            headerbar.set_title ("Budget");
            headerbar.set_show_close_button (true);
            window.set_titlebar (headerbar);
            

            // Welcome widget
            var welcome_screen = create_welcome_screen ();
            welcome_screen.vexpand = true;
            welcome_screen.hexpand = true;
            welcome_screen.activated.connect (() =>{
                add_budget_dialog = new AddBudgetDialog ();
                
               
            });
            

            //layout.add (toolbar);
            layout.add (welcome_screen);

            window.add(layout);
            window.set_default_size (800, 600);
            window.show_all ();
        
        }

        // method which returns a granite welcome widget
        private Granite.Widgets.Welcome create_welcome_screen (){
            var welcome = new Granite.Widgets.Welcome ("Manage your budget", "Add a budget file");

            Gtk.Image? image = new Gtk.Image.from_icon_name ("document-new", Gtk.IconSize.DIALOG);
            welcome.append_with_image (image, "Create", "Create a budget file");
            
            return welcome;
        }


        public static int main(string[] args){
            new Budget ().run (args);
            Gtk.main ();
            return 0;
        }
    }