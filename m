From: David Miller <davem@davemloft.net>
Date: Wed, 02 Dec 2009 22:57:44 +0000
Subject: Re: No MC sched domains
Message-Id: <20091202.145744.191835562.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 2 Dec 2009 19:41:34 +0100 (CET)

> the T1 is said to be multi-core, however, I am not seeing any MC sched 
> levels in dmesg as I do on x86. Why is that?

The T1 cores are repesented as SMT units.

On multi-chip T2 systems such as 5140 et al., we use MC to repesent
the physical CPU chips.

So the hierarchy is MC --> SMT

See arch/sparc/kernel/smp_64.c:smp_fill_in_sib_core_maps() and it's
callers, which scan the hierarchy (using either the OpenFirmware device
tree or the sun4v Machine Description).
