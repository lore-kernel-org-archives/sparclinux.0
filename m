From: Jakub Jelinek <jakub@redhat.com>
Date: Wed, 30 Jun 2004 08:28:05 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630082804.GS21264@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org>
In-Reply-To: <20040630030503.GA25149@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jamie Lokier <jamie@shareable.org>
Cc: "Keith M. Wesolowski" <wesolows@foobazco.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@redhat.com>, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 04:05:03AM +0100, Jamie Lokier wrote:
> I'm doing a survey of the different architectural implementations of
> PROT_* flags for mmap() and mprotect().  I'm looking at linux-2.6.5.
> 
> The Sparc and Sparc64 implementations are very similar to plain x86:
> read implies exec, exec implies read and write implies read.
> 
> (Aside: A comment in include/asm-sparc/pgtsrmmu.h says that finer-grained
> access is possible.  Quite a few other architectures do implement
> finer-grained access, and even x86 is getting it now, so you may want
> to revisit that.  The code is already available, and tested, if you
> cut that part out of the PaX security patch).

I believe R!X and X!R pages ought to be possible on sparc64 too, just use a
different bit as "read" in the fast ITLB miss handler from the one fast DTLB
miss uses.

	Jakub
