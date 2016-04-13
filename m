From: David Miller <davem@davemloft.net>
Date: Wed, 13 Apr 2016 22:36:30 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.183630.1756805588777157901.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 13 Apr 2016 18:23:49 -0400 (EDT)

> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Wed, 13 Apr 2016 17:33:25 +0200
> 
>> On 04/11/2016 09:04 PM, David Miller wrote:
>>> Either way, I'll look at this patch, thanks.
>> 
>> Just as a heads-up:
>> 
>> The suggested patch does not work unfortunately. Modules are not
>> loaded automatically and it seems modaliases are not generated
>> properly.
>> 
>> It seems that the vio implementation for sparc which you adapted
>> from powerpc uses a different name to retrieve the device nodes.
> 
> The missing bit is probably having the individual sparc64 VIO drivers
> define proper module aliases.

Actually there is another, more fundamental, problem.

The VIO devices on sparc64 are not instantiated from openfirmware
device nodes.

They are instead instantiated from nodes in the machine description.

Ben's patch is therefore buggy, he's looking at the of_node but that
will never be filled in for a VIO device on sparc64.

That's why I kinda cringed when it was suggested that the PowerPC and
Sparc64 VIO stuff should be merged together.  They simply can't, as
they are instantiating devices from two different sources.

Does Debian's installer have a machine description counterpart to the
opernfirmware device probing and discovery?  I bet it doesn't, and
that seems to be the first piece of infrastructure that needs to be
added before any of this can work.
