
import Graphics.UI.Gtk;
import Graphics.UI.Gtk.Glade;
import Graphics.UI.Gtk.Windows.Dialog;
import Directory (doesFileExist);
import System (system);

gladeResource = "/home/ali/code/transimg/transimg.glade"

void x = x >> (return ())

selection s = case s of
  0 -> "fr"
  1 -> "it"
  2 -> "de"

goAction langCombo fileChooser = do
  lang <- (comboBoxGetActive langCombo)
  file <- (fileChooserGetFilename fileChooser)
  case file of
    (Just fname) -> (void (system ("tesseract " ++ fname ++ " output -l " ++ (selection lang))))
    Nothing      -> return ()

main = do
  initGUI
  (Just xml)   <- (xmlNew gladeResource)
  window       <- (xmlGetWidget xml castToWindow            "window1")
  browseButton <- (xmlGetWidget xml castToButton            "button1")
  goButton     <- (xmlGetWidget xml castToButton            "button2")
  cancelButton <- (xmlGetWidget xml castToButton            "button3")
  openButton   <- (xmlGetWidget xml castToButton            "button4")
  langCombo    <- (xmlGetWidget xml castToComboBox          "combobox1")
  fileChooser  <- (xmlGetWidget xml castToFileChooserDialog "filechooserdialog1")
  onDestroy window mainQuit
  onClicked browseButton (windowPresent fileChooser)
  onClicked cancelButton (widgetHide fileChooser)
  onClicked openButton   (widgetHide fileChooser)
  onClicked goButton     (goAction langCombo fileChooser)
  comboBoxSetActive langCombo 0
  widgetShowAll window
  mainGUI


