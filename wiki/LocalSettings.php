<?php
# This file was automatically generated by the MediaWiki 1.22.6
# installer. If you make manual changes, please keep track in case you
# need to recreate them later.
#
# See includes/DefaultSettings.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# http://www.mediawiki.org/wiki/Manual:Configuration_settings

# Load the Vector skin
wfLoadSkin( 'Vector' );

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
        exit;
}

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = "HackRVA";
$wgMetaNamespace = "HackRVA";

$wgShowExceptionDetails = true;
$wgShowDBErrorBacktrace = true;
$wgShowSQLErrors = true;
$wgShowSQLErrors = 1;

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## http://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath = "";
$wgScriptExtension = ".php";

## The protocol and server name to use in fully-qualified URLs
$wgServer = "https://wiki.hackrva.org";

## The relative URL path to the skins directory
$wgStylePath = "$wgScriptPath/skins";

## The relative URL path to the logo.  Make sure you change this from the default,
## or else you'll overwrite your logo when you upgrade!
#$wgLogo	     = "images/b/bc/Wiki.png
$wgLogo             = "images/thumb/c/c9/Logo.png/105px-Logo.png";

## UPO means: this is also a user preference option

$wgEnableEmail = false;

// Additional email settings
$wgPasswordSender = "wiki-noreply@hackrva.org"; // Set a default sender email address
$wgPasswordSenderName = "My Wiki";              // Set a default sender name
$wgEnableUserEmail = true;                      // Allow users to send email through the wiki


$wgEmergencyContact = "info@hackrva.org";
$wgPasswordSender = "info@hackrva.org";

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = getenv('MEDIAWIKI_DB_TYPE');
$wgDBserver = getenv('MEDIAWIKI_DB_SERVER');
$wgDBname = getenv('MEDIAWIKI_DB_NAME');
$wgDBuser = getenv('MEDIAWIKI_DB_USER');
$wgDBpassword = getenv('MEDIAWIKI_DB_PASSWORD'); 
// $wgDBmwschema = 'public';
// $wgDBssl = true;

# MySQL specific settings
$wgDBprefix = "mw_";

# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=utf8";

# Experimental charset support for MySQL 5.0.
$wgDBmysql5 = false;

## Shared memory settings
$wgMainCacheType = CACHE_NONE;
$wgMemCachedServers = array();

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
#$wgUseImageMagick = true;
#$wgImageMagickConvertCommand = "/usr/bin/convert";

# InstantCommons allows wiki to use images from http://commons.wikimedia.org
$wgUseInstantCommons = false;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "en_US.utf8";

## If you want to use image uploads under safe mode,
## create the directories images/archive, images/thumb and
## images/temp, and make them all writable. Then uncomment
## this, if it's not already uncommented:
#$wgHashedUploadDirectory = false;

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publically accessible from the web.
#$wgCacheDirectory = "$IP/cache";

# Site language code, should be one of the list in ./languages/Names.php
$wgLanguageCode = "en";

$wgSecretKey = getenv('MEDIAWIKI_SECRET_KEY');

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = getenv('MEDIAWIKI_UPGRADE_KEY') ;

## Default skin: you can change the default skin. Use the internal symbolic
## names, ie 'cologneblue', 'monobook', 'vector':
$wgDefaultSkin = "vector";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";



# End of automatically generated settings.
# Add more configuration options below.

$wgStrictFileExtensions = false;

#Set Default Timezone
$wgLocaltimezone = "America/New_York";
date_default_timezone_set( $wgLocaltimezone );

#Enable Captcha
wfLoadExtensions([ 'ConfirmEdit', 'ConfirmEdit/QuestyCaptcha' ]);

$wgCaptchaClass = 'QuestyCaptcha';
$arr = array (
	'ask for the secret phrase' => getenv('MEDIAWIKI_NEW_USER_SECRET'),
);
foreach ( $arr as $key => $value ) {
        $wgCaptchaQuestions[] = array( 'question' => $key, 'answer' => $value );
}

#Group Permissions
$wgGroupPermissions['*']['edit'] = false;$wgJobRunRate = 0.01;


## Setting Max Upload Size
$wgMaxUploadSize = 40000000;

$wgAllowExternalImages = true;

wfLoadSkin("Timeless");