From: Robert Reif <reif@earthlink.net>
Date: Thu, 04 Sep 2008 01:42:54 +0000
Subject: Re: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <48BF3D1E.503@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Krzysztof Helt wrote:
> Robert, please test it on as many machine as you can.
>
>   
With latest sparc-next, my ss20 boots now but the clock is suspect.

Time is initially set to Dec 31, 1969 but ntp fixes it.

I'm using debian etch so I'm not sure it's setup for generic rtc.
I had to make a link for /dev/rtc to get things somewhat working.
This could be a bad NVRAM but openboot doesn't complain.

ss20-1:/dev# ln -s rtc0 rtc
ss20-1:/dev# /sbin/hwclock --debug
hwclock from util-linux-2.12r
Using /dev/rtc interface to clock.
Last drift adjustment done at 1220490623 seconds after 1969
Last calibration done at 1220490623 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time 
from /dev/rtc to change
...got clock tick
Time read from Hardware Clock: 2108/09/04 01:30:25
Invalid values in hardware clock: 2108/09/04 01:30:25
The Hardware Clock registers contain values that are either invalid 
(e.g. 50th day of month) or beyond the range we can handle (e.g. Year 2095).
ss20-1:/dev# date
Wed Sep  3 21:30:52 EDT 2008

