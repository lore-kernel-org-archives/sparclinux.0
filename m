From: wesolows@foobazco.org
Date: Wed, 30 Jun 2004 15:21:07 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630152107.GA20438@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org> <20040629221711.77f0fca5.davem@redhat.com>
In-Reply-To: <20040629221711.77f0fca5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 10:17:11PM -0700, David S. Miller wrote:

> > In include/asm-sparc/pgtsrmmu.h, there's:
> > 
> > #define SRMMU_PAGE_NONE    __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> > 				    SRMMU_PRIV | SRMMU_REF)
> > #define SRMMU_PAGE_RDONLY  __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> > 				    SRMMU_EXEC | SRMMU_REF)
> > 
> > This one bothers me.  The difference is that PROT_NONE pages are not
> > accessible to userspace, and not executable.
> > 
> > So userspace will get a fault if it tries to read a PROT_NONE page.
> > 
> > But what happens when the kernel reads one?  Don't those bits mean
> > that the read will succeed?  I.e. write() on a PROT_NONE page will
> > succeed, instead of returning EFAULT?
> > 
> > If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
> > document it.
> 
> Yes this one is a bug and not intentional.
> 
> Keith W., we need to fix this.  Probably the simplest fix is just to
> drop the SRMMU_VALID bit.

Ok, I'll try this approach and see what happens.

-- 
Keith M Wesolowski
