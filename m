From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Oct 2018 22:22:40 +0000
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable from roundup
Message-Id: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org>
 <20181030114603.xdvyvayzw2an5c3q@holly.lan>
In-Reply-To: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Oct 30, 2018 at 4:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> > The function kgdb_roundup_cpus() was passed a parameter that was
> > documented as:
> >
> > > the flags that will be used when restoring the interrupts. There is
> > > local_irq_save() call before kgdb_roundup_cpus().
> >
> > Nobody used those flags.  Anyone who wanted to temporarily turn on
> > interrupts just did local_irq_enable() and local_irq_disable() without
> > looking at them.  So we can definitely remove the flags.
>
> On the whole I'd rather that this change...
>
>
> > Speaking of calling local_irq_enable(), it seems like a bad idea and
> > it caused a nice splat on my system with lockdep turned on.
> > Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>
> ... and fixes for this this were in separate patches. They don't appear
> especially related.

Agreed that this is cleaner.  Done for v2.

-Doug
