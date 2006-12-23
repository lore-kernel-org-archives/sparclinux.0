From: richm@oldelvet.org.uk
Date: Sat, 23 Dec 2006 23:35:44 +0000
Subject: Re: Oops during boot on Netra X1 with 2.6.18 in
Message-Id: <2831.192.168.1.203.1166916944.squirrel@bridge.oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20061223191932.GA4749@droopy.oc.cox.net>
In-Reply-To: <20061223191932.GA4749@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

> Richard Mortimer (CC'd) reported an oops when booting 2.6.18 on
> Netra X1. Richard writes:
>
>> I believe that the problem is due to a null pointer being returned
>> from of_get_property in isa_dev_get_resource()
>> arch/sparc64/kernel/isa.c. Enclosed is a disassembly of the
>> appropriate bit of code along with the prtconf -pv output for the
>> isa device tree. I wonder if the problem might be the fact that the
>> todm5819 node does not have "reg" properties.
>
> All the debugging information is included in Debian bug report at
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug@4216

I've just got myself an uptodate git tree and confirmed the same problem
in 2.6.20 and have (hopefully) sent a couple of patches to DaveM that
fix the problem and remove some unused function parameters.

I haven't tried the fix on Debian/2.6.18 yet but expect that it will
work there too.

Side note: 2.6.20 wasn't happy with the networks (I gave up waiting
in the end) but it was reporting lots of unaligned accesses. I haven't
took a look to identify the offending bits of code/structures but
following are typical console messages.

Kernel unaligned access at TPC[51cf0c] Kernel unaligned access at TPC[51cf0c]
ip_fast_csum+0x14/0x80
ip_fast_csum+0x14/0x80
Kernel unaligned access at TPC[51cf14] Kernel unaligned access at TPC[51cf14]
ip_fast_csum+0x1c/0x80
ip_fast_csum+0x1c/0x80
Kernel unaligned access at TPC[5f1534] Kernel unaligned access at TPC[5f1534]
ip_rcv+0xd0/0x588
ip_rcv+0xd0/0x588
Kernel unaligned access at TPC[51cf04] Kernel unaligned access at TPC[51cf04]
ip_fast_csum+0xc/0x80
ip_fast_csum+0xc/0x80
Kernel unaligned access at TPC[51cf08] Kernel unaligned access at TPC[51cf08]
ip_fast_csum+0x10/0x80
ip_fast_csum+0x10/0x80


Regards

Richard


