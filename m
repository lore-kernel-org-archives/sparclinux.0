From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 29 Aug 2017 09:04:30 +0000
Subject: Re: [PATCH v3 0/3] Define CPU_BIG_ENDIAN or warn for inconsistencies
Message-Id: <20170829090430.f6p3shucjxzicekw@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499358861-179979-1-git-send-email-babu.moger@oracle.com>
 <20170829063015.GA12198@kroah.com>
In-Reply-To: <20170829063015.GA12198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Babu Moger <babu.moger@oracle.com>, ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk, monstr@monstr.eu, mpe@ellerman.id.au, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Aug 29, 2017 at 08:30:15AM +0200, Greg KH wrote:
> On Thu, Jul 06, 2017 at 09:34:18AM -0700, Babu Moger wrote:
> > Resending the series per Greg KH's request.
> > 
> > Found this problem while enabling queued rwlock on SPARC.
> > The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
> > specific byte in qrwlock structure. Without this parameter,
> > we clear the wrong byte.
> > Here is the code in include/asm-generic/qrwlock.h
> > 
> > static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
> >   {
> >          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
> >   }
> > 
> > Also found few more references of this parameter in
> > drivers/of/base.c
> > drivers/of/fdt.c
> > drivers/tty/serial/earlycon.c
> > drivers/tty/serial/serial_core.c
> > 
> > Here is our previous discussion.
> > https://lkml.org/lkml/2017/5/24/620
> > 
> > Based on the discussion, it was decided to add CONFIG_CPU_BIG_ENDIAN
> > for all the fixed big endian architecture(frv, h8300, m68k, openrisc,
> > parisc and sparc). And warn if there are inconsistencies in this definition.
> 
> Did this series ever get picked up by anyone?  I don't know whose tree
> it should go through if not, anyone have any ideas?  I guess I could,
> but arch-specific stuff is odd...

Seems like something that akpm would pick up, but it appears people
didn't actually Cc him.

