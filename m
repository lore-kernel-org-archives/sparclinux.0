From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 18:33:11 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <20051010.113311.55634660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 18:19:29 +0300 (EEST)

> l0: 0000000000055114 l1: 00000000f005634f l2: 0000000000000001 l3: 0000000000000000
> l4: 0000000000000013 l5: 0000000000000013 l6: 0000000000000000 l7: 00000000003b0a20
> i0: 0000000000719840 i1: 0000000000719800 i2: 0000000000719908 i3: 0000000000000003
> i4: 0000000000000000 i5: 0000000000000000 i6: 00000000fffa95b1 i7: 000000000050822c
> I7: <prom_cif_interface+0xac/0x134>
> Instruction DUMP: 8a016004  ca700006  8a03e008 <e0016000> 81c40002 
> 8a016004  c8700007  8803e008  e0016000

Actually, we are calling into the firmware explicitly.
Can you get a deeper call trace?  So we can see who is calling
prom_cif_interface() and likewise that function's caller as well?

We need this information in order to debug this.

