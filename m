From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 03:12:58 +0000
Subject: Re: [PATCH 07/12] Consolidate of_find_node_by routines
Message-Id: <20070719.201258.25911887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011450.d0b97300.sfr@canb.auug.org.au>
In-Reply-To: <20070720011450.d0b97300.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:14:50 +1000

> This consolidates the routines of_find_node_by_path, of_find_node_by_name,
> of_find_node_by_type and of_find_compatible_device.  Again, the comparison
> of strings are done differently by Sparc and PowerPC and also these add
> read_locks around the iterations.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.

