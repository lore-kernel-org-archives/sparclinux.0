From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 15 Jun 2007 09:11:49 +0000
Subject: Re: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070615091149.GO15426@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070612231600.GA8953@palantir8>
In-Reply-To: <20070612231600.GA8953@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 14, 2007 at 08:19:12PM +0100, Martin Habets wrote:
> I understand it slows down things a lot. Do you mean it has no
> run-time value when debugging suspected MM problems? I do get
> different output: unhandled paging request with strict MM checking
> versus a DMA error without.
> Now for the new patch attempt:
> Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes some
> build errors for sparc32. This patch against 2.6.21 fixes these.

Unhandled paging request vs. DMA errors? This sounds ominous. What
CPU type?


-- wli
