From: David Miller <davem@davemloft.net>
Date: Wed, 13 Apr 2016 22:37:14 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.183714.893525315444723985.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 00:35:58 +0200

> On 04/14/2016 12:23 AM, David Miller wrote:
>> The missing bit is probably having the individual sparc64 VIO drivers
>> define proper module aliases.
> 
> I'm actually currently working on a patch. The aliases are already
> working, now it's just the actual hotplug handler which is missing.

Are you sure?  See my other email, VIO devices don't come from the
Openfirmware device tree at all.
