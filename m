From: Jim Gifford <maillist@jg555.com>
Date: Thu, 12 Jan 2006 21:32:13 +0000
Subject: Re: Build Issue - Sparc64
Message-Id: <43C6CADD.30602@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <43C6A8A3.9090100@jg555.com>
In-Reply-To: <43C6A8A3.9090100@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jim Gifford wrote:

> Anyone got any ideas. This is from the 2.6.15 build. We are doing some 
> testing building a 64 bit kernel with no 32 bit support  for testing 
> purposes and we ran into this error. GCC 4, Binutils 2.16.1, Glibc 2.3.6.
>
> cc1: warnings being treated as errors
> arch/sparc64/kernel/process.c: In function 'show_regwindow32':
> arch/sparc64/kernel/process.c:174: warning: implicit declaration of 
> function 'compat_ptr'
> arch/sparc64/kernel/process.c:174: warning: assignment makes pointer 
> from integer without a cast
> make[1]: *** [arch/sparc64/kernel/process.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
>
Fixed the issue with this patch.

--- process.c.orig      2006-01-12 13:27:03.000000000 -0800
+++ process.c   2006-01-12 13:28:21.000000000 -0800
@@ -164,6 +164,7 @@
       panic("Reboot failed!");
}

+#ifdef CONFIG_COMPAT
static void show_regwindow32(struct pt_regs *regs)
{
       struct reg_window32 __user *rw;
@@ -189,6 +190,7 @@
              r_w.ins[0], r_w.ins[1], r_w.ins[2], r_w.ins[3],
              r_w.ins[4], r_w.ins[5], r_w.ins[6], r_w.ins[7]);
}
+#endif

static void show_regwindow(struct pt_regs *regs)
{
@@ -214,7 +216,11 @@
                       set_fs (old_fs);
               }
       } else {
-               show_regwindow32(regs);
+               #ifdef CONFIG_COMPAT
+                       show_regwindow32(regs);
+               #else
+                       show_regwindow(regs);
+               #endif
               return;
       }
       printk("l0: %016lx l1: %016lx l2: %016lx l3: %016lx\n",


-- 
----
Jim Gifford
maillist@jg555.com

