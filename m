From: David Miller <davem@davemloft.net>
Date: Sat, 15 Sep 2007 22:36:02 +0000
Subject: Re: SPARC{,64}: kernel_termios_to_user_termios_1 missing
Message-Id: <20070915.153602.74747413.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200709152137.l8FLbtXP001446@laptop13.inf.utfsm.cl>
In-Reply-To: <200709152137.l8FLbtXP001446@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vonbrand@inf.utfsm.cl
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Sat, 15 Sep 2007 17:37:55 -0400

> git-describe says this is v2.6.23-rc6-168-g53a3f30
> I'm getting:
> 
>   drivers/char/tty_ioctl.c: In function 'n_tty_ioctl':
>   drivers/char/tty_ioctl.c:799: error: implicit declaration of function 'kernel_termios_to_user_termios_1'
> 
> This is a macro at the very end of include/asm-<foo>/termios.h for i686, on
> SPARC and SPARC64 it is missing. Sorry, I've got no clue on how to define
> this correctly here.
> 
> It is also missing on alpha, blackfin, parisc, sh64, sh, xtensa

This has been reported and discussed extensively on the lists
over the past 4 or 5 days.

It is a well known issue, and if you just need to get the sparc64
build working so you can test it out just use the patch below:

diff --git a/include/asm-sparc/termios.h b/include/asm-sparc/termios.h
index d767f20..25e9cbb 100644
--- a/include/asm-sparc/termios.h
+++ b/include/asm-sparc/termios.h
@@ -142,6 +142,11 @@ struct winsize {
 	0; \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) \
+	user_termios_to_kernel_termios(k, u)
+#define kernel_termios_to_user_termios_1(u, k) \
+	kernel_termios_to_user_termios(u, k)
+
 #endif	/* __KERNEL__ */
 
 #endif /* _SPARC_TERMIOS_H */
diff --git a/include/asm-sparc64/termios.h b/include/asm-sparc64/termios.h
index f05d390..6fc71e6 100644
--- a/include/asm-sparc64/termios.h
+++ b/include/asm-sparc64/termios.h
@@ -145,6 +145,11 @@ struct winsize {
 	err; \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) \
+	user_termios_to_kernel_termios(k, u)
+#define kernel_termios_to_user_termios_1(u, k) \
+	kernel_termios_to_user_termios(u, k)
+
 #endif	/* __KERNEL__ */
 
 #endif /* _SPARC64_TERMIOS_H */
