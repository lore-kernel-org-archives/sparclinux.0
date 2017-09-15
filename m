From: David Miller <davem@davemloft.net>
Date: Fri, 15 Sep 2017 00:01:04 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <20170914.170104.396099862689891630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 14 Sep 2017 17:51:31 -0600

> David, thanks for the feedback. Here is what we're going to do:
>  1) Verify commands going to the hypervisor by examining the opcode in
>  each ccb. Addresses are already being examined to make sure they are
>  virtual only, which ensures respect for all process specific memory
>  mappings, a process can only access its own memory via the
>  coprocessor, never that of another process.
>  2) Expanded documentation on the ccb contents, and hopefully a link to
>  documentation on the hypervisor api.
>  3) Example user space code that demonstrates the raw driver api to
>  submit a coprocessor ccb
>  4) Example kernel code that demonstrates how to submit commands to the
>  coprocessor. If some crypto driver wants to do decompression using the
>  coprocessor, it will be able to do so by constructing a suitable
>  command and submitting it. There will be enough documentation to allow
>  this, but we are not providing such higher level services for use in
>  the kernel.
> 
> Do you have any other comments or feedback on the code or anything
> else?

That sounds like a good start and I look forward to reviewing your next
version.
