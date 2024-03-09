var panel = new Panel
var panelScreen = panel.screen

panel.location = "bottom";
panel.height = 36
panel.alignment = "center";
geo = screenGeometry(panelScreen);
panel.minimumLength = geo.width
panel.maximumLength = geo.width

var kickoff = panel.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["Shortcuts"]
kickoff.writeConfig("global", "Alt+F1")
kickoff.currentConfigGroup = ["General"]

panel.addWidget("org.kde.plasma.marginsseparator")
let taskBar = panel.addWidget("org.kde.plasma.taskmanager")
taskBar.currentConfigGroup = ["General"]
taskBar.writeConfig("launchers",["preferred://browser", "preferred://filemanager","applications:org.kde.konsole.desktop"])
taskBar.writeConfig("onlyGroupWhenFull", false)
panel.addWidget("org.kde.plasma.pager")
panel.addWidget("org.kde.plasma.marginsseparator")

/* Next up is determining whether to add the Input Method Panel
 * widget to the panel or not. This is done based on whether
 * the system locale's language id is a member of the following
 * white list of languages which are known to pull in one of
 * our supported IME backends when chosen during installation
 * of common distributions. */

var langIds = ["as",    // Assamese
               "bn",    // Bengali
               "bo",    // Tibetan
               "brx",   // Bodo
               "doi",   // Dogri
               "gu",    // Gujarati
               "hi",    // Hindi
               "ja",    // Japanese
               "kn",    // Kannada
               "ko",    // Korean
               "kok",   // Konkani
               "ks",    // Kashmiri
               "lep",   // Lepcha
               "mai",   // Maithili
               "ml",    // Malayalam
               "mni",   // Manipuri
               "mr",    // Marathi
               "ne",    // Nepali
               "or",    // Odia
               "pa",    // Punjabi
               "sa",    // Sanskrit
               "sat",   // Santali
               "sd",    // Sindhi
               "si",    // Sinhala
               "ta",    // Tamil
               "te",    // Telugu
               "th",    // Thai
               "ur",    // Urdu
               "vi",    // Vietnamese
               "zh_CN", // Simplified Chinese
               "zh_TW"] // Traditional Chinese

if (langIds.indexOf(languageId) != -1) {
    panel.addWidget("org.kde.plasma.kimpanel");
}

panel.addWidget("org.kde.plasma.systemtray")
var dClock = panel.addWidget("org.kde.plasma.digitalclock");
dClock.writeConfig("showDate", false);
var dLogout = panel.addWidget("org.kde.plasma.lock_logout");
dLogout.writeConfig("show_lockScreen", false);
//panel.addWidget("org.kde.plasma.showdesktop")
