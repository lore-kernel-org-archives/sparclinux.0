From: David Miller <davem@davemloft.net>
Date: Fri, 18 Dec 2015 19:04:00 +0000
Subject: Re: [PATCH] sparc: Add all necessary direct socket system calls.
Message-Id: <20151218.140400.966657553119768017.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151217.224753.1441573007785005706.davem@davemloft.net>
In-Reply-To: <20151217.224753.1441573007785005706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 18 Dec 2015 13:10:32 +0000

> On Fri, 18 Dec 2015, David Miller wrote:
> 
>>  #define __NR_membarrier		351
>> +#deifne __NR_bind		352
>> +#deifne __NR_listen		353
>> +#deifne __NR_setsockopt		354
> 
> "#deifne" can't be correct....

Right, thanks :-)

This was just and RFC, I was going to compile/boot/test the
patches after getting feedback.

What I'm most concerned about is making sure I hit all of the
necessary missing syscalls.
