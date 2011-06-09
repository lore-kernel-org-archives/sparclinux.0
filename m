From: Meelis Roos <mroos@linux.ee>
Date: Thu, 09 Jun 2011 09:54:51 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <alpine.SOC.1.00.1106091251270.3519@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > # hwclock --systohc
> > Timed out waiting for time change.
> > 
> > Dmesg finds both OF RTC and PC RTC but later complains
> > "No RTC device found, ALARM timers will not wake from suspend"
> 
> This started happening in 2.6.39, I noticed it but didn't have any
> time to look into it.
> 
> It's due to a RTC layer change of some kind, you can probably git
> bisect through drivers/rtc between v2.6.39-rc1 and v2.6.39 to find the
> guilty commit.
> 
> Something like: "git bisect start v2.6.39 v2.6.39-rc1 drivers/rtc"

These 2 - hwclock and No RTC device - appear to be independent problems. 

The later one appeared during 2.6.39 cycle and I am bisecting it now. 

The hwclock problem seems to have apperaed between 2.6.37 and 2.6.38 and 
I will bisect it later.

-- 
Meelis Roos (mroos@linux.ee)
