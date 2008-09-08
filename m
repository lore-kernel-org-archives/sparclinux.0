From: Robert Reif <reif@earthlink.net>
Date: Mon, 08 Sep 2008 03:25:13 +0000
Subject: Re: rtc-m48t59 on an Ultra 5
Message-Id: <48C49B19.8010305@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080906014432.GA21910@orion.carnet.hr>
In-Reply-To: <20080906014432.GA21910@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Josip Rodin wrote:
> % sudo hwclock --debug; echo; date
> hwclock from util-linux-2.12r
> Using /dev/rtc interface to clock.
>   
I have similar problems with debian etch on sparc32.  hwclock
only supports /dev/rtc.  Upgrading hwclock is problematic because there
are 3 different versions (original hwclock, linux-util and linux-util-ng)
and they require init.d script changes.  Superblock times are also
corrupted with bad dates and fails fsck which immediately causes a
reboot.  Fixing it requires mounting the drive on another system and
running fsck to fix the times.  This is a real pain because I haven't
been able to find a combination that boots both the stock debian etch
kernel and sparc-next.

Is there any way to have the the rtc device show up as /dev/rtc?
