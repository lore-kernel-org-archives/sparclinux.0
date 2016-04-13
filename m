From: David Miller <davem@davemloft.net>
Date: Wed, 13 Apr 2016 22:23:49 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.182349.2105549991665775349.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 13 Apr 2016 17:33:25 +0200

> On 04/11/2016 09:04 PM, David Miller wrote:
>> Either way, I'll look at this patch, thanks.
> 
> Just as a heads-up:
> 
> The suggested patch does not work unfortunately. Modules are not
> loaded automatically and it seems modaliases are not generated
> properly.
> 
> It seems that the vio implementation for sparc which you adapted
> from powerpc uses a different name to retrieve the device nodes.

The missing bit is probably having the individual sparc64 VIO drivers
define proper module aliases.
