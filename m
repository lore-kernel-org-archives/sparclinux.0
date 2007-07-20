From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 01:01:52 +0000
Subject: Re: [PATCH 05/12] Consolidate of_get_parent
Message-Id: <20070719.180152.126575168.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011235.8199eca2.sfr@canb.auug.org.au>
In-Reply-To: <20070720011235.8199eca2.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:12:35 +1000

> This requires creating dummy of_node_{get,put} routines for sparc and
> sparc64.  It also adds a read_lock around the parent accesses.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.

