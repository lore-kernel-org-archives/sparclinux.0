From: Meelis Roos <mroos@linux.ee>
Date: Mon, 09 Jun 2014 06:36:33 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1406090931470.5548@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140425200908.GG575@drone.musicnaut.iki.fi> <20140425.161753.153968588224593753.davem@davemloft.net> <alpine.SOC.1.00.1405242301090.18040@math.ut.ee> <20140524.170834.1561021346958622230.davem@davemloft.net>
In-Reply-To: <20140524.170834.1561021346958622230.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

> > This is todays fresh git with 3.15.0-rc6-00190-g1ee1cea on V210, THP 
> > enabled & always on. Got this and a segfault on apt-spawned xz.
> 
> Thanks a lot for the report.
> 
> I've been bogged down with other things but I will come back to
> this stuff soon.

Just to document a strangeness that does not seem to fit the pattern of 
UltraSparc III era split: 

V210 with USIII family CPUs is still problematic (can not survive 
repetituos local git clone, hangs (watchdog detects hang) with 
filesystem corruption. This still holds for 3.15 release.

On the other hand, E420R with 4 USII CPUs does not hang and works 100% 
stable with git clones etc. Very similar E220R with different config 
hangs on that load.

Maybe related to some other options in kernel configs - each config is 
unique and they vary intentionally.

-- 
Meelis Roos (mroos@linux.ee)
