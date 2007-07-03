From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 03 Jul 2007 17:50:26 +0000
Subject: Re: [1/2] 2.6.22-rc7: known regressions
Message-Id: <200707031950.27162.bzolnier@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <468A7D14.1050505@googlemail.com>
In-Reply-To: <468A7D14.1050505@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>


Hi,

On Tuesday 03 July 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject    : 2.6.22-rcX: hda: lost interrupt
> References : http://lkml.org/lkml/2007/6/29/121
> Submitter  : David Chinner <dgc@sgi.com>
> Status     : unknown

David, any news on this one?

Have you tried libata as suggested by Jeff?

[ would exclude IRQ routing issue or broken hardware ]

Thanks,
Bart
