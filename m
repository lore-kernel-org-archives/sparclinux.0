From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Wed, 24 Sep 2008 18:06:21 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809241106j7780be0et384ee4b98082765b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <48D7F33D.90007@codemonkey.ws>
	 <20080922.132442.199870298.davem@davemloft.net>
	 <f43fc5580809230828i48be0e20m915814138b6a0e84@mail.gmail.com>
	 <20080923.133856.141663278.davem@davemloft.net>
	 <f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
In-Reply-To: <f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

On 9/24/08, Blue Swirl <blauwirbel@gmail.com> wrote:
> On 9/23/08, David Miller <davem@davemloft.net> wrote:
>  > From: "Blue Swirl" <blauwirbel@gmail.com>
>  >
>  > Date: Tue, 23 Sep 2008 18:28:06 +0300
>  >
>  >
>  >  > On 9/22/08, David Miller <davem@davemloft.net> wrote:
>  >
>  > > > As he mentioned, the V8 rett instruction causes problems on V9 chips.
>  >  > >
>  >  > >  An opcode which was a V8 privileged instruction, "rett", got reused as
>  >  > >  a non-privileged instruction in V9, for "return".
>  >  >
>  >  > There are others: rdtbr/flushw and stdfq/stqf. Also any ASI >0x80
>  >  > accesses are unprivileged on V9, though that shouldn't be a problem
>  >  > since all ASIs used on V8 were <0x80. And of course MMUs are
>  >  > incompatible.
>  >
>  >
>  > Thanks for the list.  I sent a message to someone who I think might
>  >  have been responsible for these architectual design decisions, letting
>  >  them know what problems it is causing :-)
>  >
>  >
>  >  > >  So booting a 32-bit kernel on a 64-bit cpu is going to be challenging,
>  >  > >  at best.
>  >  >
>  >  > Maybe it would be possible to run V8 userspace with full speed
>  >  > acceleration on V9 and use translation only for kernel code?
>  >
>  >
>  > Yes, that should work.
>  >
>  >  BTW, there is another area related the ASIs.  Trap numbers.
>  >
>  >  Even through V9, traps only up to 0x7f are valid.  But sun4v extended
>  >  V9 to allow trap numbers >= 0x80, mostly these are used for hypervisor
>  >  calls.
>  >
>  >  The trap number field of the instruction is just extended one more
>  >  bit higher to accomodate this.
>
>
> I see, also Qemu needs to use one more bit then. Does this mean that
>  even V8 code written specially may use these traps to call hypervisor?
>  Then we would need to catch these, maybe with the some assistance from
>  the hypervisor.

Now I found the relevant part in the manuals. The extra sun4v bit is
not taken into account from user mode, so we can't catch privileged to
hyperprivileged mode traps easily.
