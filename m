From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Sat, 10 Aug 2019 19:36:26 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CAM43=SNbjVJRZs7r=GqFG0ajOs5wY4pZzr_QfVZinFRWV8ioBg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
 <20190810071701.GA23686@lst.de>
In-Reply-To: <20190810071701.GA23686@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Anatoly Pugachev <matorola@gmail.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Khalid Aziz <khalid.aziz@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>

For the record the futex test case OOPSes a 5.3-rc3 kernel running on
a Sun Blade 2500 (2 x USIIIi).  This system runs a custom distro with
a custom toolchain (gcc-8.3 based), so I doubt it's a distro problem.

On Sat, Aug 10, 2019 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There isn't really a way to use an arch-specific get_user_pages_fast
> in mainline, you'd need to revert the whole series.  As a relatively
> quick workaround you can just remove the
>
>         select HAVE_FAST_GUP if SPARC64
>
> line from arch/sparc/Kconfig
