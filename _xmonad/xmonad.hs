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

myDzenBar       = "dzen2 -y '0' -h '20' -w '1000' -ta 'l' -fg '#dcdccc' -bg '#3f3f3f' -fn 'Envy Code R-10'"
myBitmapsDir    = "/home/tdr/.dotfiles/_icons"
myTerminal      = "urxvtc"
myWorkspaces    = map show [1..9]
myModMask       = mod4Mask

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_p), spawn "dmenu_run -h 20 -nf '#dcdccc' -nb '#3f3f3f' -sb '#8cd0d3' -sf '#3f3f3f' -fn 'Envy Code R-10'")
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
    { ppCurrent           =   dzenColor "#3f3f3f" "#60b48a" . pad
    , ppVisible           =   dzenColor "#3f3f3f" "#dcdccc" . pad
    , ppHidden            =   dzenColor "#3f3f3f" "#dcdccc" . pad
    , ppHiddenNoWindows   =   dzenColor "#dcdccc" "#3f3f3f" . pad
    , ppUrgent            =   dzenColor "#dca3a3" "#3f3f3f" . pad
    , ppWsSep             =   ""
    , ppSep               =   "  |  "
    , ppLayout            =   dzenColor "#94bff3" "#3f3f3f" . 
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    {-"Simple Float"              ->      "~"-}
                                    _                           ->      x
                                )
    , ppTitle             =   (" " ++) . dzenColor "white" "#3f3f3f" . dzenEscape
    , ppOutput            =   hPutStrLn h
    }

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = "#343434"
myBorderWidth           = 1
