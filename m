From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Thu, 16 Oct 2008 00:32:51 +0000
Subject: Re: [PATCH] sparc64: Annotate pointers in PeeCeeI.c
Message-Id: <1224117171.5815.17.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <1224116119.5815.11.camel@brick>
	 <20081015.172351.96225000.davem@davemloft.net>
In-Reply-To: <20081015.172351.96225000.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Wed, 2008-10-15 at 17:23 -0700, David Miller wrote:
> From: Harvey Harrison <harvey.harrison@gmail.com>
> Date: Wed, 15 Oct 2008 17:15:19 -0700
> 
> > This has no functional changes, but annotates the code to make
> > the endianness more clear.  In addition, removes some of the only
> > users of cpu_to_le[16|32]p in the kernel.
> > 
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Remind me what the problem is with cpu_to_{le,be}*()?
> 

Nothing inherently wrong with them, other than it seems that nearly
every user (not this one) would be better served using the by-value
versions.

> The interface names define a direction, which in this case is
> "CPU endianness to BE/LE endianness".  And that is exactly
> what is happening in the out*() routines.
> 
> This aids comprehension of the code and is quite useful IMHO.

Yes, and even from that angle I think my patch is more instructive to
understanding the direction, compare for example in the same file
outsw versus outsl which this patch changes.

Harvey



