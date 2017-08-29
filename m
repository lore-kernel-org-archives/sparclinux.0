From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 29 Aug 2017 06:30:15 +0000
Subject: Re: [PATCH v3 0/3] Define CPU_BIG_ENDIAN or warn for inconsistencies
Message-Id: <20170829063015.GA12198@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499358861-179979-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1499358861-179979-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk, monstr@monstr.eu, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Jul 06, 2017 at 09:34:18AM -0700, Babu Moger wrote:
> Resending the series per Greg KH's request.
> 
> Found this problem while enabling queued rwlock on SPARC.
> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
> specific byte in qrwlock structure. Without this parameter,
> we clear the wrong byte.
> Here is the code in include/asm-generic/qrwlock.h
> 
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>   {
>          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>   }
> 
> Also found few more references of this parameter in
> drivers/of/base.c
> drivers/of/fdt.c
> drivers/tty/serial/earlycon.c
> drivers/tty/serial/serial_core.c
> 
> Here is our previous discussion.
> https://lkml.org/lkml/2017/5/24/620
> 
> Based on the discussion, it was decided to add CONFIG_CPU_BIG_ENDIAN
> for all the fixed big endian architecture(frv, h8300, m68k, openrisc,
> parisc and sparc). And warn if there are inconsistencies in this definition.

Did this series ever get picked up by anyone?  I don't know whose tree
it should go through if not, anyone have any ideas?  I guess I could,
but arch-specific stuff is odd...

thanks,

greg k-h
