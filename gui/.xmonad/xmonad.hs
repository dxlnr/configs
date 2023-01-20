--------------------------------------------------------------------------------
-- IMPORT
--------------------------------------------------------------------------------
import qualified Codec.Binary.UTF8.String as UTF8

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import Data.Monoid
import System.Exit
import System.IO (hClose)

import qualified DBus as D
import qualified DBus.Client as D
import qualified XMonad.Layout.BoringWindows as B
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--------------------------------------------------------------------------------
-- GLOBAL VARIABLES
--------------------------------------------------------------------------------
myTerminal      = "alacritty"
myModMask       = mod1Mask
myBorderWidth   = 1
myBrowser      	= "firefox"
mySpacing :: Int
mySpacing      	= 5
myLargeSpacing :: Int
myLargeSpacing 	= 30
noSpacing :: Int
noSpacing      	= 0
prompt         	= 20

-- colors
fg		= "#ebdbb2"
focus 	= "#5b51c9"

-- font

--------------------------------------------------------------------------------
-- LAYOUT
--------------------------------------------------------------------------------
myLayout = tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

--------------------------------------------------------------------------------
-- WORKSPACES
--------------------------------------------------------------------------------
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- MANAGE HOOKS
--------------------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "MPlayer"        	--> doFloat
    , className =? "Gimp"           	--> doFloat
    , resource  =? "desktop_window" 	--> doIgnore
    , resource  =? "kdesktop"       	--> doIgnore 
	, role      =? "pop-up"         	--> doFloat ]

--------------------------------------------------------------------------------
-- STARTUP
--------------------------------------------------------------------------------
myStartupHook = do
  spawnOnce "$HOME/.config/polybar/launch.sh"
  spawnOnce "nitrogen --restore"

--------------------------------------------------------------------------------
-- LOGHOOK                                                                     
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- CONFIG                                                                     
--------------------------------------------------------------------------------
myConfig = def
  { terminal            = myTerminal
  , layoutHook          = myLayouts
  , manageHook          = placeHook(smart(0.5, 0.5))
      <+> manageDocks
      <+> myManageHook
      <+> myManageHook'
      <+> manageHook def
  , handleEventHook     = docksEventHook
      <+> minimizeEventHook
      <+> fullscreenEventHook
  , startupHook         = myStartupHook
  , focusFollowsMouse   = False
  , clickJustFocuses    = False
  , borderWidth         = myBorderWidth
  , normalBorderColor   = bg
  , focusedBorderColor  = pur2
  , workspaces          = myWorkspaces
  , modMask             = myModMask
  }
--------------------------------------------------------------------------------
-- MAIN                                                                      
--------------------------------------------------------------------------------
main :: IO ()
main = do
	dbus <- D.connectionSession
	D.requestName dbus (D.busName_ "org.xmonad.Log")
		[D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

	xmonad
		$ ewmh
		$ myConfig { LogHook = dynamicLogWithPP (myLogHook dbus) }
