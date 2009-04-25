From: David Miller <davem@davemloft.net>
Date: Sat, 25 Apr 2009 10:20:04 +0000
Subject: Re: Fire V880 hangs at Testing NMI with 2.6.29.1
Message-Id: <20090425.032004.238238461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090421103557.GZ15865@ltw.loris.tv>
In-Reply-To: <20090421103557.GZ15865@ltw.loris.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: adi@drcomp.erfurt.thur.de (Adrian Knoth)
Date: Sat, 25 Apr 2009 10:34:14 +0200

> On Fri, Apr 24, 2009 at 08:37:56AM -0700, David Miller wrote:
> 
>> >      ERROR: Power On Self Test Failed. Cause: 
>> > CPU0 Bank 1 Dimm 3, J3200 side 1
>> >      ERROR: POST failed.
>> Just FYI, you have some serious RAM problems in this machine.
> 
> That's why the whole CPU0+2 board is offlined.

So which cpus usually come up?  I see 1, 4, 5, 6, 7 come up after
the boot processor.  I wonder what number the boot processor is?

You can tell by what number shows up in-between {} braces in the
OBP firmware prompt.
