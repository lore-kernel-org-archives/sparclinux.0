From: David Ahern <david.ahern@oracle.com>
Date: Fri, 10 Apr 2015 01:33:04 +0000
Subject: Re: system call tracing on sparc
Message-Id: <55272850.5010005@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526FAC8.8000309@oracle.com>
In-Reply-To: <5526FAC8.8000309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/9/15 4:34 PM, David Miller wrote:
>>> Have you ever used system call tracing on sparc? It does not work for
>>> 2.6.39 or 4.0; wondering if it has ever worked. I see signs in
>>> arch/sparc/kernel/syscalls.S for example that suggests it should have
>>> at
>>> one point.
>>>
>>
>> To clarify I mean through perf. Using the tracing interface via
>> debugfs I can get the raw_syscall tracepoints, just not through perf.
>
> Oh, I've never tried to use that.
>
> Only the usual syscall tracing faciltiies via ptrace() that programs
> like strace make use of.
>

strace works fine, but the overhead of ptrace limits its use for 
performance analysis. The entries in the trace facility are not user 
friendly:

sshd-14987 [008] 25489.727139: sys_enter: NR 93 (b, 100001c8f10, 
100001c8ef0, 0, 0, 0)
sshd-14987 [008] 25489.727141: sys_exit: NR 93 = 93
sshd-14987 [008] 25489.727143: sys_enter: NR 103 (1, 7feff9d8bb8, 
7feff9d8c38, 8, fffffc01017d8d4c, 7feff9d8bb8)
sshd-14987 [008] 25489.727144: sys_exit: NR 103 = 103

The point of perf-trace is user friendly output (well, not user friendly 
with line wrapping):

      1.200 ( 0.023 ms): ls/13344 write(fd: 1, buf: 0x7f023781f000, 
count: 90                           ) = 90
      1.226 ( 0.022 ms): ls/13344 write(fd: 1, buf: 0x7f023781f000, 
count: 81                           ) = 81

and the low overhead means you can use it to get stats to analyze 
performance problems.

I'll ping Frederic and Steve for ideas on where to look.

