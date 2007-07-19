From: Scott Wood <scottwood@freescale.com>
Date: Thu, 19 Jul 2007 15:52:07 +0000
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Message-Id: <20070719155207.GA28617@ld0162-tx32.am.freescale.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
In-Reply-To: <20070720011012.4eca281d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

On Fri, Jul 20, 2007 at 01:10:12AM +1000, Stephen Rothwell wrote:
> The only difference here is that Sparc uses strncmp to match compatibility
> names while PowerPC uses strncasecmp.

Could we put a comment in saying that both should really just use
strcmp(), and that this mechanism should go away once any compatibility
issues are found and addressed?

The PowerPC one will need to drop the 'n' soon, as well, but that should
be a separate patch.

-Scott
