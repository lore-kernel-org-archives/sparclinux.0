From: David Ahern <david.ahern@oracle.com>
Date: Fri, 10 Apr 2015 02:13:23 +0000
Subject: Re: system call tracing on sparc
Message-Id: <552731C3.5050900@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526FAC8.8000309@oracle.com>
In-Reply-To: <5526FAC8.8000309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/9/15 4:21 PM, David Ahern wrote:
>> Have you ever used system call tracing on sparc? It does not work for
>> 2.6.39 or 4.0; wondering if it has ever worked. I see signs in
>> arch/sparc/kernel/syscalls.S for example that suggests it should have at
>> one point.
>>
>
> To clarify I mean through perf. Using the tracing interface via debugfs
> I can get the raw_syscall tracepoints, just not through perf.

hmmm... nevermind. It does work on 4.0 (too many perf problems and too 
many kernel versions). I'll figure out when it started working.
