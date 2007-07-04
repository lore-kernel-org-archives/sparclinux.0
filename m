From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 04 Jul 2007 14:46:03 +0000
Subject: Re: [PATCH] Re: Sparc32: random invalid instruction occourances on
Message-Id: <1183560364.29081.106.camel@shinybook.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <468A7D14.1050505@googlemail.com>
	 <Pine.LNX.4.61.0707031817050.29930@mtfhpc.demon.co.uk>
	 <Pine.LNX.4.61.0707031910280.29930@mtfhpc.demon.co.uk>
	 <1183490778.29081.35.camel@shinybook.infradead.org>
	 <Pine.LNX.4.61.0707032209230.30376@mtfhpc.demon.co.uk>
	 <1183499781.29081.46.camel@shinybook.infradead.org>
	 <Pine.LNX.4.61.0707032317590.30376@mtfhpc.demon.co.uk>
	 <1183505787.29081.62.camel@shinybook.infradead.org>
	 <Pine.LNX.4.61.0707040335230.30946@mtfhpc.demon.co.uk>
	 <1183520006.29081.79.camel@shinybook.infradead.org>
	 <Pine.LNX.4.61.0707041121290.31752@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707041121290.31752@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Christoph Lameter <clameter@engr.sgi.com>, William Lee Irwin III <wli@holomorphy.com>

On Wed, 2007-07-04 at 11:27 +0100, Mark Fortescue wrote:
> Another related point that may also need to be considered is that I think 
> I am correct in saying that on ARM and on the 64bit platforms, sizeof 
> (unsigned long long) is 16 (128bits).

No, it's always 64 bits.

> Should the RedZone words be specified as __u64 not the unsigned long long 
> used or does the alignment need to be that of unsigned long long ?

You have to play silly buggers with printk formats (%lx vs. %llx) if you
do that. And you have to make a choice about using proper C types or the
Linux-specific nonsense. 'unsigned long long' is just easier all round.

-- 
dwmw2

