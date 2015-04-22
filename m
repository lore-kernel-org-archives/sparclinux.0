From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 23:22:46 +0000
Subject: Re: sparc: deadlock using perf with sched tracepoints and user callstacks
Message-Id: <20150422.192246.1672746282210523659.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <551AFA5A.1000908@oracle.com>
In-Reply-To: <551AFA5A.1000908@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Tue, 31 Mar 2015 17:52:53 -0600

> On 3/31/15 5:38 PM, David Miller wrote:
>> What is different in the PowerPC fault path vs. the Sparc one that
>> causes the SIGBUS for sparc where the PowerPC does not see it?
>>
>> I don't understand where the SIGBUS comes from.  In a pagefault
>> disable section on sparc, in_atomic() should be true, thus we'll call
>> do_kernel_fault(), fall through to the TSTATE_PRIV code path and
>> simply run the exception handler.
>>
> 
> That's what I was hoping someone could explain to me. I'll dig deeper
> on Monday.

I've looked a few times at this and can't figure out what might be
going wrong just from visual inspection.  I'll try reproducing the
problem and adding some diagnostics.
