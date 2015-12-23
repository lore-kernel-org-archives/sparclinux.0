From: David Miller <davem@davemloft.net>
Date: Wed, 23 Dec 2015 20:02:22 +0000
Subject: Re: [PATCH] sparc64: fix FP corruption in user copy functions
Message-Id: <20151223.150222.2020138597482887277.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450851889-8950-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450851889-8950-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 23 Dec 2015 10:31:01 -0700

> On 12/23/2015 09:21 AM, David Miller wrote:
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Tue, 22 Dec 2015 23:24:49 -0700
>>
>>> Short story: Exception handlers used by some copy_to_user() and
>>> copy_from_user() functions do not diligently clean up floating point
>>> register usage, and this can result in a user process seeing invalid
>>> values in floating point registers. This sometimes makes the process
>>> fail.
>> Can you show me a specific example where the FPU register contents
>> actually matter?
>>
>> When we are copying to or from userspace, we are in a most of the time
>> system call, and for that specific case all FPU registers are volatile
>> across the system call.
>>
>> I guess it might matter for the perf stack backtrace stuff.
>>
> 
> It does matter for the perf stack backtrace case. Running "perf record
> -g ..." can cause random processes to experience FP register
> corruption. Most of the time this is not noticed, but once in a while
> it can cause a process to get incorrect results or corrupted data.
> 
> This bug seriously affects system stability when using perf, and was
> discovered while studying the plethora of perf problems.

Great, thanks for the info.  I'll do some testing here and apply this
to the sparc GIT tree.
