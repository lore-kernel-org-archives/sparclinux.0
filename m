From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Tue, 26 Oct 2004 09:50:11 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041026095011.GQ17506@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Oct 25, 2004 at 11:48:13PM -0700, David S. Miller wrote:
> On Tue, 26 Oct 2004 02:28:19 -0400
> mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> 
> > Anyone know *why* this 7.5MB limit exists?
> 
> Because we lock the kernel image into the TLB, we use
> 4MB TLB entries (the largest UltraSPARC currently supports)
> and locking 2 entries is what we limit things to.

Interesting! What is a TLB entry though -- a set range of TLB address
space? If the UltraSPARC has a max size 4MB TLB, how can we lock two 4MB TLBs
entries?

> Use modules dude. 

I do man, for some reason I just keep getting it bloated. I'll use that
defconfig file now though :)

> Also, strip all debugging information
> and unnecessary symbol table entries from your kernel
> as well.  

Well I'm using this as a dev box so I wan to keep this.

> "make image" helps with this, use the
> arch/sparc64/boot/image file that rule creates not
> the top-level vmlinux file.

I tried using that image file and the kernel would hang. Not sure why
:T.

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
