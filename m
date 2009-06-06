From: David Miller <davem@davemloft.net>
Date: Sat, 06 Jun 2009 00:41:12 +0000
Subject: Re: SILO & Ext4
Message-Id: <20090605.174112.10513943.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
In-Reply-To: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 05 Jun 2009 08:12:13 -0400

> David Miller wrote:
>> You'll have to learn how to load kernel TLB entries for about 4 or 5
>> different major TLB/cache types on sun4c, sun4m, and sun4d systems.
>
> Couldn't you do this using OBP in a HW independent way?

Not really.

Only sparc64's OBP adds facilities to load locked TLB entries via the
firmware.

>> This is what you need to do to relocate the kernel into a new location
>> then jump to it.
>
> On sparc32, is the kernel always loaded in the lower 3 MB
> of physical memory regardless of the amount of physical
> memory and just left there?

I don't know, you'd have to see what SILO does.

As for direct loads such as tftpboot via the firmware, it loads
the A.OUT kernel image at 0x4000 and simply jumps there.
