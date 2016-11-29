From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Nov 2016 11:14:48 +0000
Subject: Re: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <CAMuHMdU13YdzoM4zTaiUvhzbgSVGeJgn6k7nyo2RayURiezK2w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

CC linux-renesas-soc

On Tue, Sep 27, 2016 at 9:33 PM, Babu Moger <babu.moger@oracle.com> wrote:
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

Cool, this is also useful on other platforms!
E.g. on r8a7791/koelsch, I cannot boot an shmobile_defconfig plus
CONFIG_PROVE_LOCKING kernel.
Forcing CONFIG_PROVE_LOCKING_SMALL=y in Kconfig fixes that.

Should it become a user-selectable symbol?

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
>
> Babu Moger (2):
>   config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL
>     for sparc
>   lockdep: Limit static allocations if PROVE_LOCKING_SMALL is defined
>
>  arch/sparc/Kconfig                 |    1 +
>  kernel/locking/lockdep_internals.h |   20 +++++++++++++++++---
>  lib/Kconfig.debug                  |    3 +++
>  3 files changed, 21 insertions(+), 3 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
