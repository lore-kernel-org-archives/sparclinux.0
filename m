From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 30 Jul 2007 01:04:48 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <646765f40707291804o2be49f21k863d1d72f183777c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 7/30/07, Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
>
>
> On Mon, 30 Jul 2007, Julian Calaby wrote:
>
> > On 7/29/07, David Miller <davem@davemloft.net> wrote:
> >> The floppy driver cannot be built as a module on sparc32, you must
> >> build it in statically because it references an interrupt handler
> >> which must be coded in assembler which therefore cannot be easily
> >> exported to modules.
> >
> > Stupid question, but: Why is it possible to select it to compile as a
> > module when it cannot?
> >
>
> Because no one has got arround to fixing the build option :-).
> Sparc32 is only partially maintained at the moment so little things like
> this get left out of updates.

I'll put together a patch tonight or tomorrow then =)

Speaking of maintenance for sparc32, I'm willing to test any patches
for it that'll be testable on a headless SS10, providing that people
don't mind having a long (~2 weeks) turnaround time on them.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
