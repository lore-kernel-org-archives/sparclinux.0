From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 08 Sep 2008 01:50:47 +0000
Subject: Re: rtc-m48t59 on an Ultra 5
Message-Id: <20080908015047.GA2265@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080906014432.GA21910@orion.carnet.hr>
In-Reply-To: <20080906014432.GA21910@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Sep 07, 2008 at 06:14:09PM -0700, David Miller wrote:
> > Current sparc-next-2.6 on my Ultra 5 works fine, but the new RTC driver
> > prints the following during boot:
> > 
> > rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
> > rtc-m48t59 rtc-m48t59.0: hctosys: invalid date/time
> > 
> > The system time is okay after boot, though.
> 
> It might be related to this bug fix I just added to the
> sparc-next-2.6 tree:
> 
> sparc64: fix wrong m48t59 RTC year
> 
> Correctly calculate offset to the year register for
> Mostek RTC.

Oh yeah, I forgot to report my test of that patch, sorry. Now the kernel said:

rtc-m48t59 rtc-m48t59.0: setting system clock to 1970-09-06 17:38:55 UTC (21490735)

Userland says:

% sudo hwclock --debug; echo; date
hwclock from util-linux-2.12r
Using /dev/rtc interface to clock.
Last drift adjustment done at 1220722547 seconds after 1969
Last calibration done at 1220722547 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time from /dev/rtc to change
...got clock tick
Time read from Hardware Clock: 1970/09/08 01:49:11
Hw clock time : 1970/09/08 01:49:11 = 21606551 seconds since 1969
Tue Sep  8 02:49:11 1970  -0.803853 seconds

Mon Sep  8 03:49:10 CEST 2008

Is this now ready for a hwclock --systohc or?

-- 
     2. That which causes joy or happiness.
