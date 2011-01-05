From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 21:03:47 +0000
Subject: [PATCH 4/4] sound,sparc: drop SBUS dependency
Message-Id: <1294261427-26104-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC has always SBUS equal to y to
the "depends on SBUS" is redundant.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 sound/sparc/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/sparc/Kconfig b/sound/sparc/Kconfig
index d75deba..750a452 100644
--- a/sound/sparc/Kconfig
+++ b/sound/sparc/Kconfig
@@ -11,7 +11,6 @@ if SND_SPARC
 
 config SND_SUN_AMD7930
 	tristate "Sun AMD7930"
-	depends on SBUS
 	select SND_PCM
 	help
 	  Say Y here to include support for AMD7930 sound device on Sun.
@@ -30,7 +29,6 @@ config SND_SUN_CS4231
 
 config SND_SUN_DBRI
 	tristate "Sun DBRI"
-	depends on SBUS
 	select SND_PCM
 	help
 	  Say Y here to include support for DBRI sound device on Sun.
-- 
1.6.0.6

