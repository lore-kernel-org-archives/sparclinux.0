From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:22:54 +0000
Subject: Re: [PATCH] sparc: topology_64.h: Fix condition for including cpudata.h
Message-Id: <20170223.112254.85575440784556098.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170204163222.GT3442@decadent.org.uk>
In-Reply-To: <20170204163222.GT3442@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 4 Feb 2017 16:32:22 +0000

> We currently define macros referring to cpu_data if CONFIG_SMP is
> defined, but only include the declaration if CONFIG_NUMA is defined.
> 
> Fixes: 541cc39433a8 ("sparc: fix a building error reported by kbuild")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied.
