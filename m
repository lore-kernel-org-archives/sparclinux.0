From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 15 May 2020 16:25:50 +0000
Subject: Re: [PATCH v2] Implement close-on-fork
Message-Id: <1589559950.3653.11.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
         <20200515155730.GF16070@bombadil.infradead.org>
         <5b1929aa9f424e689c7f430663891827@garmin.com>
In-Reply-To: <5b1929aa9f424e689c7f430663891827@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Karstens, Nate" <Nate.Karstens@garmin.com>, Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, netdev@vger.ker

On Fri, 2020-05-15 at 16:07 +0000, Karstens, Nate wrote:
> Matthew,
> 
> What alternative would you suggest?
> 
> From an earlier email:
> 
> > ...nothing else addresses the underlying issue: there is no way to
> > prevent a fork() from duplicating the resource. The close-on-exec
> > flag partially-addresses this by allowing the parent process to
> > mark a file descriptor as exclusive to itself, but there is still
> > a period of time the failure can occur because the auto-close only
> > occurs during the exec(). Perhaps this would not be an issue with
> > a different process/threading model, but that is another discussion
> > entirely.
> 
> Do you disagree there is an issue?

Oh good grief that's a leading question: When I write bad code and it
crashes, most people would agree there is an issue; very few would
agree the kernel should be changed to fix it. Several of us have
already said the problem seems to be with the way your application is
written.  You didn't even answer emails like this speculating about the
cause being the way your application counts resources:

https://lore.kernel.org/linux-fsdevel/1587569663.3485.18.camel@HansenPartnership.com/

The bottom line is that we think you could rewrite this one application
not to have the problem you're complaining about rather than introduce
a new kernel API to "fix" it.

James
