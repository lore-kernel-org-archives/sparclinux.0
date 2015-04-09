From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2015 22:34:13 +0000
Subject: Re: system call tracing on sparc
Message-Id: <20150409.183413.2223988028345855364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5526FAC8.8000309@oracle.com>
In-Reply-To: <5526FAC8.8000309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 09 Apr 2015 16:21:27 -0600

> On 4/9/15 4:18 PM, David Ahern wrote:
>> Dave:
>>
>> Have you ever used system call tracing on sparc? It does not work for
>> 2.6.39 or 4.0; wondering if it has ever worked. I see signs in
>> arch/sparc/kernel/syscalls.S for example that suggests it should have
>> at
>> one point.
>>
> 
> To clarify I mean through perf. Using the tracing interface via
> debugfs I can get the raw_syscall tracepoints, just not through perf.

Oh, I've never tried to use that.

Only the usual syscall tracing faciltiies via ptrace() that programs
like strace make use of.
