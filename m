From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 18 Aug 2005 04:53:39 +0000
Subject: Re: Questions on CPU frequency drivers for UltraSPARC IIe and III
Message-Id: <20050817.215339.15919796.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817221559.71501529@enterprise.weeve.org>
In-Reply-To: <20050817221559.71501529@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Wed, 17 Aug 2005 22:15:59 -0600

> 1) The max frequency for the CPUs appears to be off by 3 decimal places.
> Originally, I had checked with cpufreq-info from the cpufrequtils
> package[1], and then later confirmed by checking the
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq file by hand. 
> The values I was getting were 502000000 (502.00 GHz) on a 500 MHz Blade
> 100 and 750000000 (750.00 GHz) on either CPU in a dual 750 MHz Blade
> 1000.  I'm guessing this is a problem with how the speeds are being
> reported to sysfs?

That's definitely a bug.  I'll try to figure out how I'm off
by a factor of 1000 :-)

> 2) The minimum CPU frequencies possible being reported for the Blade 100
> and Blade 1000 are 62750000 and 23437500 respectively.  Are these
> accurate (even with the possibility mentioned above being taken into
> account)?  They seem a bit low to me (based on what I've seen from the
> x86 world).

It looks right.

The UltraSPARC-III has three clock divisor values you can use, 1, 2,
and 32.  I know that seems weird, but that is what the chip supports.

UltraSPARC-IIe supports divisors 1, 2, 4, 6, and 8, so the IIe number
looks correct as well.

> 3) On x86, amd64 and PPC, there exists a file called
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq which shows the
> current running frequency of the CPU.  For both the IIe and III cpufreq
> drivers, this is missing.  Is there any reason for this (like no good
> way to poll the CPUs) or is it just a possible change in cpufreq stuff
> that wasn't synced up with sparc?

Strange, I'll try to figure out this bug as well.

Thanks for the report.
