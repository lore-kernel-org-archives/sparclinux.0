From: Arnd Bergmann <arnd@kernel.org>
Date: Sun, 20 Dec 2020 17:49:13 +0000
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-Id: <CAK8P3a3mrD7U__T-X2jr1Mw9Xk=dBE=Fuid_BHNE85GcX0g-rg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com> <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
In-Reply-To: <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guo Ren <guoren@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Davidlohr Bueso <dave@stgolabs.net>, Elena Reshetova <elena.reshetova@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Sun, Dec 20, 2020 at 4:46 PM Guo Ren <guoren@kernel.org> wrote:
> On Tue, Dec 15, 2020 at 7:26 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
> > > On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > I had a look at what other architectures always implement
> > > > futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> > > > and I found that it's pretty much all of them, the odd ones being just sparc32
> > > > and csky, which use asm-generic/futex.h but do have an SMP option,
> > > > as well as xtensa
> > > >
> > > > I would guess that for csky, this is a mistake, as the architecture is fairly
> > > > new and should be able to implement it. Not sure about sparc32.
> > >
> > > The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
> > > with asm-generic's implementation.
> > > For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
> > > implementation, so futex_cmpxchg_enabled = 0.
> > >
> > > Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
> > > and still use asm-generic for non-smp CPUs.
> >
> > Sounds good to me.
> Done: https://lore.kernel.org/linux-csky/1608478763-60148-3-git-send-email-guoren@kernel.org/T/#u

Thanks!

Can you clarify if there are any dependencies on the other patches in
that series?

I'd like to take the futex patch through the asm-generic tree along with the
patches for the other architectures.

       Arnd
