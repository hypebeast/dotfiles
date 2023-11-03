function outlook_archive_email()
    hs.application.launchOrFocus("Microsoft Outlook")
    local outlook = hs.appfinder.appFromName("Microsoft Outlook")

    local str_archive = {"Message", "Archive"}

    local archive = outlook:findMenuItem(str_archive)

    outlook:selectMenuItem(str_archive)
end

hs.hotkey.bind({"cmd", "alt"}, "a", outlook_archive_email)
