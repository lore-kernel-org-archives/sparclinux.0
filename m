From: Bob Breuer <breuerr@mc.net>
Date: Thu, 09 Dec 2004 03:30:18 +0000
Subject: Re: Sparc32 - SS5 - TCX-Framebuffer und RTC
Message-Id: <41B7C6CA.3070501@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41B7752C.90808@triaton-webhosting.com>
In-Reply-To: <41B7752C.90808@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Georg Chini wrote:
 > Hello,
 >
 > when compiling 2.6.10-rc3 for my SS5 I have
 > following problems:
 >
 > 1) TCX-Framebuffer:
...
 >    b) FB-Console does not work:
 >       When I boot the system with FB-Console I get a blank
 >       black screen. System boots fine, only nothing is
 >       displayed.

I had a similar problem with the cg14 framebuffer, maybe this snippet from
the cg14 fix will help you:

@@ -484,8 +493,11 @@
   	spin_lock_init(&all->par.lock);

   	sbusfb_fill_var(&all->info.var, node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;

@@ -561,6 +573,7 @@
   		kfree(all);
   		return;
   	}
+	fb_set_cmap(&all->info.cmap, &all->info);

   	cg14_init_fix(&all->info, linebytes);


 >
 > 2) RTC:
 >    When compiling with RTC-support I get following messages
 >    from make image:
 >
 >   ...
 >
 >       CC      drivers/sbus/char/rtc.o
 >     drivers/sbus/char/rtc.c: In function `get_rtc_time':
 >     drivers/sbus/char/rtc.c:33: warning: initialization makes integer
 > from pointer without a cast
 >     drivers/sbus/char/rtc.c:38: warning: implicit declaration of
 > function `readb'
 >     drivers/sbus/char/rtc.c:40: warning: implicit declaration of
 > function `writeb'
 >     drivers/sbus/char/rtc.c: In function `set_rtc_time':
 >     drivers/sbus/char/rtc.c:60: warning: initialization makes integer
 > from pointer without a cast
 >

Broken by a recent change in include/asm-sparc/mostek.h, need to include
<asm/io.h> from there now.

Does anyone know if sbus_readb/sbus_writeb should be used there instead of
readb/writeb ?

Bob

