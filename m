From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 23 Dec 2004 06:37:30 +0000
Subject: 2.6.10-rc3-wli-1
Message-Id: <20041223063730.GY771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org

Here it is. All sparc32 updates.

Most critical here are the HyperSPARC and sun4d updates as they get
things booting that weren't before, though neither fixes things all
the way. Another pretty nasty failure-to-boot issue that brings down
distro kernels is also resolved with Jurij Smakov's initrd memcpy() fix.

The main purpose of all this is so that sparc32 hackers and users can
see what's in and what isn't so they can complain about the fixes that
didn't get in and then I can include those when they remind me.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.6.10-rc3/2.6.10-rc3-wli-1/2.6.10-rc3-wli-1.patch.bz2

+ linus.patch
	sync with last night's bk
+ fix-hypersparc-dvma.patch
	fix DVMA on UP HyperSPARC
+ newport-sun4d.patch
	Christ Newport and Thomas Bogendoerfer's sun4d work
+ jurij-initrd-memcpy.patch
	Jurij Smakov's memcpy() fixes
+ svr4-setcontext-return.patch
	return something in an error path of svr4_setcontext()
+ pcic-warnings.patch
	kill off some warnings in pcic.c
+ sunsu-warnings.patch
	kill off some warnings in sunsu.c
+ rtc-warnings.patch
	kill off some sparc RTC driver warnings
+ vm-fault-codes.patch
	fix up VM fault code handling
+ spot-floppy-fix.patch
	Tom Callaway's include/asm-sparc/floppy.h fixes
+ spot-exit-fix.patch
	Tom Callaway's include/asm-sparc/unistd.h fixes
+ defconfig-update.patch
	Tentative defconfig update. Bug wli if you want an option
	turned on in the defconfig.
+ kropelin-breuer-cg6.patch
	Adam Kropelin and Bob Breuer's cg6 fixes


-- wli
