From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Wed, 08 Dec 2004 21:42:04 +0000
Subject: Sparc32 - SS5 - TCX-Framebuffer und RTC
Message-Id: <41B7752C.90808@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

when compiling 2.6.10-rc3 for my SS5 I have
following problems:

1) TCX-Framebuffer:
    a) drivers/video/tcx.c:
       prom->devname is "SUNW,tcx", not "tcx" in line 469,
       so the framebuffer will not be detected without
       changing that line.
    b) FB-Console does not work:
       When I boot the system with FB-Console I get a blank
       black screen. System boots fine, only nothing is
       displayed.
    c) X will not work in 8-Bit mode:
       Only 32-Bit mode works, maybe this is connected to b)?

2) RTC:
    When compiling with RTC-support I get following messages
    from make image:

   ...

       CC      drivers/sbus/char/rtc.o
     drivers/sbus/char/rtc.c: In function `get_rtc_time':
     drivers/sbus/char/rtc.c:33: warning: initialization makes integer from pointer without a cast
     drivers/sbus/char/rtc.c:38: warning: implicit declaration of function `readb'
     drivers/sbus/char/rtc.c:40: warning: implicit declaration of function `writeb'
     drivers/sbus/char/rtc.c: In function `set_rtc_time':
     drivers/sbus/char/rtc.c:60: warning: initialization makes integer from pointer without a cast

    ...

       LD      arch/sparc/boot/image
     drivers/built-in.o(.text+0x3bca8): In function `get_rtc_time':
     : undefined reference to `readb'
     drivers/built-in.o(.text+0x3bcb8): In function `get_rtc_time':
     : undefined reference to `writeb'
     drivers/built-in.o(.text+0x3bdc0): In function `get_rtc_time':
     : undefined reference to `readb'
     drivers/built-in.o(.text+0x3bdcc): In function `get_rtc_time':
     : undefined reference to `writeb'
     drivers/built-in.o(.text+0x3bdf4): In function `set_rtc_time':
     : undefined reference to `readb'
     drivers/built-in.o(.text+0x3be04): In function `set_rtc_time':
     : undefined reference to `writeb'
     drivers/built-in.o(.text+0x3bfc0): In function `set_rtc_time':
     : undefined reference to `readb'
     drivers/built-in.o(.text+0x3bfcc): In function `set_rtc_time':
     : undefined reference to `writeb'
     make[1]: *** [arch/sparc/boot/image] Error 1
     make: *** [image] Error 2


Can somebody help me to solve my problems or point me to what to do?

Regards
        Georg Chini

