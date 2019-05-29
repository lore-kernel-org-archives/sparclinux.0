From: Christoph Hellwig <hch@lst.de>
Date: Wed, 29 May 2019 07:26:28 +0000
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-Id: <20190529072628.GA4149@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de> <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com> <2eecb673-cb18-990e-0a61-900ecd056152@oracle.com>
In-Reply-To: <2eecb673-cb18-990e-0a61-900ecd056152@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Tue, May 28, 2019 at 09:57:25AM -0600, Khalid Aziz wrote:
> Since untagging addresses is a generic need required for far more than
> gup, I prefer the way Andrey wrote it -
> <https://patchwork.kernel.org/patch/10923637/>

Linus, what do you think of picking up that trivial prep patch for
5.2?  That way the arm64 and get_user_pages series can progress
independently for 5.3.
