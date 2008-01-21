From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Jan 2008 21:50:36 +0000
Subject: [PATCH] sparc64: fix section error in sparcspkr
Message-Id: <20080121215036.GA1286@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With a sparc64 defconfig modified to set CONFIG_HOTPLUG=n
the following error happened during link of vmlinux:

local symbol 0: discarded in section `.devexit.text' from drivers/built-in.o
local symbol 1: discarded in section `.devexit.text' from drivers/built-in.o

(The error message above is from kbuild.git but it happens in mainline too)

The error happens becase there is a reference from .text/.data to
a function marked __devexit. With CONFIG_HOTPLUG=n all code marked
__devexit are discarded and the linker complains.

It was tracked down to sparcspkr.c which were missing __devexit_p()
around the function pointers.

Unfortunately modpost did not catch this since modpost do not warn about
references from .data to .devexit from variables named *_driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index a3637d8..fed3c37 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -195,7 +195,7 @@ static struct of_platform_driver ebus_beep_driver = {
 	.name		= "beep",
 	.match_table	= ebus_beep_match,
 	.probe		= ebus_beep_probe,
-	.remove		= sparcspkr_remove,
+	.remove		= __devexit_p(sparcspkr_remove),
 	.shutdown	= sparcspkr_shutdown,
 };
 
@@ -236,7 +236,7 @@ static struct of_platform_driver isa_beep_driver = {
 	.name		= "beep",
 	.match_table	= isa_beep_match,
 	.probe		= isa_beep_probe,
-	.remove		= sparcspkr_remove,
+	.remove		= __devexit_p(sparcspkr_remove),
 	.shutdown	= sparcspkr_shutdown,
 };
 
