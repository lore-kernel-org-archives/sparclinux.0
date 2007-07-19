From: Paul Mackerras <paulus@samba.org>
Date: Thu, 19 Jul 2007 23:27:06 +0000
Subject: Re: [PATCH 01/12] Split out common parts of prom.h
Message-Id: <18079.62282.890470.115431@cargo.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

Stephen Rothwell writes:

> This creates linux/of.h and includes asm/prom.h from it.
> 
> We also include linux/of.h from asm/prom.h while we transition.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>

for all 12 of the series.
