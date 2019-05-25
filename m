From: Christoph Hellwig <hch@lst.de>
Date: Sat, 25 May 2019 17:39:05 +0000
Subject: Re: RFC: switch the remaining architectures to use generic GUP
Message-Id: <20190525173905.GA14769@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de> <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
In-Reply-To: <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Sat, May 25, 2019 at 10:07:32AM -0700, Linus Torvalds wrote:
> Looks good to me apart from the question about sparc64 (that you also
> raised) and requesting that interface to be re-named if it is really
> needed.
> 
> Let's just do it (but presumably for 5.3), and any architecture that
> doesn't react to this and gets broken because it wasn't tested can get
> fixed up later when/if they notice.

FYI, my compile testing was very basic and a few issues showed up
from the build bot later on.  I'll keep the branch here uptodate
for now:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-gup

and won't resend until we make progress on the pointer tagging
thing.  I've also got a few follow on patches on top, so they might
be ready by then as well.
