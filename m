From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 04 Jan 2009 11:59:47 +0000
Subject: [PATCH] MAINTAINERS: update sparc maintainer
Message-Id: <20090104115947.GA32643@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, wli@holomorphy.com, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Reflect the current situation where David Miller
is the sparc maintainer.

I have tried to contact Bill on following adresses:

    wli@holomorphy.com
    wlirwin@us.ibm.com

with no success and Bill has not been active on the
sparclinux mailing list for a long time.

As sparc and sparc64 are unified I unified the two entries
in the MAINTAINERS file too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I added Bill to this mail to do a second attempt on the holomorphy address.

Note: This patch should have an ack from David before it goes in.

	Sam

diff --git a/MAINTAINERS b/MAINTAINERS
index befacf0..141aff6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4015,10 +4015,12 @@ L:	alsa-devel@alsa-project.org (subscribers-only)
 W:	http://alsa-project.org/main/index.php/ASoC
 S:	Supported
 
-SPARC (sparc32)
-P:	William L. Irwin
-M:	wli@holomorphy.com
+SPARC + UltraSPARC (sparc/sparc64)
+P:	David S. Miller
+M:	davem@davemloft.net
 L:	sparclinux@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git
 S:	Maintained
 
 SPECIALIX IO8+ MULTIPORT SERIAL CARD DRIVER
@@ -4302,13 +4304,6 @@ M:	dushistov@mail.ru
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
-UltraSPARC (sparc64)
-P:	David S. Miller
-M:	davem@davemloft.net
-L:	sparclinux@vger.kernel.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
-S:	Maintained
-
 ULTRA-WIDEBAND (UWB) SUBSYSTEM:
 P:	David Vrabel
 M:	david.vrabel@csr.com
