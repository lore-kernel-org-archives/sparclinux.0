From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 11:24:53 +0000
Subject: Re: sparc: Fix mremap VA span checking.
Message-Id: <20080512.042453.238263459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1210590913.10883.9.camel@dhcp-lab-164.englab.brq.redhat.com>
In-Reply-To: <1210590913.10883.9.camel@dhcp-lab-164.englab.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jlieskov@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jan Lieskovsky <jlieskov@redhat.com>
Date: Mon, 12 May 2008 13:15:12 +0200

>  I have investigated the code for MREMAP_FIXED in
> sparc_mremap in arch/sparc/kernel/sys_sparc.c, for sys64_mremap
> in arch/sparc64/kernel/sys_sparc.c and 
> for sys32_mremap in arch/sparc64/kernel/sys_sparc32.c
> and there are similar conditional range checks ->
> attaching the patches against 2.6.25.3.

Thanks for the report, I'll take a look at this after getting
some sleep as it's late hear.

My first impression is that it might make sense to put an
arch_mmap_check() call at the appropriate spots instead of duplicating
this check so many times.
