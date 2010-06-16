From: David Miller <davem@davemloft.net>
Date: Wed, 16 Jun 2010 20:38:54 +0000
Subject: Re: Error "Unknown relocation: 36" on module load on Sparc
Message-Id: <20100616.133854.183053376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTimuv7nOlcGFxqPZlwcAjLmFMiLAvbA5O7F32Wbg@mail.gmail.com>
	<4C192085.2090404@vlnb.net>
	<20100616192257.GW20317@bombadil.infradead.org>
In-Reply-To: <20100616192257.GW20317@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kyle@mcmartin.ca
Cc: vst@vlnb.net, sparclinux@vger.kernel.org, simone.ricci@gmail.com, scst-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Nick.Couchman@seakr.com

From: Kyle McMartin <kyle@mcmartin.ca>
Date: Wed, 16 Jun 2010 15:22:57 -0400

> arch/sparc/kernel/module.c needs to be patched to support the new
> relocation type... Based on binutils/gas/config/tc-sparc.c and gold's
> sparc config this looks to be the same as the hi22 reloc...
> 
> Can you test the following patch?

This change is incorrect.

LM22 relocations do not get emitted for the "medlow" code model, which
is what is explicitly specified on the kernel compiler command line
for sparc64 via "-mcmodel=medlow".

Someone this person is using incorrect CFLAGS when building their
module, and that's why they have this problem, because the compiler's
default code model on sparc64 can generate those relocations.
