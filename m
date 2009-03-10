From: David Miller <davem@davemloft.net>
Date: Tue, 10 Mar 2009 12:17:15 +0000
Subject: Re: Signal handler arguments
Message-Id: <20090310.051715.17967430.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B543AF.4090902@users.sourceforge.net>
In-Reply-To: <49B543AF.4090902@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <e2lahav@gmail.com>
Date: Tue, 10 Mar 2009 08:00:58 -0400

> David Miller wrote:
> > Well, whatever it is it can't be changed without breaking
> > everything out there 
>
> Do you mean breaking all the applications that use the third
> parameter as a sigcontext structure? Can you point to any? Remember
> that this is an undocumented deviation from the POSIX standard,
> unique to Linux/Sparc. Somehow I have a feeling that very few
> programs are aware of this feature and are using it.

GCC's dwarf unwinder knows the exact layout, as does MONO's sparc
backend, GDB, etc...

The list goes on and on.

It can't be changed without breaking lots of things.

Since this is machine specific code anyways, I can't see this
causing any kind of real problem once the programmer knows what
the type of that third argument is.
