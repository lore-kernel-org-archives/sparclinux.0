From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 08 Jun 2009 19:20:43 +0000
Subject: [PATCH] sparc: fix tftpboot.img build
Message-Id: <20090608192043.GA30278@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Kjetil Oftedal mentioned that piggyback_32 was failing
when building a sparc image.

I tracked this down to the fact that the kernel no longer
provided an absolute symbol named "end".

Commit 86ed40bd6fe511d26bb8f3fa65a84cb65c235366 ("sparc: unify sections.h")
renamed end to _end but failed to update piggyback_32.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Kjetil Oftedal <oftedal@gmail.com>
Cc: Robert Reif <reif@earthlink.net>
---

This is not even build tested - but looks obvious.

	Sam

diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index c9f500c..e6070a3 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -84,7 +84,7 @@ int main(int argc,char **argv)
 	while (fgets (buffer, 1024, map)) {
 		if (!strcmp (buffer + 8, " T start\n") || !strcmp (buffer + 16, " T start\n"))
 			start = strtoul (buffer, NULL, 16);
-		else if (!strcmp (buffer + 8, " A end\n") || !strcmp (buffer + 16, " A end\n"))
+		else if (!strcmp (buffer + 8, " A _end\n") || !strcmp (buffer + 16, " A _end\n"))
 			end = strtoul (buffer, NULL, 16);
 	}
 	fclose (map);
