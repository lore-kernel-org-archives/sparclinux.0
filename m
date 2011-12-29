From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 11:09:13 +0000
Subject: Re: [PATCH] sparc32: support atomic64_t
Message-Id: <20111229110913.GA6310@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212850.GA8174@merkur.ravnborg.org>
In-Reply-To: <20111227212850.GA8174@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 27, 2011 at 05:24:49PM -0500, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 27 Dec 2011 16:37:29 -0500 (EST)
> 
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 27 Dec 2011 22:28:50 +0100
> > 
> >> $size vmlinux (before atomic64_t support)
> >>    text    data     bss     dec     hex filename
> >> 3578860  134260  108781 3821901  3a514d vmlinux
> >> 
> >> $size vmlinux (after atomic64_t support)
> >>    text    data     bss     dec     hex filename
> >> 3579892  130684  108781 3819357  3a475d vmlinux
> >> 
> >> text increase (3579892 - 3578860) = 1032 bytes
>  ...
> > The data decreasing is really funny indeed, it should
> > increase because of the atomic64_lock[] array in lib/atomic64.c
> > 
> > And the decrease isn't some trivial amount, it's more than 3K!
> 
> I was going to take a good look into this but I actually can't
> reproduce this with gcc-4.6.2-7 under debian.

I took a deeper look at this today - and this all boils
down to some alignment issues.

Without atomic64_t support .data had address xxx47000.
This address is nicely aligned to a page boundary.
But SPARC32 require that the thread data are aligned to a 2*PAGE_SIZE boundary,
so therefore this is rounded up to xxx48000 - thus wasting 1000@96 bytes.

When I applied the patch to enable atomic64_t then .data got address xx48000
which is aligned to a 2*PAGE_SIZE - and no extra page wasted for alignment.

.data had a higher address because .rodata had a higher address in the atomic64_t case.
This expalins why we used less data despite using more data!

A little more details:

In the linker scripts we have:
#define RW_DATA_SECTION(cacheline, pagealigned, inittask)               \
        . = ALIGN(PAGE_SIZE);                                           \
        .data : AT(ADDR(.data) - LOAD_OFFSET) {                         \
                INIT_TASK_DATA(inittask)                                \
                NOSAVE_DATA                                             \


And we use this macro from SPARC32 like this:

	RW_DATA_SECTION(SMP_CACHE_BYTES, 0, THREAD_SIZE)

And THREAD_SIZE is defiend like this:

	#define THREAD_SIZE            8192

I should cleanup thread_info_32.h and page_32.h one day...

	Sam
