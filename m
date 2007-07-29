From: Meelis Roos <mroos@linux.ee>
Date: Sun, 29 Jul 2007 19:50:41 +0000
Subject: Cannot access the Hardware Clock
Message-Id: <Pine.SOC.4.64.0707292236210.10801@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I noticed that the current kernels on Ultra5 show the warning
Cannot access the Hardware Clock via any known method.
during both startup when setting clock and during shutdown when saving 
clock. After this line, a message tells that the clock was successfully 
set/saved and the clock is right - so the hwclock program is probably 
doing direct hardware access.

There's no mention of RTC in dmesg. There is also no /dev/rtc but I do 
not know whether it has to exist (it does on my i386 PC).

#
# Real Time Clock
#
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

And this is all that my .config has positive.

It seems CONFIG_RTC is missing, but the option depends on !SPARC and so 
is not present on SPARC64.

-- 
Meelis Roos (mroos@linux.ee)
