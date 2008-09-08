From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 08 Sep 2008 15:13:13 +0000
Subject: Re: rtc-m48t59 on an Ultra 5
Message-Id: <20080908171313.92cf1815.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080906014432.GA21910@orion.carnet.hr>
In-Reply-To: <20080906014432.GA21910@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 07 Sep 2008 23:25:13 -0400
Robert Reif <reif@earthlink.net> wrote:

> Josip Rodin wrote:
> > % sudo hwclock --debug; echo; date
> > hwclock from util-linux-2.12r
> > Using /dev/rtc interface to clock.
> >   
> I have similar problems with debian etch on sparc32.  hwclock
> only supports /dev/rtc.  Upgrading hwclock is problematic because there
> are 3 different versions (original hwclock, linux-util and linux-util-ng)
> and they require init.d script changes.  Superblock times are also
> corrupted with bad dates and fails fsck which immediately causes a
> reboot.  Fixing it requires mounting the drive on another system and
> running fsck to fix the times.  This is a real pain because I haven't
> been able to find a combination that boots both the stock debian etch
> kernel and sparc-next.
> 
> Is there any way to have the the rtc device show up as /dev/rtc?
> 

There are few things which can improve your situation:

1. Rebuild the kernel with  CONFIG_RTC_HCTOSYS option set.
It is named "Set system time from RTC on startup and resume"
This make system use the rtc0 (you can set it up in configuration
as well) to get initial time and date.

2. Add "ln -s /dev/rtc0 /dev/rtc" to your booting scripts before
the hwclock (or ntp) is used for the first time.

3. Define udev rule (if you use udev) to create /dev/rtc link to 
the /dev/rtc0.

Regards,
Krzysztof
