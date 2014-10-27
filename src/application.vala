using GLib;
using Gtk;
using Gda;
using Granite.Widgets;


    public class Budget : Granite.Application{
    
        private Gda.Connection conn;
        private Gda.DataModel dm;
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
       
            setup_database ();

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
                add_budget ();
                
               
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

        private void add_budget () {
            add_budget_dialog = new AddBudgetDialog ();
            int response = add_budget_dialog.run ();
            if (response == Gtk.ResponseType.APPLY) {
                save_budget ();
                add_budget_dialog.destroy ();
            } else {
                stdout.printf ("Cancel\n");
                add_budget_dialog.destroy ();
            }
        }

        private void setup_database () throws GLib.Error {
            
            conn = Gda.Connection.open_from_string ("SQLite",
            "DB_DIR=.;DB_NAME=budget_db", null, Gda.ConnectionOptions.NONE);
            
            try {
                dm = conn.execute_select_command("select * from budgets");
            } catch (GLib.Error err) {
                conn.execute_non_select_command("create table budgets (id integer primary key, budget_name text)");
            } 
             
            try {
                dm = conn.execute_select_command("select * from purchases");
            } catch (GLib.Error err) {
                conn.execute_non_select_command("create table purchases (id integer primary key, shop_name text, price real, buyer text, purchase_date date)");
            } 
            conn.close();
            
            
           
        }

        private void save_budget () throws GLib.Error {
        
            conn.open();
            Gda.SqlBuilder b = new Gda.SqlBuilder(Gda.SqlStatementType.INSERT);
            b.set_table("budgets");
            b.add_field_value_as_gvalue("budget_name", add_budget_dialog.budget_entry.get_text());

            try {
                Gda.Statement stmt = b.get_statement();
                conn.statement_execute_non_select(stmt, null, null);
            } catch (GLib.Error err) {
                print("insert error !");
            conn.close();
            }
       
        }


        public static int main(string[] args){
            new Budget ().run (args);
            Gtk.main ();
            return 0;
        }
    }