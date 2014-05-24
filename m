From: David Miller <davem@davemloft.net>
Date: Sat, 24 May 2014 21:08:34 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140524.170834.1561021346958622230.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140425200908.GG575@drone.musicnaut.iki.fi>
	<20140425.161753.153968588224593753.davem@davemloft.net>
	<alpine.SOC.1.00.1405242301090.18040@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1405242301090.18040@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

From: mroos@linux.ee
Date: Sat, 24 May 2014 23:02:28 +0300 (EEST)

> This is todays fresh git with 3.15.0-rc6-00190-g1ee1cea on V210, THP 
> enabled & always on. Got this and a segfault on apt-spawned xz.

Thanks a lot for the report.

I've been bogged down with other things but I will come back to
this stuff soon.
