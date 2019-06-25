From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 25 Jun 2019 19:37:57 +0000
Subject: Re: [PATCH 14/16] mm: move the powerpc hugepd code to mm/gup.c
Message-Id: <20190625123757.ec7e886747bb5a9bc364107d@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
        <20190625143715.1689-15-hch@lst.de>
In-Reply-To: <20190625143715.1689-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 16:37:13 +0200 Christoph Hellwig <hch@lst.de> wrote:

> +static int gup_huge_pd(hugepd_t hugepd

Naming nitlet: we have hugepd and we also have huge_pd.  We have
hugepte and we also have huge_pte.  It make things a bit hard to
remember and it would be nice to make it all consistent sometime.

We're consistent with huge_pud and almost consistent with huge_pmd.

To be fully consistent I guess we should make all of them have the
underscore.  Or not have it.  
