From: David Miller <davem@davemloft.net>
Date: Fri, 25 Nov 2016 16:43:27 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161125.114327.1735173226597055762.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 25 Nov 2016 00:05:15 +0200

> Hi,
> 
> On Thu, Nov 24, 2016 at 10:51:14PM +0100, John Paul Adrian Glaubitz wrote:
>> On 11/24/2016 10:23 PM, Aaro Koskinen wrote:
>> > This breaks the native build on my Sun Ultra 5 with 32-bit userspace and GCC
>> > defaulting to ultrasparc:
>> 
>> Well, you can just change this part back to "elf32_sparc" and it will work. Might
>> even be possible to omit the "-m" option altogether to it will default to -m native.
> 
> I think that's your job to try. If you want to "add 64-bit support"
> (instead of forcing it to everybody), do the required changes so that
> it's still works for everybody without extra fiddling.

+1

This is exactly the kind of trouble the original patch submissions
were causing, and which were not resolved by the person submitting
the patches.

SILO must continue to build and work properly on systems which have a
predominantly 32-bit compilation environment and a gcc which defaults
to 32-bit.

I will not apply any patch which breaks this, because I too am going
to stick with a 32-bit userland on my sparc64 machines for as long as
I feasibly can.
