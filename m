From: David Miller <davem@davemloft.net>
Date: Fri, 19 Mar 2010 01:57:57 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100318.185757.39197211.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4BA1F2BA.30604@kernel.org>
	<20100318.175413.183069013.davem@davemloft.net>
	<20100319013119.GB22095@nowhere>
In-Reply-To: <20100319013119.GB22095@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: tj@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 19 Mar 2010 02:31:22 +0100

> On Thu, Mar 18, 2010 at 05:54:13PM -0700, David Miller wrote:
>> From: Tejun Heo <tj@kernel.org>
>> Date: Thu, 18 Mar 2010 18:30:34 +0900
>> 
>> >  
>> >  	if (!total_profile_count) {
>> > -		buf = (char *)alloc_percpu(perf_trace_t);
>> > +		buf = (char *)__alloc_percpu(sizeof(perf_trace_t),
>> > +					     __alignof__(unsigned long));
>> >  		if (!buf)
>> >  			goto fail_buf;
>> 
>> Why not make perf_trace_t have the proper alignment?
> 
> 
> So, making perf_trace_t as align(8) would do the trick?
> I lack the knowledge about alignment layout for archs that
> need aligned accesses.
> At a first glance, what I would except is that every buffer
> has a base address aligned, no?

Make it of the largest type that could appeat
in a trace entry.

I would use u64 so something like:

	u64 [FTRACE_MAX_PROFILE_SIZE / sizeof(u64)]
