From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jul 2010 02:22:21 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <20100705.192221.241453945.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100629193618.5a840b8e@dev.queued.net>
	<AANLkTilme2uAoXjorUEzam9j_xosR8kl70W8PS71d-Th@mail.gmail.com>
	<20100707040734.05d625af@debxo>
In-Reply-To: <20100707040734.05d625af@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dilinger@queued.net
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, wmb@laptop.org, pgf@laptop.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org

From: Andres Salomon <dilinger@queued.net>
Date: Wed, 7 Jul 2010 04:07:34 +0000

>  - For the pdt, calling into the prom once for each property/node to
>    create a fdt, and then unflattening it.  This is better than the
>    previous option, but I don't think the prom->fdt code will be very
>    nice.

I'll need this on sparc64 at some point to support kexec() anyways.

So at least for sparc you can assume that a something-->fdt translator
is going to exist at some point in the future regardless of what
happens here.

