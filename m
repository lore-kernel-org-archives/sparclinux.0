From: David Miller <davem@davemloft.net>
Date: Sat, 03 Aug 2013 20:40:42 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20130803.134042.2228681844349448961.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1306162346340.23595@math.ut.ee>
	<20130617053225.GA3073@blackmetal.musicnaut.iki.fi>
	<20130617055839.GB3073@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130617055839.GB3073@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@iki.fi
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 17 Jun 2013 08:58:39 +0300

> On Mon, Jun 17, 2013 at 08:32:25AM +0300, Aaro Koskinen wrote:
>> On Mon, Jun 17, 2013 at 12:06:00AM +0300, Meelis Roos wrote:
>> > Got this in 3.10-rc6 whil testing debian unstable upgrade with aptitude. 
>> > 3.10-rc5 did not exhibit this (nor any other kernel recently tried, 
>> > including most -rc's). Does not seem to be reproducible.
>> 
>> I get this regularly on Ultrasparc during long compilations. It's been
>> there with all recent kernels (probably at least since 3.8). Latest I
>> saw with 3.10-rc5.
> 
> Two examples:

Thanks for the reports, I'm actively looking into this.
