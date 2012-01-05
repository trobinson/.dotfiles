import XMonad

import XMonad.Actions.CopyWindow(copyToAll, killAllOtherCopies)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks(avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers(isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders(smartBorders)

import XMonad.Util.CustomKeys(customKeys)
import XMonad.Util.Run(spawnPipe)

import System.IO(hPutStrLn)


layoutSymbols "Tall"        = "|"
layoutSymbols "Mirror Tall" = "-"
layoutSymbols "Full"        = "*"
layoutSymbols m             = id m


main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { terminal              = "urxvtc"
        , workspaces            = map show [1..5]
        , modMask               = mod4Mask
        , normalBorderColor     = "#1c1c1c"
        , focusedBorderColor    = "#afdf5f"
        , keys                  = customKeys delkeys inskeys
        , logHook               = myLogHook xmproc
        , layoutHook            = smartBorders . avoidStruts  $  layoutHook defaultConfig 
        , manageHook            = manageHook defaultConfig <+> myManageHook
        , startupHook           = setWMName "LG3D"
        }
        where
            delkeys :: XConfig l -> [(KeyMask, KeySym)]
            delkeys XConfig {modMask = modm} = [ (modm, xK_p) ]

            inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
            inskeys conf@(XConfig {modMask = modm}) =
                        [ ((modm, xK_s), windows copyToAll)
                        -- toggle stickiness of windows ^ and v 
                        , ((modm .|. shiftMask, xK_s), killAllOtherCopies)
                        -- change dmenu colors
                        , ((modm, xK_p), spawn "exe=`dmenu_run -fn dina-10 -nb \\#1c1c1c -nf \\#d0d0d0 -sf \\#dfdf00 -sb \\#1c1c1c`")
                        -- XF86AudioMute
                        , ((0 , 0x1008ff12), spawn "ncmpcpp toggle")
                        -- XF86AudioLowerVolume
                        , ((0 , 0x1008ff11), spawn "ncmpcpp volume -1")
                        -- XF86AudioRaiseVolume
                        , ((0 , 0x1008ff13), spawn "ncmpcpp volume +1")
                        -- XF86AudioPlay
                        , ((0 , 0x1008ff14), spawn "ncmpcpp toggle")
                        -- XF86AudioStop
                        , ((0 , 0x1008ff15), spawn "ncmpcpp stop")
                        -- XF86AudioNext
                        , ((0 , 0x1008ff16), spawn "ncmpcpp next")
                        -- XF86AudioPrev
                        , ((0 , 0x1008ff17), spawn "ncmpcpp prev")
                        -- Display Internet Usage
                        , ((modm, xK_u), spawn "~/.scripts/usage.py")
                        ]
            myManageHook :: ManageHook
            myManageHook = composeAll 
                        [ isFullscreen              --> doFullFloat
                        , className =? "feh"        --> doFloat
                        , manageDocks
                        ]

            myLogHook xmo = dynamicLogWithPP xmobarPP
                        { ppCurrent         = xmobarColor "#00aaff" "" . wrap ">" "<"
                        , ppVisible         = wrap "(" ")"
                        , ppHidden          = id
                        , ppHiddenNoWindows = id
                        , ppUrgent          = xmobarColor "#df8787" ""
                        , ppSep             = xmobarColor "#767676" "" " | "
                        , ppWsSep           = " "
                        , ppTitle           = xmobarColor "#afdf5f" "" . shorten 80
                        , ppLayout          = layoutSymbols 
                        , ppOutput          = hPutStrLn xmo
                        }
