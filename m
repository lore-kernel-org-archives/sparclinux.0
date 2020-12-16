From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 16 Dec 2020 10:07:17 +0000
Subject: RE: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-Id: <56daed1d2cbd40fea0a7170c45081cf7@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com> <87czzeg5ep.fsf@nanos.tec.linutronix.de>
 <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <20201215193800.GA1098247@ravnborg.org>
In-Reply-To: <20201215193800.GA1098247@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Sam Ravnborg' <sam@ravnborg.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Davidlohr Bueso <dave@stgolabs.net>, Elena Reshetova <elena.reshetova@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

From: Sam Ravnborg
> Sent: 15 December 2020 19:38
> 
> Hi Arnd,
> 
> On Tue, Dec 15, 2020 at 12:26:10PM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
...
> > - Disable SMP support for sun4m/sun4d. From the historic git
> >   tree, it's unclear how well this ever worked, and very few machines
> >   of this class ever existed
> Yeah, I have collection of sparc32 machines that I played around with
> once. Including one sun4d that I brought from a friendly Linux fellow in
> the UK. But somehow I lost interest as this is all very nice machines
> but not useful for anything real work.

ICL made a few SMP sparc32 systems.
I think the first ones used the original Cypress cpu running at 25MHz.
(I'm fairly sure these were SMP-capable, the later 40MHz definitely were.)
These were full sized VMEbus beasts.
Somewhere I've got a 32MByte memory board - over a square foot of board.
The memory is all 64k by 1 with all the pins on one edge and the chips vertical.
Really looks as though it should glow red and be used for cooking toast.
Even with 4 of those you're not going to run anything modern!

There were also some later mbus+sbus systems with dual sbus!
Designed by Fujitsu.

None of these ever ran solaris.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
