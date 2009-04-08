From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2009 23:02:08 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408.160208.88224106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: seb@frankengul.org
Date: Thu, 9 Apr 2009 01:01:01 +0200

> On Wed, Apr 08, 2009 at 03:45:53PM -0700, David Miller wrote:
>> > Strange, with arch_initcall(pcr_arch_init); commented, the kernel builds fine;
>> > 
>> > However, the good news is that this kernel boots fine.
>> 
>> I suspect it will boot fine if you wait for the NMI tester to
>> timeout too.
> 
> Hum, how long does it takes to timeout ?

It can take from 20 to 30 seconds, for each processor.
