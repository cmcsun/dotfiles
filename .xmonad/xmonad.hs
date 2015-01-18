import System.Posix.Env (getEnv)
import Data.Maybe (maybe)
import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.NoBorders

normalBorderColor = "#000000"
focusedBorderColor = "#000000"

myLayoutHook = noBorders Full

main = xmonad defaultConfig
    {
        terminal = "terminator",
        layoutHook = myLayoutHook
    }
desktop _ = desktopConfig
