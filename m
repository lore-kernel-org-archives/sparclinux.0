From: David Miller <davem@davemloft.net>
Date: Tue, 12 Sep 2017 04:42:57 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <20170911.214257.1684300806986547583.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 11 Sep 2017 22:27:59 -0600

> On 09/11/2017 10:17 PM, David Miller wrote:
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Mon, 11 Sep 2017 17:28:19 -0600
>>
>>> The stubs/templates/constants reflect the hypervisor APIs, so there is
>>> not very much flexibility in how these are done.
>> There is no reason to add hypervisor calls to the kernel until there
>> is
>> also a user.
>>
>> We always have a requirement to sequence a new interface in the kernel
>> with and actual user of that interface.
>>
> 
> OK, point taken. Any guidance on the driver, or shall we just send the
> two patches?

You have to document the commands that go to the hypervisor in some
way, maybe even have a command stream verifier on the kernel side
before it gets passed to the hypervisor.

I want it documented sufficiently such that any individual could
write a userland component to use these facilities.

This DAX infrastructure can also do things like decompression, so
you should also design things such that a crypto layer driver or
similar can be written to submit such DAX commands.

Thanks.
