{ inputs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    equibop.enable = true;

    config = {
      plugins = {
        alwaysAnimate.enable = true;
        alwaysExpandRoles.enable = true;
        anonymiseFileNames.enable = true;

        betterFolders = {
          enable = true;
          forceOpen = true;
        };

        betterGifAltText.enable = true;

        betterSessions = {
          enable = true;
          backgroundCheck = true;
        };

        betterSettings.enable = true;
        callTimer.enable = true;
        clearUrls.enable = true;

        # Disables console messages/errors, Discord's loggers, Spotify logger, and allows for whitelisted loggers.
        consoleJanitor = {
          enable = true;

          disableLoggers = true;
          whitelistedLoggers = "GatewaySocket;Routing/Utils";
        };

        disableCallIdle.enable = true;
        fixImagesQuality.enable = true;
        forceOwnerCrown.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLogger.enable = true;
        permissionsViewer.enable = true;
        previewMessage.enable = true;

        relationshipNotifier = {
          enable = true;
          notices = true;
        };

        replaceGoogleSearch = {
          enable = true;

          customEngineName = "DuckDuckGo";
          customEngineUrl = "https://duckduckgo.com";
        };

        replyTimestamp.enable = true;
        reverseImageSearch.enable = true;
        serverInfo.enable = true;
        showHiddenChannels.enable = true;
        showMeYourName.enable = true;


        # Add a toggle to the chat bar to allow sending silent messages.
        silentMessageToggle = {
          enable = true;

          autoDisable = false;
        };

        # Adds functionality to hide that you are typing.
        silentTyping = {
          enable = true;

          showIcon = true;
        };

        # Add an indicator to the server's channel list if someone is typing.
        typingIndicator.enable = true;

        # Show avatars in the typing indicator.
        typingTweaks = {
          enable = true;

          showRoleColors = false;
        };

        userVoiceShow.enable = true;
        validReply.enable = true;
        validUser.enable = true;

        # Makes avatars and banners on user profiles clickable.
        viewIcons = {
          enable = true;

          format = "png";
        };
      };
    };
  };
}