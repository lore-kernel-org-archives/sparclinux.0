From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 29 Jul 2007 20:56:25 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070729205625.GK16817@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk> <20070728234856.0fb78952.krzysztof.h1@wp.pl> <20070729003855.1c5422ed.krzysztof.h1@wp.pl> <Pine.LNX.4.61.0707290011300.28457@mtfhpc.demon.co.uk> <20070729174535.9eb6d0aa.krzysztof.h1@wp.pl> <Pine.LNX.4.61.0707291900010.31211@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707291900010.31211@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Sun, Jul 29, 2007 at 07:26:29PM +0100, Mark Fortescue wrote:
>...
> I am going to try to cherry pick a set of commits to see if I can't get a 
> better idear of where the memory corruption on sun4c is coming from. Build 
> problems sue to the DMA changes make git bisecting un-usable untill I have 
> found out which patches fix the DMA build issues.

You have any known-good kernel?

Boot back into this kernel for bisecting and compiling the kernels for 
bisecting there.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

