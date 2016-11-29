From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 29 Nov 2016 13:31:41 +0000
Subject: Re: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <20161129133141.GK3092@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <CAMuHMdU13YdzoM4zTaiUvhzbgSVGeJgn6k7nyo2RayURiezK2w@mail.gmail.com>
 <20161129114103.GE3092@twins.programming.kicks-ass.net>
 <CAMuHMdWZ=1F-aL7K5YvPx58C8Cqy19fHqUGhVqVewTvXc5Z5-w@mail.gmail.com>
 <20161129122907.GH3092@twins.programming.kicks-ass.net>
 <CAMuHMdXu6vbRQrZHGG7wDojxsQpqHApwHxcFRwmwMVZYqdcfcw@mail.gmail.com>
In-Reply-To: <CAMuHMdXu6vbRQrZHGG7wDojxsQpqHApwHxcFRwmwMVZYqdcfcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Babu Moger <babu.moger@oracle.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Nov 29, 2016 at 02:26:47PM +0100, Geert Uytterhoeven wrote:
> On Tue, Nov 29, 2016 at 1:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Nov 29, 2016 at 12:52:04PM +0100, Geert Uytterhoeven wrote:

> >> Not because of platforms with not limited memory, but because of platforms
> >> with boot loaders that have silly kernel size limitations, and start
> >> scribbling over the DTB or even theirselves when copying a large kernel image.
> >
> > Right, that's the weird platforms clause above, and those can select the
> > option.
> 
> Their Kconfig files can select it. The users can't.
> What about making it visible depending on EXPERT?

Not understanding, why would a user ever need it? The platform knows if
its has funny boot image size limits, no?
