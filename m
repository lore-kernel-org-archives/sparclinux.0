From: "Fabio M. Di NItto" <fabbione@fabbione.net>
Date: Wed, 05 Jan 2011 19:38:17 +0000
Subject: Re: sb-100 bootup hangs...
Message-Id: <4D24C8A9.70503@fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.112012.183041683.davem@davemloft.net>
In-Reply-To: <20110105.112012.183041683.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/05/2011 08:20 PM, David Miller wrote:
> 
> Sam, just FYI, I think I know what this bug is, I've been helping
> Fabio hunt down a similar bug on his machine, and he generated enough
> debug info for me to work on a fix.
> 
> The issue is that the atyfb_setup_sparc() code in the ATY driver is
> doing direct PROM calls to fetch information from the device tree, and
> it's doing it in such a way that we will violate the PROM restrictions
> that we can only pass <4GB virtual addresses down into prom calls.
> 
> That code should be using the in-kernel copy of the device tree,
> via the of_*() interfaces, to do it's probing.  And I'm going to
> write such a patch to fix this bug.
> 
> So sit tight :-)
> 

I don't have a kernel source handy, but I think I have seen other calls
to prom_* around the kernel. Might be worth doing a quick grep to make
sure we don't miss others.

Send me the patch over for testing once you are done :)

Cheers
Fabio
