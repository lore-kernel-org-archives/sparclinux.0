From: Robert Reif <reif@earthlink.net>
Date: Thu, 04 Sep 2008 02:15:21 +0000
Subject: Re: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <48BF44B9.6030303@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> Older hwclock binaries won't look for /dev/rtc0, newer ones do.
> So the symlink is necessary for machines with the older binary.
>
>   
>> Time read from Hardware Clock: 2108/09/04 01:30:25
>> Invalid values in hardware clock: 2108/09/04 01:30:25
>>     
>
> Hmmm, 100 years too large, that looks familiar.
>
> Krzysztof?
>
>   
With newer version and symlink removed:

ss20-1:~/hwclock-2.32# ./hwclock --debug
hwclock 2.32
Kernel IS in 11 minute mode
User did not specify a clock access method.  Searching for one...
Found RTC device special file '/dev/rtc0'
Using rtc ioctl interface to clock via file '/dev/rtc0'.
Adjtime file contents:
  drift factor = 0.021200, missed in last set = 0.000000
  UTC (0 seconds west of GMT), epoch = -1
  Last drift adjustment done Wed Sep  3 21:10:23 2008 (Time 1220490623) 
+ 0.000000 secs
  Last calibration done Wed Sep  3 21:10:23 2008 (Time 1220490623)
  Correction: 0.000000
Not booted from MILO
Assuming hardware clock's zero year is 1900
Assuming hw clock is kept in UTC time with offset 0 mins.
At 1220494343.809750, waiting for clock tick...
RTC device does not have interrupt functions.
Waiting in loop for time from rtc device driver to change
...got clock tick at system time 1220494344.499652
Raw time read from Hardware Clock: Y!08 M=9 D=4 02:12:24
mktime_tz: TZ environment variable is not set.
mktime_tz: temporarily setting TZ to HWCLOCK_TEMP +00:00
Invalid values in hardware clock: 208/09/04 02:12:24
hwclock: The Hardware Clock registers contain values that are either 
invalid (e.g. 50th day of month) or beyond the range we can handle (e.g. 
Year 2095).
new timezone offset for hardware clock is 0



