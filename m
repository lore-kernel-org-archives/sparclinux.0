From: David Miller <davem@davemloft.net>
Date: Thu, 27 Aug 2015 23:16:05 +0000
Subject: Re: [RFC PATCH 6/9] sparc/sparc64: allocate sys_membarrier system call number
Message-Id: <20150827.161605.86090575394985310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1440698215-8355-7-git-send-email-mathieu.desnoyers@efficios.com>
In-Reply-To: <1440698215-8355-7-git-send-email-mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Thu, 27 Aug 2015 13:56:52 -0400

> [ Untested on this architecture. To try it out: fetch linux-next/akpm,
>   apply this patch, build/run a membarrier-enabled kernel, and do make
>   kselftest. ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Acked-by: David S. Miller <davem@davemloft.net>
