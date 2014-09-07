-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)
import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import XMonad.Layout.NoBorders

normalBorderColor = "#000000"
focusedBorderColor = "#000000"
myTerminal = "terminator"
terminal = "terminator"

myLayoutHook = noBorders Full

main = xmonad $ defaultConfig { layoutHook = myLayoutHook }

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig
