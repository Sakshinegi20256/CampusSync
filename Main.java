import javax.swing.SwingUtilities;
import ui.LoginUI;

public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(LoginUI::new);
    }
}
