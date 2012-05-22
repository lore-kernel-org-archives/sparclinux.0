From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 22 May 2012 17:10:51 +0000
Subject: Re: [PATCH] sparc32: use the common implementation of alloc_thread_info_node()
Message-Id: <alpine.LFD.2.02.1205221909540.3231@ionos>
List-Id: <sparclinux.vger.kernel.org>
References: <20120522151123.GA10058@merkur.ravnborg.org>
In-Reply-To: <20120522151123.GA10058@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Tue, 22 May 2012, Sam Ravnborg wrote:

> >From 52d8a6d1b81a19e693a09df90275600f44293f43 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 22 May 2012 16:39:00 +0200
> Subject: [PATCH] sparc32: use the common implementation of alloc_thread_info_node()
> 
> With sun4c removed we can fall-back to the common implementation.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> 
> This is not a "real" bug but I would like it applied anyway.
> Thomas Gleixner <tglx@linutronix.de> consolidated all
> alloc_thread_info_node() implmentations but sparc32 was
> left out due to sun4c weirdness.
> 
> With sun4c gone we can align with the rest of the world.
> (and I promised Thomas to follow-up on this when his patch-set was merged).

Thanks!

