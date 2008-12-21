From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Dec 2008 20:47:38 +0000
Subject: Re: [RFC PATCH] use sparc64 version of of_device.c
Message-Id: <20081221204738.GC18284@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4945AE56.2040503@earthlink.net>
In-Reply-To: <4945AE56.2040503@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 14, 2008 at 08:09:42PM -0500, Robert Reif wrote:
> This patch creates a combined kernel/of_device.c by starting with the
> sparc64 version and adding #ifdefs and sparc32 code.
> 
> The only sparc64 difference is a %llx printk change.
> 
> The sparc32 changes are:
>    change int rlen to unsigned int rlen in build_one_resource
>    keep the sparc64 op->resources[] array size check
> 
> I know #ifdefs are ugly but the files were so similar.
> Is this acceptable?
> 
> Boot tested on sparc32.
> Compile tested on sparc64.

Robert - do you still look after this one?

Note: It is a positive thing that three individuals actually
      reviewed your work!

	Sam
