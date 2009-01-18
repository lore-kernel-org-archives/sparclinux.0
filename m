From: David Miller <davem@davemloft.net>
Date: Sun, 18 Jan 2009 07:11:09 +0000
Subject: Re: [PATCH] sparc64: fix readout of cpu/fpu type
Message-Id: <20090117.231109.195938626.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090116203419.GA27053@uranus.ravnborg.org>
In-Reply-To: <20090116203419.GA27053@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 21:34:19 +0100

> Meelis reported that on his box /proc/cpuinfo started
> to reported "Unknow CPU" and the same did the boot messages.
> 
> It was a stupid bug I introduced when merging
> cpu.c for 32 and 64 bit.
> 
> The code did an array reference where it had to search
> for the right index.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I noticed this bug about a week ago but was too busy
with other things to look into it.

Thanks for fixing this Sam.
