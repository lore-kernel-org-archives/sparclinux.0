From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Wed, 27 Oct 2004 23:57:39 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041027235739.GC18916@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 27, 2004 at 06:58:15PM -0400, Adam Kropelin wrote:
> Luis R. Rodriguez wrote:
> >On Mon, Oct 25, 2004 at 11:48:13PM -0700, David S. Miller wrote:
> >>On Tue, 26 Oct 2004 02:28:19 -0400
> >>mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> >>
> >>>Anyone know *why* this 7.5MB limit exists?
> >>
> >>Because we lock the kernel image into the TLB, we use
> >>4MB TLB entries (the largest UltraSPARC currently supports)
> >>and locking 2 entries is what we limit things to.
> >
> >Interesting! What is a TLB entry though -- a set range of TLB address
> >space? If the UltraSPARC has a max size 4MB TLB, how can we lock two
> >4MB TLBs entries?
> 
> Speaking for the general case, since I am not a sparc64 MMU guru: The TLB 
> is a cache of virtual-to-physical address translations. A TLB holds 
> multiple enties, each of which provides the translation for a particular 
> region of address space. The size of the region being mapped is selected 
> from among the set of possibilities offered by the hardware. What David is 
> saying is that on sparc64 the largest choice is 4 MB and since, by 
> convention, 2 TLB entries are reserved for the kernel image that means a 
> max kernel size of 8 MB.

Adam this is great thanks. So -- an entry is just an address space
defined by:

a. Starting memory address
b. Size (availalble options are hardware-specific)

Is this correct?

Also, who is in charge reserving these these 2 TLB entries ? silo?
How big is sparc64's TLB? This is a bit OT but I read something that 
said x86 processors have a really small TLB. What do we do on x86 to
boot the kernl? How about other procs?

Also, anyoe here use grub for sparc? How's that going?

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
