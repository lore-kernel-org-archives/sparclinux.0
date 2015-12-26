From: Rob Gardner <rob.gardner@oracle.com>
Date: Sat, 26 Dec 2015 05:02:43 +0000
Subject: Re: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <567E1F73.6000406@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/25/2015 09:25 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Thu, 24 Dec 2015 10:39:05 -0700
>
>> Sorry I should have noted this in the log message, but we
>> intentionally did not use get_fs() and set_fs() there because they are
>> not safe to use in a "nested" interrupt context.  n.b. get_fs() is not
>> guaranteed to report a value consistent with %asi while we're
>> executing the perf interrupt handler, because it may have interrupted
>> kernel code where %asi is inconsistent with the thread_info current_ds
>> value. This is common, e.g. right in NGmemcpy.
> Is that a real problem?
>
> The return from trap will restore the %asi register properly from
> the %tstate register.
>

It's not a problem for the context that was interrupted since as you 
say, %asi will be restored properly. But in the perf interrupt context 
it seems a little messy to me because get_fs() can (and will) return a 
value inconsistent with %asi, so at the end of perf_callchain_user() 
when set_fs() is done, it will not truly restore %asi to what it was 
when the function began. So up until the return from trap, %asi contains 
an unintended value. I didn't track down all possibilities to see if 
anything bad might happen, but it just seemed wrong to leave things in 
that state.

Also, in the code we submitted, there was an optimization in which %asi 
is read, and then only set to ASI_AIUS if necessary. This drastically 
reduces the number of writes to the %asi register since most of the time 
%asi will contain ASI_AIUS. This seems like a reasonable optimization, 
since this function may be called thousands of times per second on every 
cpu. But this doesn't work at all using get_fs() since it is 
inconsistent with %asi, and that is why we went with the inline 
assembler to read and write %asi directly.

Merry Christmas.

Rob

