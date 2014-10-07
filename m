From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2014 19:23:04 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <20141007.152304.1507808371280437028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 14:19:19 -0500

> On 10/07/2014 02:03 PM, David Miller wrote:
>> From: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Date: Tue, 07 Oct 2014 13:49:37 -0500
>> 
>>> I never realized that, but that's really not a problem since the
>>> destination will have the space. The original patch shouldn't be
>>> problematic, although it may make the string longer than it practically
>>> needs to be. I'll let davem make the call which version he likes better.
>>> Maybe the comment in the second patch can be improved.
>> 
>> If you make the boot string 2048 bytes, and the firmware provides
>> a string longer than 1024 bytes to SILO, it will read past the end
>> of barg_buf.
> 
> Isn't it already too late by the time SILO looks at the length in
> kernel_params? silo_set_bootargs() has already been called, so if
> barg_buf is too small, SILO has already written past the end of it
> (unless I'm missing some other bounds checking).

The more I look at it, we have a built in limitation of 512 bytes
actually.

Actually, for sparc64 OF (ie. P1275) it is careful to only bring
in 1024 bytes to barg_buf:

    	if (!full)
    	    q = barg_buf;
    	else {
    	    iter = prom_getproperty (prom_chosen, "bootpath", barg_buf, 510);
    	    if (iter != -1)
    	        if (iter && !barg_buf [iter - 1])
    	            q = barg_buf + iter - 1;
    	        else
    	            q = barg_buf + iter;
    	    else
    	        q = barg_buf;
    	}
    	iter = prom_getproperty (prom_chosen, "bootargs", full ? q + 1 : q, 512);

>> So I think we still need to limit it to 1024.
> 
> I hope we never have a need for anything longer.

Me too, let's just use 1024.
