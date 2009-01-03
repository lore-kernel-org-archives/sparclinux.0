From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:22:29 +0000
Subject: Re: sparc - next unification bits?
Message-Id: <20090102.182229.07047691.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081227211236.GA16704@uranus.ravnborg.org>
In-Reply-To: <20081227211236.GA16704@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 27 Dec 2008 22:12:36 +0100

> So far I done some random unification where it was simple
> and I could do so more or less in a mechanical fashion.
> 
> But I'm running out of the easy tasks.
> 
> Are there any places/files where you would like to see
> some additional effort being made - but yet simple
> enough that I can do it?

An area with a lot of potential is arch/sparc/prom, I think.

The trick is to decide upon a backend interface for the
actual calls into the firmware.

Sparc32 calls into the firmware by ->foo() method calls,
and the base of the structure with the function pointers
is given to the kernel at boot time.

Sparc64 on the other hand calls into the firmware by
invoking a single function address, again given to the
kernel in a register at boot time, but the method to
invoke is indicated by a string and the args are pushed
on the stack (and the args are obtained from stack slots).

Perhaps if a suitable abstraction for this stuff is
designed, this difference in calling conventions could be
handled which would make most of the arch/sparc/prom/
code generic.

For example we could have some prom_invoke() thing that
would take the method name string as one of it's args,
but that would be totally ignored by 32-bit sparc's
implementation of this interface.  Likewise, there would
be a method name arg, which in turn would be not used
by 64-bit sparc.

Something like that.  Just throwing out some ideas.
