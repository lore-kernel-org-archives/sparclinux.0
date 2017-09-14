From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 14 Sep 2017 23:51:31 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <ead6f0ee-2209-e7f3-547f-79cbebbcd7ec@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/11/2017 10:42 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Mon, 11 Sep 2017 22:27:59 -0600
>
>> On 09/11/2017 10:17 PM, David Miller wrote:
>>> From: Rob Gardner <rob.gardner@oracle.com>
>>> Date: Mon, 11 Sep 2017 17:28:19 -0600
>>>
>>>> The stubs/templates/constants reflect the hypervisor APIs, so there is
>>>> not very much flexibility in how these are done.
>>> There is no reason to add hypervisor calls to the kernel until there
>>> is
>>> also a user.
>>>
>>> We always have a requirement to sequence a new interface in the kernel
>>> with and actual user of that interface.
>>>
>> OK, point taken. Any guidance on the driver, or shall we just send the
>> two patches?
> You have to document the commands that go to the hypervisor in some
> way, maybe even have a command stream verifier on the kernel side
> before it gets passed to the hypervisor.
>
> I want it documented sufficiently such that any individual could
> write a userland component to use these facilities.
>
> This DAX infrastructure can also do things like decompression, so
> you should also design things such that a crypto layer driver or
> similar can be written to submit such DAX commands.
>

David, thanks for the feedback. Here is what we're going to do:
  1) Verify commands going to the hypervisor by examining the opcode in 
each ccb. Addresses are already being examined to make sure they are 
virtual only, which ensures respect for all process specific memory 
mappings,  a process can only access its own memory via the coprocessor, 
never that of another process.
  2) Expanded documentation on the ccb contents, and hopefully a link to 
documentation on the hypervisor api.
  3) Example user space code that demonstrates the raw driver api to 
submit a coprocessor ccb
  4) Example kernel code that demonstrates how to submit commands to the 
coprocessor. If some crypto driver wants to do decompression using the 
coprocessor, it will be able to do so by constructing a suitable command 
and submitting it. There will be enough documentation to allow this, but 
we are not providing such higher level services for use in the kernel.

Do you have any other comments or feedback on the code or anything else?

Rob

