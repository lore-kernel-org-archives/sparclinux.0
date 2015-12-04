From: Petr Mladek <pmladek@suse.com>
Date: Fri, 04 Dec 2015 15:47:49 +0000
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary buffer
Message-Id: <20151204154749.GC20935@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 2015-12-02 16:20:41, David Laight wrote:
> From: yalin wang
> > Sent: 30 November 2015 16:42
> > > On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > Testing has shown that the backtrace sometimes does not fit
> > > into the 4kB temporary buffer that is used in NMI context.
> > >
> > > The warnings are gone when I double the temporary buffer size.
> 
> You are wasting a lot of memory for something that is infrequently used.
> There ought to be some way of copying partial tracebacks into the
> main buffer.

I have already tried to use a separate ring buffer that might be
shared between all CPUs. But it was rejected because it was too
complex. See
http://thread.gmane.org/gmane.linux.kernel/1700059/focus00066

If we would want to crate a lockless access to the main ring
buffer, we would end up with something like
kernel/trace/ring_buffer.c. It is even more complicated.
And reading of the messages is pretty slow.

Note that we already have this buffer allocated on x86 and arm.
It is used there for printing backtrace from all CPUs.
This patchset makes it usable for all NMI messages.

But I'll make the size configurable in the next version.

Thanks for review,
Petr
