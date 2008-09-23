From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Tue, 23 Sep 2008 15:28:06 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809230828i48be0e20m915814138b6a0e84@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
	 <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
	 <48D7F33D.90007@codemonkey.ws>
	 <20080922.132442.199870298.davem@davemloft.net>
In-Reply-To: <20080922.132442.199870298.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

On 9/22/08, David Miller <davem@davemloft.net> wrote:
> From: Anthony Liguori <anthony@codemonkey.ws>
>  Date: Mon, 22 Sep 2008 14:34:21 -0500
>
>
>  > Blue Swirl wrote:
>  > >  But I think we could already start early drafting of what KVM support
>  > >  for Sparc32 and Sparc64 would mean. Because of certain problems in the
>  > >  V9 instruction set design (V8 rett reuse for example), it may be
>  > >  difficult or even impossible to use an accelerator if the host and
>  > >  target instruction sets do not match.
>  >
>  > I don't know much about the Sparc architecture, but the embedded
>  > PowerPC port that Hollis has spear-headed is for an architecture
>  > that does not natively support hardware virtualization.  As long as
>  > Sparc meets all of the requirements to do this sort of
>  > virtualization (all privileged instructions are trappable when run
>  > in non-privileged mode), it should be rather straight forward.
>
>
> As he mentioned, the V8 rett instruction causes problems on V9 chips.
>
>  An opcode which was a V8 privileged instruction, "rett", got reused as
>  a non-privileged instruction in V9, for "return".

There are others: rdtbr/flushw and stdfq/stqf. Also any ASI >0x80
accesses are unprivileged on V9, though that shouldn't be a problem
since all ASIs used on V8 were <0x80. And of course MMUs are
incompatible.

>  So booting a 32-bit kernel on a 64-bit cpu is going to be challenging,
>  at best.

Maybe it would be possible to run V8 userspace with full speed
acceleration on V9 and use translation only for kernel code?
