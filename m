From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 02 May 2019 23:15:42 +0000
Subject: Re: Linux 5.1-rc5
Message-Id: <20190502231542.GA9336@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
In-Reply-To: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Hillf Danton <dhillf@gmail.com>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Stas Sergeev <stsp@list.ru>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Khalid Aziz <khalid.aziz@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, sparclinux@vger.kernel.org

On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> largely irrelevant, partly since even theoretically this whole issue
> needs a _lot_ of memory.

Adding the relevant people - while the might be irrelevant, at least
mips and sparc have some giant memory systems.  And I'd really like
to see the arch-specific GUP implementations to go away for other
reasons, as we have a few issues to sort out with GUP usage now
(we just had discussions at LSF/MM), and the less implementations we
have to deal with the better.
