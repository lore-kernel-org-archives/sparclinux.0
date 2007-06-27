From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 27 Jun 2007 19:00:26 +0000
Subject: Re: [1/2] 2.6.22-rc6: known regressions
Message-Id: <Pine.LNX.4.61.0706271944590.16177@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <467F8B35.4010906@googlemail.com> <467F8F78.8090700@googlemail.com>
In-Reply-To: <467F8F78.8090700@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ioan Ionita <opslynx@gmail.com>

Hi All,

I have done some more work on the sun4c Sparc32 random invalid instruction 
occourances. The issue only affects the SLAB allocator. The SLUB and SLOB 
allocators both work OK but SLOB is dreadfully slow making it totally 
impractical for use on my sun4c. Isolating the problem to the SLAB 
allocator should make it a bit easier to track down the problem.

It may be desirable to put a comment into Kconfig to indicate that the 
SLAB allocator is currently broaken for sun4c but that SLUB works well as 
I dought that I will have found/fixed the problem before 2.6.22.

Regards
 	Mark Fortescue.

On Mon, 25 Jun 2007, Michal Piotrowski wrote:

> Hi all,
> 
> Here is a list of some known regressions in 2.6.22-rc6.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> *STATISTICS* (a.k.a. list of aces)
> 
> Name                    Regressions fixed since 21-Jun-2007
> Andi Kleen                             1
> Hugh Dickins                           1
> Jean Delvare                           1
> 
> 
> 
> Sparc64
> 
> Subject    : random invalid instruction occourances on sparc32 (sun4c)
> References : http://lkml.org/lkml/2007/6/17/111
> Submitter  : Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Status     : problem is being debugged
> 
> Subject    : 2.6.22-rc broke X on Ultra5
> References : http://lkml.org/lkml/2007/5/22/78
> Submitter  : Mikael Pettersson <mikpe@it.uu.se>
> Handled-By : David Miller <davem@davemloft.net>
> Status     : problem is being debugged
> 
> 
> 
> x86-64
> 
> Subject    : x86-64 2.6.22-rc2 random segfaults
> References : http://lkml.org/lkml/2007/5/24/275
> Submitter  : Ioan Ionita <opslynx@gmail.com>
> Status     : Unknown
> 
> 
> 
> Regards,
> Michal
> 
> --
> LOG
> http://www.stardust.webpages.pl/log/
>
