From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 21:59:19 +0000
Subject: Re: kill most of sparc_ksyms*
Message-Id: <20090105215919.GB8592@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105194431.GA4976@uranus.ravnborg.org>
In-Reply-To: <20090105194431.GA4976@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

And with the following I finally managed to build a vmlinux:

diff --git a/arch/sparc/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
index a81ce32..efb5d0b 100644
--- a/arch/sparc/lib/PeeCeeI.c
+++ b/arch/sparc/lib/PeeCeeI.c
@@ -4,6 +4,8 @@
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/module.h>
+
 #include <asm/io.h>
 #include <asm/byteorder.h>
 
diff --git a/arch/sparc/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
index bddd78b..fde3db4 100644
--- a/arch/sparc/lib/user_fixup.c
+++ b/arch/sparc/lib/user_fixup.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/compiler.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>


Ashaming amount of issues - sorry!

	Sam
