From: Christoph Hellwig <hch@lst.de>
Date: Tue, 04 Jun 2019 07:26:10 +0000
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
Message-Id: <20190604072610.GE15680@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-4-hch@lst.de> <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com> <20190603074121.GA22920@lst.de> <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com> <CAHk-=wjU3ycY2FvhKmYmOTi95L0qSi9Hj+yrzWTAWepW-zdBOA@mail.gmail.com>
In-Reply-To: <CAHk-=wjU3ycY2FvhKmYmOTi95L0qSi9Hj+yrzWTAWepW-zdBOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Mon, Jun 03, 2019 at 10:02:10AM -0700, Linus Torvalds wrote:
> On Mon, Jun 3, 2019 at 9:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The new code has no test at all for "nr_pages = 0", afaik.
> 
> Note that it really is important to check for that, because right now we do

True.  The 0 check got lost.  I'll make sure we do the right thing for
the next version.
