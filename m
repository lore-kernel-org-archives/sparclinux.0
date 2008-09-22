From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2008 20:24:42 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080922.132442.199870298.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
	<f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
	<48D7F33D.90007@codemonkey.ws>
In-Reply-To: <48D7F33D.90007@codemonkey.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anthony@codemonkey.ws
Cc: blauwirbel@gmail.com, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

From: Anthony Liguori <anthony@codemonkey.ws>
Date: Mon, 22 Sep 2008 14:34:21 -0500

> Blue Swirl wrote:
> >  But I think we could already start early drafting of what KVM support
> >  for Sparc32 and Sparc64 would mean. Because of certain problems in the
> >  V9 instruction set design (V8 rett reuse for example), it may be
> >  difficult or even impossible to use an accelerator if the host and
> >  target instruction sets do not match.
>
> I don't know much about the Sparc architecture, but the embedded
> PowerPC port that Hollis has spear-headed is for an architecture
> that does not natively support hardware virtualization.  As long as
> Sparc meets all of the requirements to do this sort of
> virtualization (all privileged instructions are trappable when run
> in non-privileged mode), it should be rather straight forward.

As he mentioned, the V8 rett instruction causes problems on V9 chips.

An opcode which was a V8 privileged instruction, "rett", got reused as
a non-privileged instruction in V9, for "return".

So booting a 32-bit kernel on a 64-bit cpu is going to be challenging,
at best.

> KVM supports x86, ia64, s390, and PPC today.  I don't think there
> would be any problems adding another architecture support.  Almost
> all of the abstractions should have been flushed out already by the
> previous architecture ports.  Moreover, since there is already good
> support for Sparc in QEMU, that should simplify things
> significantly.

Of course.
