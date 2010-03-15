From: Frans Pop <elendil@planet.nl>
Date: Mon, 15 Mar 2010 17:09:27 +0000
Subject: Serial console issue with 2.6.32
Message-Id: <201003151809.27436.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've got a bit of a puzzler here.

With earlier kernels I can install Debian on my Ultra 10 using 3 methods:
1) headless: without keyboard connected
2) with head: using attached keyboard and monitor
3) with unused head: keyboard connected, but boot with 'console=ttyS0'

With Debian Lenny (2.6.26.x) and the alpha1 installer for Squeeze 
(2.6.30.x) all three methods work.

With a daily built version of the installer (based on 2.6.32.9) the first 
two methods work, but the third doesn't.
At the point where output should start appearing on my remote system, 
minicom shows ttyS0 going offline.

What's visible on the console of the U10 looks the same. With both .30 
and .32 I see the tftp loading of the boot image and the early boot 
messages. Then the screen goes black with only Tux displayed.

I've verified that it's not an issue in the installer by booting with
'BOOT_DEBUG=3', which means that a debug shell is started at the very 
beginning of init, even before busybox init is called. With .30 that 
correctly gives me the debug shell in minicom; with .32 it goes offline 
again.

The exact commands I used to boot are:
   boot net install console=ttyS0
   boot net install console=ttyS0 BOOT_DEBUG=3

Any ideas?

Cheers,
FJP
