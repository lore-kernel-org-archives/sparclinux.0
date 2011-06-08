From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jun 2011 21:56:57 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <20110608.145657.2151295114053722398.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 8 Jun 2011 15:02:36 +0300 (EEST)

> I noticed the clock was wrong on my Netra T1 (running 3.0.0-rc2 and 
> not having ntp and ntpdate installed). Installing ntp, ntpdate and 
> updating the clock with ntpdate worked. But reboot did not set the 
> correct time and hwclock also fails:
> 
> # hwclock --systohc
> Timed out waiting for time change.
> 
> Dmesg finds both OF RTC and PC RTC but later complains
> "No RTC device found, ALARM timers will not wake from suspend"

This started happening in 2.6.39, I noticed it but didn't have any
time to look into it.

It's due to a RTC layer change of some kind, you can probably git
bisect through drivers/rtc between v2.6.39-rc1 and v2.6.39 to find the
guilty commit.

Something like: "git bisect start v2.6.39 v2.6.39-rc1 drivers/rtc"
