From: David Miller <davem@davemloft.net>
Date: Thu, 03 Dec 2009 22:02:01 +0000
Subject: Re: No MC sched domains
Message-Id: <20091203.140201.113313360.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Thu, 3 Dec 2009 22:55:29 +0100 (CET)

> On Wednesday 2009-12-02 23:57, David Miller wrote:
>>The T1 cores are repesented as SMT units.
> 
> It seems so.
> 
> /sys/devices/system/cpu/
> cpu0/topology/physical_package_id:0
> cpu1/topology/physical_package_id:0
> cpu10/topology/physical_package_id:2
> cpu11/topology/physical_package_id:2
> cpu12/topology/physical_package_id:3
> cpu13/topology/physical_package_id:3
> cpu14/topology/physical_package_id:3
> cpu15/topology/physical_package_id:3
> cpu16/topology/physical_package_id:4
> ...
> 
> Why is this done, when they are, in fact, not multiple physical 
> packages?

Because I need two levels of grouping to represent chips like T2.

I use SMT to represent the cores.

And I use MC to represent the 2 integer units within a core on T2.
