From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 03 Sep 2020 07:29:16 +0000
Subject: Re: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg support issue
Message-Id: <CAMo8BfJT7JJfwT1-X3vfqKGD-E3-Dbf2xyWs-RiRyUUHmbetVA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand <david@redhat.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Russell King <linux@armlinux.org.uk>, Alexander Duyck <alexander.duyck@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>

On Thu, Sep 3, 2020 at 12:01 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
> cmpxchg4 on it.

[...]

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig> index e00d94b16658..03a6c7fd999d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -48,6 +48,7 @@ config ARM
>         select GENERIC_ALLOCATOR
>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>         select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
> +       select NO_CMPXCHG_BYTE if CPU_V6
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>         select GENERIC_CPU_AUTOPROBE
>         select GENERIC_EARLY_IOREMAP
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d20927128fce..4c7f0ad5b93f 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -155,6 +155,7 @@ menu "System type"
>  config CPU_SH2
>         bool
>         select SH_INTC
> +       select NO_CMPXCHG_BYTE
>
>  config CPU_SH2A
>         bool
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index efeff2c896a5..51ae5c8ede87 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -58,6 +58,7 @@ config SPARC32
>         select CLZ_TAB
>         select HAVE_UID16
>         select OLD_SIGACTION
> +       select NO_CMPXCHG_BYTE
>
>  config SPARC64
>         def_bool 64BIT
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index e997e0119c02..862b008ab09e 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -42,6 +42,7 @@ config XTENSA
>         select MODULES_USE_ELF_RELA
>         select PERF_USE_VMALLOC
>         select VIRT_TO_BUS
> +       select NO_CMPXCHG_BYTE

Please keep the lists of select statements in Kconfig files above
alphabetically sorted.

-- 
Thanks.
-- Max
