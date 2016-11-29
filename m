From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 29 Nov 2016 12:35:46 +0000
Subject: Re: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <20161129123546.GM3174@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <CAMuHMdU13YdzoM4zTaiUvhzbgSVGeJgn6k7nyo2RayURiezK2w@mail.gmail.com>
 <20161129114103.GE3092@twins.programming.kicks-ass.net>
 <CAMuHMdWZ=1F-aL7K5YvPx58C8Cqy19fHqUGhVqVewTvXc5Z5-w@mail.gmail.com>
 <20161129122907.GH3092@twins.programming.kicks-ass.net>
In-Reply-To: <20161129122907.GH3092@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Babu Moger <babu.moger@oracle.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Nov 29, 2016 at 01:29:07PM +0100, Peter Zijlstra wrote:
> > BTW, is there any particular reason these huge arrays are in BSS, and not
> > allocated dynamically? That would solve my problems as well...
> 
> Is there a memory allocator available before _any_ locks are used, and
> that itself also doesn't use locks?

And if that is, the platform could use that to allocate .bss, no?
