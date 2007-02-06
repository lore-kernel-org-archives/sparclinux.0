From: David Miller <davem@davemloft.net>
Date: Tue, 06 Feb 2007 21:33:46 +0000
Subject: Re: [Bugme-new] [Bug 7951] New: ESP DMA error
Message-Id: <20070206.133346.54189524.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200702061754.l16HsxR6031831@fire-2.osdl.org>
	<20070206132917.ccd7348b.akpm@linux-foundation.org>
In-Reply-To: <20070206132917.ccd7348b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-scsi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, mt1@systella.fr, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 6 Feb 2007 13:29:17 -0800

> Apparently a recent regression.

It's on sparc32 (and SMP on top of that, scary) which is only lightly
maintained, so it could be anything.  It would be interesting if
running a uniprocessor kernel made the problem go away.

I would only be concerned at the scsi layer level if you see a sparc64
report like this.
