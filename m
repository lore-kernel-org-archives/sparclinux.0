From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 30 Jul 2007 18:16:11 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070730201611.277b75e9.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 30 Jul 2007 15:19:51 +0100 (BST)
Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:

> Hi Krzysztof,
> 
> I have found a commit that messes up sun4c. On removal of this commit I 
> have a working kernel so if there are any problems in the prom code, they 
> do not show up on my SS1 clone (V0 Prom) or SS2 (V2 Prom).
> 
> I have attached the commit that I have had to temporally back out incase 
> it is a general issue for Sparc32. Could you do a test for me with your 
> test code but with the attached patch backed out?
> 

It does not help with my problem (hang/crash inside prom functions).
I applied the commit you sent (with -R) and on the new kernel I can still
reproduce the bug I had.

Regards,
Krzysztof
