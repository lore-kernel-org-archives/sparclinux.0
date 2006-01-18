From: Jim Gifford <maillist@jg555.com>
Date: Wed, 18 Jan 2006 23:02:51 +0000
Subject: Re: Build Issue - Sparc64
Message-Id: <43CEC91B.6010607@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <43C6A8A3.9090100@jg555.com>
In-Reply-To: <43C6A8A3.9090100@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'll try the other patch and also, we ran into this on the build also, 
said we were missing symbol verify_compat_iovec, so I CONFIG_COMPAT that 
one also.

diff -Naur linux-2.6.15.orig/arch/sparc64/kernel/sparc64_ksyms.c linux-2.6.15/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.6.15.orig/arch/sparc64/kernel/sparc64_ksyms.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/arch/sparc64/kernel/sparc64_ksyms.c	2006-01-13 19:28:44.000000000 +0000
@@ -239,7 +239,9 @@
 
 /* Solaris/SunOS binary compatibility */
 EXPORT_SYMBOL(_sigpause_common);
+#ifdef CONFIG_COMPAT
 EXPORT_SYMBOL(verify_compat_iovec);
+#endif
 
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);



-- 
----
Jim Gifford
maillist@jg555.com

