From: Mark Fortescue <sparc32@mtfhpc.demon.co.uk>
Date: Tue, 31 Jul 2007 03:05:52 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <Pine.LNX.4.61.0707310358480.3585@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

>
> I would suggest that, for now, we address the bug itself by
> merely converting sunlance over to the of_*() interfaces.
>
> The patch below is what I'm going to check in upstream.
>
> If you find anything interesting in arch/sparc/prom/tree.c et al.
> please let me know.
>

I has a look through it but since it works for both my SS1 and SS2, it 
would seem that this is a problem that is specific to the SMP system. In 
some Solaris source I found on the web, there are some odd comments about 
the OBP locking to an specific processor, resulting in prom calls from 
other processors entering a never ending spin-lock. Maybe it could be 
related to this.

Regards
 	Mark Fortescue.
