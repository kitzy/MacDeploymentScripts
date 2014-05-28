#!/bin/bash

shopt -s nullglob

mountpoint=$1
to_delete=(
"${mountpoint}"/Library/Updates/*
"${mountpoint}"/Library/Application\ Support/CrashReporter/*
"${mountpoint}"/Library/QuickLook/iWork.qlgenerator
"${mountpoint}"/private/var/db/dyld/*
"${mountpoint}"/private/var/folders/*
"${mountpoint}"/usr/share/man/*
"${mountpoint}"/usr/share/emacs
"${mountpoint}"/usr/share/vim
"${mountpoint}"/usr/share/gutenprint
"${mountpoint}"/usr/share/cups
"${mountpoint}"/usr/share/doc
"${mountpoint}"/usr/lib/mecab/dic
"${mountpoint}"/System/Library/Address\ Book\ Plug-Ins/*
"${mountpoint}"/System/Library/Automator/*
"${mountpoint}"/System/Library/Speech/*
"${mountpoint}"/System/Library/Fonts/STHeiti\ Light.ttc
"${mountpoint}"/System/Library/Fonts/AquaKana.ttc
"${mountpoint}"/System/Library/Fonts/AppleGothic.ttf
"${mountpoint}"/System/Library/Fonts/LastResort.ttf
"${mountpoint}"/System/Library/Fonts/Menlo.ttc
"${mountpoint}"/System/Library/Fonts/Courier.dfont
"${mountpoint}"/System/Library/Fonts/ヒラギノ明朝\ ProN\ W3.otf
"${mountpoint}"/System/Library/Fonts/ヒラギノ明朝\ ProN\ W6.otf
"${mountpoint}"/System/Library/Fonts/ヒラギノ角ゴ\ ProN\ W3.otf
"${mountpoint}"/System/Library/Fonts/ヒラギノ角ゴ\ ProN\ W6.otf
"${mountpoint}"/System/Library/Fonts/儷黑\ Pro.ttf
"${mountpoint}"/System/Library/Fonts/华文细黑.ttf
"${mountpoint}"/System/Library/Fonts/华文黑体.ttf
"${mountpoint}"/System/Library/User\ Template/*
"${mountpoint}"/System/Library/Caches/*
"${mountpoint}"/System/Library/Screen\ Savers/Forest.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/iTunes\ Artwork.saver
"${mountpoint}"/System/Library/Screen\ Savers/Nature\ Patterns.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/Paper\ Shadow.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/Random.saver
"${mountpoint}"/System/Library/Screen\ Savers/RSS\ Visualizer.qtz
"${mountpoint}"/System/Library/Screen\ Savers/Arabesque.qtz
"${mountpoint}"/System/Library/Screen\ Savers/Word\ of\ the\ Day.qtz
"${mountpoint}"/System/Library/Screen\ Savers/Shell.qtz
"${mountpoint}"/System/Library/Screen\ Savers/Spectrum.qtz
"${mountpoint}"/System/Library/Screen\ Savers/Abstract.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/Beach.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/Cosmos.slideSaver
"${mountpoint}"/System/Library/Screen\ Savers/FloatingMessage.saver
"${mountpoint}"/System/Library/CoreServices/"Setup Assistant.app"/Contents/Resources/TransitionSection.bundle/Contents/Resources/intro.mov
"${mountpoint}"/System/Library/CoreServices/"Setup Assistant.app"/Contents/Resources/TransitionSection.bundle/Contents/Resources/intro-sound.mp3
"${mountpoint}"/System/Library/CoreServices/Front\ Row.app
"${mountpoint}"/System/Library/CoreServices/RawCamera.bundle
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/TextInput.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/WWAN.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/Sync.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/HomeSync.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/TimeMachine.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/Fax.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/iChat.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/Script Menu.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/IrDA.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/RemoteDesktop.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/PPP.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/VPN.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/UniversalAccess.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/Spaces.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/PPPoE.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/ExpressCard.menu
"${mountpoint}"/System/Library/CoreServices/Menu\ Extras/Ink.menu
"${mountpoint}"/usr/X11
"${mountpoint}"/usr/libexec/cups
"${mountpoint}"/usr/lib/podcastproducer
"${mountpoint}"/System/Library/Input\ Methods/CharacterPalette.app
"${mountpoint}"/System/Library/Input\ Methods/ChineseHandwriting.app
"${mountpoint}"/System/Library/Input\ Methods/InkServer.app
"${mountpoint}"/System/Library/Input\ Methods/50onPaletteServer.app
"${mountpoint}"/System/Library/Input\ Methods/KoreanIM.app
"${mountpoint}"/System/Library/Input\ Methods/Kotoeri.app
"${mountpoint}"/System/Library/Input\ Methods/PluginIM.app
"${mountpoint}"/System/Library/Input\ Methods/SCIM.app
"${mountpoint}"/System/Library/Input\ Methods/TamilIM.app
"${mountpoint}"/System/Library/Input\ Methods/TCIM.app
"${mountpoint}"/System/Library/Input\ Methods/VietnameseIM.app
"${mountpoint}"/System/Library/PreferencePanes/MobileMe.prefPane
"${mountpoint}"/System/Library/PreferencePanes/TimeMachine.prefPane
"${mountpoint}"/System/Library/PreferencePanes/Expose.prefPane
"${mountpoint}"/System/Library/PreferencePanes/Ink.prefPane
"${mountpoint}"/System/Library/PreferencePanes/Spotlight.prefPane
"${mountpoint}"/System/Library/PreferencePanes/FibreChannel.prefPane
"${mountpoint}"/System/Library/PreferencePanes/SoftwareUpdate.prefPane
"${mountpoint}"/System/Library/PreferencePanes/Mac.prefPane
"${mountpoint}"/System/Library/PreferencePanes/Trackpad.prefPane/Contents/Resources/BTTrackpad.mov
"${mountpoint}"/System/Library/PreferencePanes/Trackpad.prefPane/Contents/Resources/ButtonlessTrackpadCombo.mov
"${mountpoint}"/System/Library/PreferencePanes/Trackpad.prefPane/Contents/Resources/TrackpadCombo.mov
"${mountpoint}"/System/Library/PreferencePanes/Mouse.prefPane/Contents/Resources/touchMovie.mov
"${mountpoint}"/System/Library/CoreServices/Encodings/*
"${mountpoint}"/System/Library/Frameworks/XgridFoundation.framework
"${mountpoint}"/private/var/log/*
"${mountpoint}"/Library/Internet\ Plug-Ins/NP-PPC-Dir-Shockwave
"${mountpoint}"/Library/Internet\ Plug-Ins/flashplayer.xpt
"${mountpoint}"/Library/Internet\ Plug-Ins/Flash\ Player.plugin
"${mountpoint}"/Library/Perl
"${mountpoint}"/Library/Receipts/*
"${mountpoint}"/usr/bin/php
"${mountpoint}"/Library/Application\ Support/CrashReporter
"${mountpoint}"/Library/Application\ Support/iLifeMediaBrowser
"${mountpoint}"/Library/Application\ Support/Macromedia
"${mountpoint}"/Library/Application\ Support/ProApps
"${mountpoint}"/Library/Audio/*
"${mountpoint}"/Library/Desktop\ Pictures/.DS_Store
"${mountpoint}"/Library/Desktop\ Pictures/.thumbnails
"${mountpoint}"/Library/Desktop\ Pictures/Abstract
"${mountpoint}"/Library/Desktop\ Pictures/Aqua\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Aqua\ Graphite.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Art
"${mountpoint}"/Library/Desktop\ Pictures/Black\ \&\ White
"${mountpoint}"/Library/Desktop\ Pictures/Classic\ Aqua\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Classic\ Aqua\ Graphite.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Flow\ 1.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Flow\ 2.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Flow\ 3.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Jaguar\ Aqua\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Jaguar\ Aqua\ Graphite.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Lines\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Lines\ Graphite.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Lines\ Moss.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Lines\ Plum.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Nature
"${mountpoint}"/Library/Desktop\ Pictures/Panther\ Aqua\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Panther\ Aqua\ Graphite.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Patterns
"${mountpoint}"/Library/Desktop\ Pictures/Plants
"${mountpoint}"/Library/Desktop\ Pictures/Ripples\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Ripples\ Moss.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Ripples\ Purple.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Small\ Ripples\ graphite.png
"${mountpoint}"/Library/Desktop\ Pictures/Small\ Ripples.png
"${mountpoint}"/Library/Desktop\ Pictures/Solid\ Colors
"${mountpoint}"/Library/Desktop\ Pictures/Tiles\ Blue.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Tiles\ Pine.jpg
"${mountpoint}"/Library/Desktop\ Pictures/Tiles\ Warm\ Grey.jpg
"${mountpoint}"/Library/Developer/*
"${mountpoint}"/Library/Dictionaries/*
"${mountpoint}"/Library/Documentation/*
"${mountpoint}"/Library/Fonts/*
"${mountpoint}"/Library/iTunes
"${mountpoint}"/Library/Logs
"${mountpoint}"/Library/Modem Scripts
"${mountpoint}"/Library/PDF Services
"${mountpoint}"/Library/Scripts
"${mountpoint}"/Library/Spotlight
"${mountpoint}"/Library/User\ Pictures/Animals
"${mountpoint}"/Library/User\ Pictures/Flowers
"${mountpoint}"/Library/User\ Pictures/Fun
"${mountpoint}"/Library/User\ Pictures/Instruments
"${mountpoint}"/Library/User\ Pictures/Nature
"${mountpoint}"/Library/User\ Pictures/Sports/Bowling.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Football.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Golf.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Hockey.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Soccer.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Target.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Tennis.tif
"${mountpoint}"/Library/User\ Pictures/Sports/8ball.tif
"${mountpoint}"/Library/User\ Pictures/Sports/Baseball.tif
"${mountpoint}"/Library/WebServer/*
"${mountpoint}"/Library/Widgets/*
"${mountpoint}"/usr/bin/emacs
"${mountpoint}"/usr/bin/emacs-undumped
"${mountpoint}"/System/Library/Speech/*
"${mountpoint}"/Library/Application\ Support/Apple/Mail
"${mountpoint}"/Library/Application\ Support/Apple/Grapher
"${mountpoint}"/Library/Application\ Support/Apple/System\ Image\ Utility
"${mountpoint}"/Library/Application\ Support/Apple/Fonts
"${mountpoint}"/Library/Application\ Support/Apple/iChat\ Icons
"${mountpoint}"/Library/Application\ Support/Apple/Automator
"${mountpoint}"/Library/Application\ Support/Apple/WikiServer
"${mountpoint}"/Library/Printers/*
"${mountpoint}"/Library/Image\ Capture/*
"${mountpoint}"/Library/Desktop\ Pictures/*
"${mountpoint}"/Applications/Address\ Book.app
"${mountpoint}"/Applications/Automator.app
"${mountpoint}"/Applications/Calendar.app
"${mountpoint}"/Applications/Calculator.app
"${mountpoint}"/Applications/Contacts.app
"${mountpoint}"/Applications/Chess.app
"${mountpoint}"/Applications/Dashboard.app
"${mountpoint}"/Applications/Dictionary.app
"${mountpoint}"/Applications/DVD\ Player.app
"${mountpoint}"/Applications/FaceTime.app
"${mountpoint}"/Applications/Font\ Book.app
"${mountpoint}"/Applications/Garageband.app
"${mountpoint}"/Applications/iCal.app
"${mountpoint}"/Applications/iChat.app
"${mountpoint}"/Applications/Image\ Capture.app
"${mountpoint}"/Applications/iMovie.app
"${mountpoint}"/Applications/iPhoto.app
"${mountpoint}"/Applications/iTunes.app
"${mountpoint}"/Applications/Launchpad.app
"${mountpoint}"/Applications/Messages.app
"${mountpoint}"/Applications/Mission\ Control.app
"${mountpoint}"/Applications/Notes.app
"${mountpoint}"/Applications/Photo\ Booth.app
"${mountpoint}"/Applications/QuickTime\ Player.app
"${mountpoint}"/Applications/Reminders.app
"${mountpoint}"/Applications/Stickies.app
"${mountpoint}"/Applications/Time\ Machine.app
"${mountpoint}"/Applications/Mail.app
"${mountpoint}"/Applications/Utilities/AirPort\ Utility.app
"${mountpoint}"/Applications/Utilities/AppleScript\ Editor.app
"${mountpoint}"/Applications/Utilities/Audio\ MIDI\ Setup.app
"${mountpoint}"/Applications/Utilities/Bluetooth\ File\ Exchange.app
"${mountpoint}"/Applications/Utilities/Boot\ Camp\ Assistant.app
"${mountpoint}"/Applications/Utilities/ColorSync\ Utility.app
"${mountpoint}"/Applications/Utilities/DigitalColor\ Meter.app
"${mountpoint}"/Applications/Utilities/Grab.app
"${mountpoint}"/Applications/Utilities/Grapher.app
"${mountpoint}"/Applications/Utilities/Migration\ Assistant.app
"${mountpoint}"/Applications/Utilities/Podcast\ Capture.app
"${mountpoint}"/Applications/Utilities/Podcast\ Publisher.app
"${mountpoint}"/Applications/Utilities/RAID\ Utility.app
"${mountpoint}"/Applications/Utilities/VoiceOver\ Utility.app
"${mountpoint}"/Applications/Utilities/X11.app
"${mountpoint}"/System/Library/Caches/*
"${mountpoint}"/Library/Caches/*
"${mountpoint}"/private/var/vm/sleepimage
"${mountpoint}"/private/var/vm/swapfile*
)

for item in "${to_delete[@]}"; do
rm -rfv "${item}"
done