From: Bjoern Brandenburg <bbb@email.unc.edu>
Date: Fri, 09 May 2008 04:55:03 +0000
Subject: Re: enabling lockdep causes boot failure on a SUN T2000
Message-Id: <AE9CC7F1-9796-498C-8099-9CAE6B61DAAB@email.unc.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <48238125.7040900@email.unc.edu>
In-Reply-To: <48238125.7040900@email.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On May 9, 2008, at 12:21 AM, David Miller wrote:
>> I figured that if the flushes are the root cause, then this should  
>> take
>> care of the problem. However, the kernel still doesn't boot.
>
> That patch you posted is dangerous.  If the stack isn't flushed,
> there will be garabage in the frame pointer slots of the stack
> frame, and likely that will cause an OOPS.
>

That was not indented as a proper patch, that was just a quick hack  
attempt to help me solve my problems.

But I'm curious. How is it dangerous not to call save_stack-trace()?  
No frame pointers will be accessed since no stack trace is recorded.  
If nothing is recorded, how can they be accessed later? trace- 
 >nr_entries just remains 0, and print_stack_trace() properly handles  
stack traces of length 0. I assume the rest of lockdep is robust  
enough to handle such a corner case, too.

(I'm looking at the 2.6.24 source, since that is what I'm working with  
atm.)

> Please, let me try to resolve this as I find time to do so.

Sure, I just need to get my stuff to work. I'd appreciate any hints on  
how to get lockdep semi-working/limping, if there is an easy way to do  
so.

Anyway, thanks for your feedback.

- Bjoern

