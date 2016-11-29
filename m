From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 29 Nov 2016 11:41:03 +0000
Subject: Re: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <20161129114103.GE3092@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <CAMuHMdU13YdzoM4zTaiUvhzbgSVGeJgn6k7nyo2RayURiezK2w@mail.gmail.com>
In-Reply-To: <CAMuHMdU13YdzoM4zTaiUvhzbgSVGeJgn6k7nyo2RayURiezK2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Babu Moger <babu.moger@oracle.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Nov 29, 2016 at 12:14:48PM +0100, Geert Uytterhoeven wrote:
> CC linux-renesas-soc
> 
> On Tue, Sep 27, 2016 at 9:33 PM, Babu Moger <babu.moger@oracle.com> wrote:
> > These patches limit the static allocations for lockdep data structures
> > used for debugging locking correctness. For sparc, all the kernel's code,
> > data, and bss, must have locked translations in the TLB so that we don't
> > get TLB misses on kernel code and data. Current sparc chips have 8 TLB
> > entries available that may be locked down, and with a 4mb page size,
> > this gives a maximum of 32MB. With PROVE_LOCKING we could go over this
> > limit and cause system boot-up problems. These patches limit the static
> > allocations so that everything fits in current required size limit.
> >
> > patch 1 : Adds new config parameter CONFIG_PROVE_LOCKING_SMALL
> > Patch 2 : Adjusts the sizes based on the new config parameter
> 
> Cool, this is also useful on other platforms!
> E.g. on r8a7791/koelsch, I cannot boot an shmobile_defconfig plus
> CONFIG_PROVE_LOCKING kernel.
> Forcing CONFIG_PROVE_LOCKING_SMALL=y in Kconfig fixes that.
> 
> Should it become a user-selectable symbol?

Nah, users don't need more senseless options. This is really only useful
for dinky platforms or platforms with limited static image size (like
sparc64).

If you make this user selectable, someone will do, and then an endless
stream of table not big enough warnings will be posted.

Also, its only 4MB (IIRC), so who cares.
