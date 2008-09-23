From: David Miller <davem@davemloft.net>
Date: Tue, 23 Sep 2008 20:38:56 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080923.133856.141663278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48D7F33D.90007@codemonkey.ws>
	<20080922.132442.199870298.davem@davemloft.net>
	<f43fc5580809230828i48be0e20m915814138b6a0e84@mail.gmail.com>
In-Reply-To: <f43fc5580809230828i48be0e20m915814138b6a0e84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: blauwirbel@gmail.com
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Tue, 23 Sep 2008 18:28:06 +0300

> On 9/22/08, David Miller <davem@davemloft.net> wrote:
> > As he mentioned, the V8 rett instruction causes problems on V9 chips.
> >
> >  An opcode which was a V8 privileged instruction, "rett", got reused as
> >  a non-privileged instruction in V9, for "return".
> 
> There are others: rdtbr/flushw and stdfq/stqf. Also any ASI >0x80
> accesses are unprivileged on V9, though that shouldn't be a problem
> since all ASIs used on V8 were <0x80. And of course MMUs are
> incompatible.

Thanks for the list.  I sent a message to someone who I think might
have been responsible for these architectual design decisions, letting
them know what problems it is causing :-)

> >  So booting a 32-bit kernel on a 64-bit cpu is going to be challenging,
> >  at best.
> 
> Maybe it would be possible to run V8 userspace with full speed
> acceleration on V9 and use translation only for kernel code?

Yes, that should work.

BTW, there is another area related the ASIs.  Trap numbers.

Even through V9, traps only up to 0x7f are valid.  But sun4v extended
V9 to allow trap numbers >= 0x80, mostly these are used for hypervisor
calls.

The trap number field of the instruction is just extended one more
bit higher to accomodate this.

It turns out that binutils's assembler didn't range check the trap
number field value, so binutils needed no changes to support this :-)
