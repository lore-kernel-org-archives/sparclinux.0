From: Jamie Lokier <jamie@shareable.org>
Date: Wed, 30 Jun 2004 22:52:20 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630225220.GA32560@mail.shareable.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org> <20040630082804.GS21264@devserv.devel.redhat.com> <20040630135419.25b843b8.davem@redhat.com>
In-Reply-To: <20040630135419.25b843b8.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Jelinek <jakub@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 30 Jun 2004 04:28:05 -0400
> Jakub Jelinek <jakub@redhat.com> wrote:
> 
> > I believe R!X and X!R pages ought to be possible on sparc64 too,
> > just use a different bit as "read" in the fast ITLB miss handler
> > from the one fast DTLB miss uses.
> 
> That's correct.  But I have no plans to implement this
> any time soon :-)

The PaX security patch already implements R!X pages on Sparc64, so you
could just cut out that part of the patch.  Just pick out the changes
to arch/sparc64/* and include/asm-sparc64/*:

	http://pax.grsecurity.net/pax-linux-2.6.7-200406252135.patch

It appears to use exactly the technique Jakub describes, and has been tested.

-- Jamie
