From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 16 Nov 2017 09:04:00 +0000
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t conversion
Message-Id: <alpine.DEB.2.20.1711160958430.2191@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
In-Reply-To: <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>, Stefan Haberland <sth@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Will Deacon <will.deacon@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Robert Richter <rric@kernel.org>, Chris Metcalf <cmetc>

On Wed, 15 Nov 2017, Deepa Dinamani wrote:
> > I had on concern about x32, maybe we should check
> > for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
> > bits.
> 
> Thanks, I think you are right. I had the check conditional on
> CONFIG_64BIT_TIME and then removed as I forgot why I added it. :)
> 
> > Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
> > it help to just leave out that part for now and unconditionally
> > define '__kernel_timespec' as 'timespec' until we are ready to
> > convert the architectures?
> 
> Another approach would be to use separate configs:
> 
> 1. To indicate 64 bit time_t syscall support. This will be dependent
> on architectures as CONFIG_64BIT_TIME.
> We can delete this once all architectures have provided support for this.
> 
> 2. Another config (maybe COMPAT_32BIT_TIME?) to be introduced later,
> which will compile out all syscalls/ features that use 32 bit time_t.
> This can help build a y2038 safe kernel later.
> 
> Would this work for everyone?

Having extra config switches which are selectable by architectures and
removed when everything is converted is definitely the right way to go.

That allows you to gradually convert stuff w/o inflicting wreckage all over
the place.

Thanks,

	tglx
