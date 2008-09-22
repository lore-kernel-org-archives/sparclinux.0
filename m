From: Anthony Liguori <anthony@codemonkey.ws>
Date: Mon, 22 Sep 2008 19:34:21 +0000
Subject: Re: KVM for Sparc?
Message-Id: <48D7F33D.90007@codemonkey.ws>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com> <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
In-Reply-To: <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Blue Swirl <blauwirbel@gmail.com>
Cc: kvm@vger.kernel.org, sparclinux@vger.kernel.org, John Levon <levon@movementarian.org>, Hollis Blanchard <hollisb@us.ibm.com>

Blue Swirl wrote:
> Hi,
>
>  Sorry for cross-posting (and because I used the wrong address in the
> first time for KVM, sorry for the duplicate on Sparclinux).
>
>  Sparc host support for Qemu is getting close
>  to ready, I can already run a Sparc32 system emulator on
>  OpenBSD/Sparc64 and there is some limited success with recent glibc on
>  Linux/Sparc64. Otherwise Sparc32 target emulator is pretty stable.
>  Sparc64 target emulator can boot from several CD images, but crashes
>  pretty soon.
>
>  But I think we could already start early drafting of what KVM support
>  for Sparc32 and Sparc64 would mean. Because of certain problems in the
>  V9 instruction set design (V8 rett reuse for example), it may be
>  difficult or even impossible to use an accelerator if the host and
>  target instruction sets do not match.
>   

I don't know much about the Sparc architecture, but the embedded PowerPC 
port that Hollis has spear-headed is for an architecture that does not 
natively support hardware virtualization.  As long as Sparc meets all of 
the requirements to do this sort of virtualization (all privileged 
instructions are trappable when run in non-privileged mode), it should 
be rather straight forward.

KVM has code to do shadow paging and also software TLB virtualization, 
so depending on how Sparc manages the TLB, it should be pretty straight 
forward to base the Sparc code from the appropriate code that already 
exists.

>  Other possibilities include porting kqemu or Xen, but I think KVM has
>  the brightest future.
>
>  I'm interested in pushing the Qemu side forward, but obviously
>  something needs to be done by the kernel/KVM people too.

KVM supports x86, ia64, s390, and PPC today.  I don't think there would 
be any problems adding another architecture support.  Almost all of the 
abstractions should have been flushed out already by the previous 
architecture ports.  Moreover, since there is already good support for 
Sparc in QEMU, that should simplify things significantly.

I'm looking forward to seeing the progress you make!

Regards,

Anthony Liguori

>  What is the
>  feeling on KVM and Sparclinux side?
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

