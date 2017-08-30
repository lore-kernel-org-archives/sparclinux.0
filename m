From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2017 02:33:51 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <20170829.193351.1396428868403563034.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 29 Aug 2017 19:47:23 -0600

> On 08/29/2017 07:07 PM, David Miller wrote:
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Tue, 29 Aug 2017 17:36:01 -0600
>>
>>> Any and all feedback welcome and appreciated.
>> So basically binary blobs will be passed into this driver, and there
>> will be no verification or documentation of the various DAX
>> operations, their parameters, what operation they perform, how they
>> work, and their how their references to the user's buffers operate?
>>
>> Right?
>>
> 
> No, that is not at all how it works. Full documentation of the command
> interface will be provided in the library. The driver is just a
> transport to connect user space with the hypervisor calls.

Again, my point is that what the kernel processes is basically
semanticless.

The kernel doesn't validate the DAX commands, it doesn't validate
the parameters given to the commands, etc.

It's a block box, accepting binary blobs, and passing them on
as-is to the hypervisor.

That's what I don't like about this interface.
