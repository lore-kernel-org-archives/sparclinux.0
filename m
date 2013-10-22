From: David Miller <davem@davemloft.net>
Date: Tue, 22 Oct 2013 17:54:42 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20131022.135442.1072093301788210177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130617055839.GB3073@blackmetal.musicnaut.iki.fi>
	<20130803.134042.2228681844349448961.davem@davemloft.net>
	<20131022174612.GC24448@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20131022174612.GC24448@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@iki.fi
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 22 Oct 2013 20:46:12 +0300

> Hi,
> 
> On Sat, Aug 03, 2013 at 01:40:42PM -0700, David Miller wrote:
>> > On Mon, Jun 17, 2013 at 08:32:25AM +0300, Aaro Koskinen wrote:
>> >> On Mon, Jun 17, 2013 at 12:06:00AM +0300, Meelis Roos wrote:
>> >> > Got this in 3.10-rc6 whil testing debian unstable upgrade with aptitude. 
>> >> > 3.10-rc5 did not exhibit this (nor any other kernel recently tried, 
>> >> > including most -rc's). Does not seem to be reproducible.
>> >> 
>> >> I get this regularly on Ultrasparc during long compilations. It's been
>> >> there with all recent kernels (probably at least since 3.8). Latest I
>> >> saw with 3.10-rc5.
>> > 
>> > Two examples:
>> 
>> Thanks for the reports, I'm actively looking into this.
> 
> Got this again with 3.12-rc5 while doing GCC 4.8.2 bootstrap (during
> make check phase):
 ...
> The box didn't die yet... Let's hope it will let GCC testsuite to finish.

Thanks for reporting this again, it's in my long TODO list to look into
still.
