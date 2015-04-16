From: David Miller <davem@davemloft.net>
Date: Thu, 16 Apr 2015 19:26:14 +0000
Subject: Re: [PATCH] cpumask: remove __first_cpu / __next_cpu
Message-Id: <20150416.152614.2206192390901163987.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87k2xcr8cr.fsf@rustcorp.com.au>
In-Reply-To: <87k2xcr8cr.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rusty@rustcorp.com.au
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 16 Apr 2015 14:13:32 +0930

> [ Final grep before push to Linus revealed sparc used these directly,
>   please Ack.  Against my cpumask-next tree. ]
> 
> They were for use by the deprecated first_cpu() and next_cpu() wrappers,
> but sparc used them directly.
> 
> They're now replaced by cpumask_first / cpumask_next.  And __next_cpu_nr
> is completely obsolete.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: David S. Miller <davem@davemloft.net>

