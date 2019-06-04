From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 04 Jun 2019 11:46:56 +0000
Subject: Re: [PATCH 01/16] uaccess: add untagged_addr definition for other arches
Message-Id: <CAAeHK+xtFwY+S0VY-yyb+i_+GnSjYHfgYHB9Ss=r9xxZZvsKFw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-2-hch@lst.de>
 <431c7395-2327-2f7c-cc8f-b01412b74e10@oracle.com> <20190604072706.GF15680@lst.de>
In-Reply-To: <20190604072706.GF15680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>

On Tue, Jun 4, 2019 at 9:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 03, 2019 at 09:16:08AM -0600, Khalid Aziz wrote:
> > Could you reword above sentence? We are already starting off with
> > untagged_addr() not being no-op for arm64 and sparc64. It will expand
> > further potentially. So something more along the lines of "Define it as
> > noop for architectures that do not support memory tagging". The first
> > paragraph in the log can also be rewritten to be not specific to arm64.
>
> Well, as of this patch this actually is a no-op for everyone.
>
> Linus, what do you think of applying this patch (maybe with a slightly
> fixed up commit log) to 5.2-rc so that we remove a cross dependency
> between the series?

(I have adjusted the patch description and have just sent it out
separately from the series).
