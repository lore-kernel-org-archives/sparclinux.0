From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 20 Jul 2007 16:11:54 +0000
Subject: Re: sparc64: ERROR: "sys_ioctl" [arch/sparc64/solaris/solaris.ko] undefined!
Message-Id: <20070720161154.GA17382@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <7157.1184937882@laptop13.inf.utfsm.cl>
In-Reply-To: <7157.1184937882@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Fri, Jul 20, 2007 at 09:24:42AM -0400, Horst H. von Brand wrote:
> When building v2.6.22-3478-g275afca on sparc64 (.config attached) I get:
> 
>   MODPOST vmlinux
>   Building modules, stage 2.
>   MODPOST 463 modules
> ERROR: "sys_ioctl" [arch/sparc64/solaris/solaris.ko] undefined!

Sorry, my fault.

It looked to me like sparc64 exports sys_ioctl on it's own, but it only
exports compat_sys_ioctl on it's own.

Here's the fix:

Index: linux-2.6/arch/sparc64/kernel/sparc64_ksyms.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/sparc64_ksyms.c	2007-07-20 17:09:25.000000000 +0200
+++ linux-2.6/arch/sparc64/kernel/sparc64_ksyms.c	2007-07-20 17:09:33.000000000 +0200
@@ -280,6 +280,7 @@ EXPORT_SYMBOL(sys_getgid);
 EXPORT_SYMBOL(svr4_getcontext);
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(compat_sys_ioctl);
+EXPORT_SYMBOL(sys_ioctl);
 EXPORT_SYMBOL(sparc32_open);
 #endif
 
