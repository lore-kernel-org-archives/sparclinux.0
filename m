From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:08:03 +0000
Subject: Re: [PATCH] sparc: beautify kernel/cpu_32.c
Message-Id: <20081205.190803.129126793.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081205174426.GA6900@uranus.ravnborg.org>
In-Reply-To: <20081205174426.GA6900@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 5 Dec 2008 18:44:26 +0100

> Fixed style issues
> Use C99 struct assignments
> Use KERN_DEBUG for printk
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> Looked for similar files and my eyes started to hurt
> when I looked at this code.
> 
> I looked at how sparc64 does it and I like the list of
> real variants better than the sparc32 version with FPU
> and CPU separated.
> 
> But combining the two is for another day.
> 
> If we fail to find the CPU then sparc_cpu_type is unitialized.
> Maybe we should set it to "Unknown CPU" in that case like sparc64 does.
> And if we fail to find the FPU we just pick entry [31] at random..

Applied, thanks Sam.

Ironically I looked at this file yesterday too and also
decided to pass on trying to combine them :)
