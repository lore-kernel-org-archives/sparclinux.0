From: David Miller <davem@davemloft.net>
Date: Tue, 16 Jan 2007 03:06:07 +0000
Subject: Re: [PATCH] sparc32: fix gcc over-optimizatoin near ip_fast_csum
Message-Id: <20070115.190607.41643001.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <45AA9379.8060700@mc.net>
In-Reply-To: <45AA9379.8060700@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sun, 14 Jan 2007 14:32:57 -0600

> Fix over-optimization by GCC near ip_fast_csum.
> 
> In some cases such as:
> 	iph->check = 0;
> 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
> GCC may optimize out the previous store.
> 
> Observed as a failure of NFS over udp (bad checksums on ip fragments) when 
> compiled with GCC 3.4.2.
> 
> Signed-off-by: Bob Breuer <breuerr@mc.net>

Thanks for finding this bug, patch applied.

This issue may be why I made ip_fast_csum() non-inlined on
sparc64 :-)
