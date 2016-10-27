From: David Miller <davem@davemloft.net>
Date: Thu, 27 Oct 2016 14:55:39 +0000
Subject: Re: [PATCH] sparc64: Make SLUB the default allocator
Message-Id: <20161027.105539.1624301498966110301.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1477520897-47950-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1477520897-47950-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: sowmini.varadhan@oracle.com, aaron.young@oracle.com, bp@suse.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 26 Oct 2016 15:27:56 -0700

> SLUB has better debugging support.
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
 ...
> @@ -7,7 +7,9 @@ CONFIG_LOG_BUF_SHIFT
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLAB=y
> +CONFIG_SLUB_DEBUG=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_CPU_PARTIAL=y
>  CONFIG_PROFILING=y
>  CONFIG_OPROFILE=m
>  CONFIG_KPROBES=y

This patch made me try to find guidance on other architectures as to what
they put in their defconfig files.

And it seems to me that they leave things like this to the user, and the
defconfig only really contains things that really are required by the
architecture or are architecture specific.

So maybe instead of making arbitrary choices for these values which
one set of users want and another set of users do not (I prefer SLAB,
it is faster, and I know what the downsides wrt. NUMA balancing
compared to SLAB are and am willing to accept that), we should do
what other platforms do and not specify things like this at all.
