From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 12 Feb 2005 19:47:16 +0000
Subject: Re: Xorg doesn't work on the cg3
Message-Id: <20050212114716.26c49e54.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1108062924.3919.22.camel@localhost.localdomain>
In-Reply-To: <1108062924.3919.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 12 Feb 2005 07:49:12 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Fri, 2005-02-11 at 23:44 -0800, David S. Miller wrote:
> 
> >I'm applying this obvious cg3 fix.  There is a bunch of other
> >patches that are necessary to get X fully working on both cg14
> >and cg3 aren't there?  At a minimum there's that BUG() removal
> >in the srmmu code, right?
> 
> Yes. We also need the other cg3 patch to make the framebuffer console
> work, and the sbuslib patch to make cg6 work in X. Both of these are in
> my previous post on this thread.

Gotcha.  I think I have it all in my tree now.  Here is the
changelog manifest, and I'll push this to Linus today.

ChangeSet@1.2027, 2005-02-11 23:24:22-08:00, breuerr@mc.net
  [CG3]: FB mmap .voff and .poff were reversed.
  
  Signed-off-by: David S. Miller <davem@davemloft.net>

ChangeSet@1.2028, 2005-02-11 23:26:37-08:00, tcallawa@redhat.com
  [CG3]: Set framebuffer cmap correctly.
  
  Signed-off-by: David S. Miller <davem@davemloft.net>

ChangeSet@1.2029, 2005-02-11 23:28:08-08:00, tcallawa@redhat.com
  [SPARC]: fb: Fix putcmap handling in sbuslib
  
  Signed-off-by: David S. Miller <davem@davemloft.net>

ChangeSet@1.2030, 2005-02-12 11:14:59-08:00, davem@nuts.davemloft.net
  [SPARC]: Do not BUG() in srmmu_pte_pfn().
  
  For device memory, just return a value that will never
  cause pte_pfn() to return true.
  
  Noticed by Tom Callaway.
  
  Signed-off-by: David S. Miller <davem@davemloft.net>

