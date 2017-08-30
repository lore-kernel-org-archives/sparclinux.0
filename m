From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 30 Aug 2017 03:28:43 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <40f4c3f0-1417-e36e-eb42-eee5e927ee7d@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 08/29/2017 08:33 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Tue, 29 Aug 2017 19:47:23 -0600
>
>> On 08/29/2017 07:07 PM, David Miller wrote:
>>> From: Rob Gardner <rob.gardner@oracle.com>
>>> Date: Tue, 29 Aug 2017 17:36:01 -0600
>>>
>>>> Any and all feedback welcome and appreciated.
>>> So basically binary blobs will be passed into this driver, and there
>>> will be no verification or documentation of the various DAX
>>> operations, their parameters, what operation they perform, how they
>>> work, and their how their references to the user's buffers operate?
>>>
>>> Right?
>>>
>> No, that is not at all how it works. Full documentation of the command
>> interface will be provided in the library. The driver is just a
>> transport to connect user space with the hypervisor calls.
> Again, my point is that what the kernel processes is basically
> semanticless.
>
> The kernel doesn't validate the DAX commands, it doesn't validate
> the parameters given to the commands, etc.
>
> It's a block box, accepting binary blobs, and passing them on
> as-is to the hypervisor.

Not quite as-is, since the driver does check address types to make sure 
the user is not passing in a real address. But yes, apart from that, it 
is a pass through driver, much like a scsi pass through driver; a user 
app can construct a command block and use the driver to get it to the 
hardware. A scsi pass through driver does not validate that the scsi ccb 
has valid commands, parameters, etc, but allows the hardware to do that 
and decide to accept it or reject it. As long as we are sure that the 
user cannot accomplish anything malicious, we don't need to duplicate 
validation that the hardware already does for us.

Perhaps it would seem less like a black box with further explanation of 
the operations, or perhaps some example programs that use the driver 
interface. Would that help? The library that goes along with this driver 
has extensive documentation and it will be open source very soon, but we 
can certainly provide further detail before that happens.

Thank you for your feedback. I am already revising the documentation to 
better explain the interface, and eager to hear more of your thinking on 
this.

Rob

