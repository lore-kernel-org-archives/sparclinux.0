From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2008 22:29:25 +0000
Subject: Re: machine_power_off unaligned access
Message-Id: <20080910.152925.16891608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080910215818.GA1696@orion.carnet.hr>
In-Reply-To: <20080910215818.GA1696@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 10 Sep 2008 23:58:18 +0200

> I just happened to notice this with 2.6.25.5 on the Fire 280R:
> 
> Mounting root filesystem read-only...done.
> Will now halt.
> sd 0:0:1:0: [sdb] Synchronizing SCSI cache
> Power down.
> Kernel unaligned access at TPC[436980] machine_power_off+0x54/0xbc
> Program terminated
> {1} ok 
> 
> FWIW...

That code got deleted in sparc-next-2.6 because of how wrong it is.

But, thanks for the report.
