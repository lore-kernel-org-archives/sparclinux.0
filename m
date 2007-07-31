From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Tue, 31 Jul 2007 16:57:06 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070731185706.1dca905b.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 30 Jul 2007 18:22:13 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> 
> I would suggest that, for now, we address the bug itself by
> merely converting sunlance over to the of_*() interfaces.
> 
> The patch below is what I'm going to check in upstream.
> 

The patch is working, the module no longer crashes
or hangs.

I'll try tracking this down further to find what is going on.

As a side note. I would do the patch if you ask for checking
this direction. You are too valuable resource too do all the
work (especially with patches like this). Try offload the work.
We need you to solve problems impossible to solve (as every wizard
from the highest knowledge ring you can do impossible things,
just they take you more time than making miracles ;-)

Regards,
Krzysztof
