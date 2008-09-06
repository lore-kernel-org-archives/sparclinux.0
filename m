From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 06 Sep 2008 01:44:32 +0000
Subject: rtc-m48t59 on an Ultra 5
Message-Id: <20080906014432.GA21910@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Current sparc-next-2.6 on my Ultra 5 works fine, but the new RTC driver
prints the following during boot:

rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
rtc-m48t59 rtc-m48t59.0: hctosys: invalid date/time

The system time is okay after boot, though.

% sudo ln -s rtc0 /dev/rtc
% sudo hwclock --debug; echo; date
hwclock from util-linux-2.12r
Using /dev/rtc interface to clock.
Last drift adjustment done at 1220663753 seconds after 1969
Last calibration done at 1220663753 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time from /dev/rtc to change
...got clock tick
Time read from Hardware Clock: 1940/09/06 01:42:03
Hw clock time : 1940/09/06 01:42:03 = -925251477 seconds since 1969
Fri Sep  6 02:42:03 1940  -0.646109 seconds

Sat Sep  6 03:42:03 CEST 2008

Should I be worried? :)

-- 
     2. That which causes joy or happiness.
