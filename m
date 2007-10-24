From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Oct 2007 16:14:48 +0000
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
Message-Id: <20071024161448.GA3166@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200710111754.46854.rob@landley.net> <20071024152240.GA7733@c2.user-mode-linux.org>
In-Reply-To: <20071024152240.GA7733@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>, sparclinux@vger.kernel.org
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi Jeff.

On Wed, Oct 24, 2007 at 11:22:40AM -0400, Jeff Dike wrote:
> On Thu, Oct 11, 2007 at 05:54:46PM -0500, Rob Landley wrote:
> > Guess what?  I still need this patch to build the final 2.6.23, months later.
> > 
> > I know it may not be the right fix, but the build breaks for me without this 
> > patch. The .config that breaks is attached.  ARCH=um.
> 
> Can I get a Signed-off-by: on that?
> 
> It's not the right fix - the base of the problem is in swap.h, which
> has this comment: 
> 	/* only sparc can not include linux/pagemap.h in this file
> 	 * so leave page_cache_release and release_pages undeclared... */
> 
> I poked around a bit for a sparc cross-toolchain, didn't find one, so
> I couldn't see what exactly the problem was.
> 
> So, I'll take this fix.

Dan Kegel's crosstool builds sparc just fine.
And for sparc issues I recommend cc:ing the sparc ML.

[Original mail (with patch) is here: http://lkml.org/lkml/2007/10/11/288]

	Sam
