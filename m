From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 06 Feb 2017 03:04:20 +0000
Subject: RE: [PATCH] sparc: topology_64.h: Fix condition for including cpudata.h
Message-Id: <33183CC9F5247A488A2544077AF19020DA1AEDB5@DGGEMA505-MBX.china.huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170204163222.GT3442@decadent.org.uk>
In-Reply-To: <20170204163222.GT3442@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>
> From: Ben Hutchings [mailto:ben@decadent.org.uk]
> Sent: Sunday, February 05, 2017 12:32 AM
> To: David S. Miller
> Cc: sparclinux@vger.kernel.org; Gonglei (Arei); Sam Ravnborg
> Subject: [PATCH] sparc: topology_64.h: Fix condition for including cpudata.h
> 
> We currently define macros referring to cpu_data if CONFIG_SMP is
> defined, but only include the declaration if CONFIG_NUMA is defined.
> 
> Fixes: 541cc39433a8 ("sparc: fix a building error reported by kbuild")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h

Acked-by: Gonglei <arei.gonglei@huawei.com>
