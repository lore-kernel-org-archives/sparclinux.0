From: David Miller <davem@davemloft.net>
Date: Fri, 19 Mar 2010 00:54:13 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100318.175413.183069013.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318044930.GC5045@nowhere>
	<4BA1F2BA.30604@kernel.org>
In-Reply-To: <4BA1F2BA.30604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 18 Mar 2010 18:30:34 +0900

>  
>  	if (!total_profile_count) {
> -		buf = (char *)alloc_percpu(perf_trace_t);
> +		buf = (char *)__alloc_percpu(sizeof(perf_trace_t),
> +					     __alignof__(unsigned long));
>  		if (!buf)
>  			goto fail_buf;

Why not make perf_trace_t have the proper alignment?

That's better than patching around it like this.

Defining it as an array of char[]'s is just asking
for lots of trouble.
