From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 26 Oct 2004 06:48:13 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041025234813.62f56eba.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 26 Oct 2004 02:28:19 -0400
mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:

> Anyone know *why* this 7.5MB limit exists?

Because we lock the kernel image into the TLB, we use
4MB TLB entries (the largest UltraSPARC currently supports)
and locking 2 entries is what we limit things to.

Use modules dude.  Also, strip all debugging information
and unnecessary symbol table entries from your kernel
as well.  "make image" helps with this, use the
arch/sparc64/boot/image file that rule creates not
the top-level vmlinux file.
