From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jan 2012 04:38:02 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120117.233802.713527365285913103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 18 Jan 2012 08:51:01 +1100

> On Wed, Jan 18, 2012 at 05:51, David Miller <davem@davemloft.net> wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Tue, 17 Jan 2012 12:56:56 -0500 (EST)
>>
>>> I'm looking into the rest.
>>
>> So just adding the stubs (or your idea, linking with libc) doesn't
>> work at all.
>>
>> All the new features in libext2 that get linked in cause the second
>> stage bootloader image to grow too large.
>>
>> I'll just have to extract the parts of libext2 that we actually need
>> into a stripped down local copy in SILO and I guess this will make
>> us immune to this issue showing up again in the future.
> 
> Would it make sense to get Grub working on Sparc so we can abandon
> SILO and reduce our maintenance burden to just the Sparc-specific
> parts of Grub?

The sparc64 port is already in there and mostly works but it needs
tons of bug fixing and testing.

However the GRUB maintainer is a prick and there is a lot of
infighting in the project so I stopped doing GRUB work a very long
time ago.

For the time being it's quicker to do add a quick piece of ext2 r/o
support code to SILO, and that's what I'm already working on.
