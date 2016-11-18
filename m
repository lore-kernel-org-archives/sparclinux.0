From: David Miller <davem@davemloft.net>
Date: Fri, 18 Nov 2016 19:34:07 +0000
Subject: Re: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <20161118.143407.750907377181864816.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 27 Sep 2016 12:33:26 -0700

> These patches limit the static allocations for lockdep data structures
> used for debugging locking correctness. For sparc, all the kernel's code,
> data, and bss, must have locked translations in the TLB so that we don't
> get TLB misses on kernel code and data. Current sparc chips have 8 TLB
> entries available that may be locked down, and with a 4mb page size,
> this gives a maximum of 32MB. With PROVE_LOCKING we could go over this
> limit and cause system boot-up problems. These patches limit the static
> allocations so that everything fits in current required size limit.
> 
> patch 1 : Adds new config parameter CONFIG_PROVE_LOCKING_SMALL
> Patch 2 : Adjusts the sizes based on the new config parameter
> 
> v2-> v3:
>    Some more comments from Sam Ravnborg and Peter Zijlstra.
>    Defined PROVE_LOCKING_SMALL as invisible and moved the selection to
>    arch/sparc/Kconfig. 
> 
> v1-> v2:
>    As suggested by Peter Zijlstra, keeping the default as is.
>    Introduced new config variable CONFIG_PROVE_LOCKING_SMALL
>    to handle sparc specific case.
> 
> v0:
>    Initial revision.

Series applied, thanks.
