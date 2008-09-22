From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Mon, 22 Sep 2008 20:18:39 +0000
Subject: Re: KVM for Sparc?
Message-Id: <1222114719.3967.43.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
	 <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
	 <48D7F33D.90007@codemonkey.ws>
In-Reply-To: <48D7F33D.90007@codemonkey.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, sparclinux@vger.kernel.org, John Levon <levon@movementarian.org>

On Mon, 2008-09-22 at 14:34 -0500, Anthony Liguori wrote:
> Blue Swirl wrote:
> > Hi,
> >
> >  Sorry for cross-posting (and because I used the wrong address in the
> > first time for KVM, sorry for the duplicate on Sparclinux).
> >
> >  Sparc host support for Qemu is getting close
> >  to ready, I can already run a Sparc32 system emulator on
> >  OpenBSD/Sparc64 and there is some limited success with recent glibc on
> >  Linux/Sparc64. Otherwise Sparc32 target emulator is pretty stable.
> >  Sparc64 target emulator can boot from several CD images, but crashes
> >  pretty soon.
> >
> >  But I think we could already start early drafting of what KVM support
> >  for Sparc32 and Sparc64 would mean. Because of certain problems in the
> >  V9 instruction set design (V8 rett reuse for example), it may be
> >  difficult or even impossible to use an accelerator if the host and
> >  target instruction sets do not match.
> >   
> 
> I don't know much about the Sparc architecture, but the embedded PowerPC 
> port that Hollis has spear-headed is for an architecture that does not 
> natively support hardware virtualization.  As long as Sparc meets all of 
> the requirements to do this sort of virtualization (all privileged 
> instructions are trappable when run in non-privileged mode), it should 
> be rather straight forward.

It would be even more interesting to implement host support on the Sparc
processors with hardware virtualization support.

Without that, functionality is possible (as we've demonstrated with KVM
on PPC440)... the trick is performance.

-- 
Hollis Blanchard
IBM Linux Technology Center

