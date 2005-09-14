From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 14 Sep 2005 16:31:09 +0000
Subject: Re: Sun v440 and 2.6.13-1.1552sp1smp (Aurora) kernel
Message-Id: <20050914.093109.101332606.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Wed, 14 Sep 2005 12:42:29 -0300

> No kernel is rock-solid stable on the v240, though 2.4 lasts longer.
> I'm guessing it has to do with IIIi SMP since we get tons of "CPU[1]:
> Cheetah+ D-cache parity error at TPC[00000000005d3328]" (with varying
> CPU number and addresses) before one of the processors goes offline/gets
> stuck at which point it's time to reboot.

Known SMP bug with UltraSPARC-IIIi processors.  They can randomly hang
during an L2 cache transaction, and the only way to get them unstuck
is to gain ownership of an L2 cache line (from the other cpu which is
still alive) that stuck processor holds.

I'm not willing to work on a workaround for this chip errata until
I have physical access to an SMP UltraSPARC-IIIi system for several
weeks.
