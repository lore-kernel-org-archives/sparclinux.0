From: Davidlohr Bueso <davidlohr@hp.com>
Date: Wed, 06 Aug 2014 21:30:14 +0000
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable optimistic spinning on some architectur
Message-Id: <1407360614.3395.2.camel@buesod1.americas.hpqcorp.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
 <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
In-Reply-To: <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2014-08-06 at 17:25 -0400, Andev wrote:
> On Wed, Aug 6, 2014 at 4:54 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> > This is a note to let you know that I have just added a patch titled
> >
> >     locking/mutex: Disable optimistic spinning on some architectures
> >
> > to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree
> > which can be found at:
> >
> >  http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue
> >
> > This patch is scheduled to be released in version 3.13.11.6.
> >
> 
> This patch is specifically for parisc, sparc32, tile32, metag-lock1,
> arc-!llsc and hexagon none of which Ubuntu supports.
> 
> Why are you backporting this patch?

Well 3.13.y.z isn't an Ubuntu kernel, its upstream, and those archs
*are* supported.

