From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:08:41 +0000
Subject: Re: [PATCH] sparc: report "Unknown CPU/FPU" for unknown cpu/fpu
Message-Id: <20081205.190841.170458364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081205195522.GA8526@uranus.ravnborg.org>
In-Reply-To: <20081205195522.GA8526@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 5 Dec 2008 20:55:22 +0100

> If we cannot determine the CPU or FPU report
> "Unknown CPU" or "Unknown FPU" like sparc64 does.
> 
> And report with KERN_ERR that we cannot determine the CPU.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> This killed the magic [31] I complained about in last mail.

Also applied, thanks Sam.
