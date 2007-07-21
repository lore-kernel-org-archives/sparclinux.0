From: David Miller <davem@davemloft.net>
Date: Sat, 21 Jul 2007 19:05:30 +0000
Subject: Re: [PATCH] Alter sparc32 __ndelay/__udelay delay calculations
Message-Id: <20070721.120530.72712824.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707211703570.10310@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707211703570.10310@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 21 Jul 2007 18:49:46 +0100 (BST)

> __ndelay and __udelay have not been delaying >= specified time.
> The problem with __ndelay has been tacked down to the rounding of the
> multiplier constant. By changing this, delays > app 18us are correctly
> calculated.
> The problem with __udelay has also been tracked down to rounding issues.
> Changing the multiplier constant (to match that used in sparc64) corrects
> for large delays and adding in a rounding constant corrects for trunctaion
> errors in the claculations for short delays.
> Many short delays will return without looping. This is not an error as there
> is the fixed delay of doing all the maths to calculate the loop count.
> 
> Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>

Thanks for investigating this Mark, I'll merge this in after
I look over it a bit.
