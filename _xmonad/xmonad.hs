import qualified Data.Map as M

import System.IO (hPutStrLn)

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Util.Run

main = do
    dzen <- spawnPipe myDzenBar
    xmonad $ defaultConfig
        { terminal              = myTerminal
        , workspaces            = myWorkspaces
        , modMask               = myModMask

        , keys                  = \c -> myKeys c `M.union` keys defaultConfig c
        
        , layoutHook            = myLayoutHook
        , logHook               = myLogHook dzen >> setWMName "LG3D" >> takeTopFocus
        , manageHook            = myManageHook
        
        , normalBorderColor     = myNormalBorderColor
        , focusedBorderColor    = myFocusedBorderColor
        , borderWidth           = myBorderWidth
        }

myDzenBar       = "dzen2 -x '1280' -y '0' -h '20' -w '1320' -ta 'l' -fg '#FFFFFF' -bg '#1b1d1e' -fn 'Envy Code R-10'"
myBitmapsDir    = "/home/tdr/.dotfiles/_icons"
myTerminal      = "urxvtc"
myWorkspaces    = map show [1..9]
myModMask       = mod4Mask

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_p), spawn "dmenu_run -nf '#ffffff' -nb '#1b1d1e' -sb '#de935f' -sf '#1b1d1e' -fn 'Envy Code R-10'")
    , ((0, 0x1008ff11), spawn "amixer set Master 4-")
    , ((0, 0x1008ff13), spawn "amixer set Master 4+")
    ]

myManageHook = composeAll
    [ className =? "mplayer2"      --> doFloat] 
    <+> composeOne
        [ isFullscreen -?> doFullFloat ]

myLayoutHook    = smartBorders $ avoidStruts $ tiled ||| Mirror tiled ||| Full
    where tiled = ResizableTall 1 (2/100) (1/2) []
myLogHook h     = dynamicLogWithPP $ defaultPP
    { ppCurrent           =   dzenColor "#de935f" "#1B1D1E" . pad
    , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
    , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
    , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
    , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
    , ppWsSep             =   " "
    , ppSep               =   "  |  "
    , ppLayout            =   dzenColor "#de935f" "#1B1D1E" . 
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    {-"Simple Float"              ->      "~"-}
                                    _                           ->      x
                                )
    , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
    , ppOutput            =   hPutStrLn h
    }

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = "#343434"
myBorderWidth           = 1
