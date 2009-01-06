From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 20:51:44 +0000
Subject: Re: [PATCH] sparc64: refactor code in init_64.c
Message-Id: <20090106.125144.174665553.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106202245.GB17714@uranus.ravnborg.org>
In-Reply-To: <20090106202245.GB17714@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 6 Jan 2009 21:22:45 +0100

> The sparc64 allmodconfig build broke due to enabling of the
> branch_tracer that does some very clever things with
> all if conditions. This caused my gcc 3.4.5 to be so confused that
> it emitted two warnings:
> 
> arch/sparc/mm/init_64.c: In function `update_mmu_cache':
> arch/sparc/mm/init_64.c:271: warning: 'pg_flags' might be used uninitialized in this function
> arch/sparc/mm/init_64.c:272: warning: 'page' might be used uninitialized in this function
> 
> And with -Werror this broke the build.
> 
> Refactor code so it:
> 1) becomes more readable
> 2) no longer emit a warning with the branch_tracer enabled
> 
> The refactoring uses a small helper function (flush_dcache()).
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> The diff is not readable so you need to apply it to
> see the end result.
> 
> Please review extra carefully to check that the transformation of:
> 
>     (page = pfn_to_page(pfn), page_mapping(page))
> 
> is correct.

Looks correct, applied.  Thanks Sam.
