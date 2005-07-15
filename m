From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 15 Jul 2005 04:21:31 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <Pine.LNX.4.61.0507150017250.7406@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 8 Jul 2005, Jurij Smakov wrote:

> On Mon, 6 Jun 2005, William Lee Irwin III wrote:
>
>> I got a bit heavy-handed as suggested and just blew away the whole lot
>> of macro wrappers etc. I did leave around some of the asm called from
>> there but am plotting to nuke them as well after making sure we aren't
>> trying to BTFIXUP code that doesn't exist.
>
> Sorry to say that, but it does not help. On the positive side, I have finally 
> managed to boot 2.6.12.2 on my Hypersparc, by eliminating the initrd support 
> and compiling SCSI drivers into the kernel.

Even though eliminating initrd made kernel to boot, under heavy I/O and 
memory use it randomly corrupts the filesystem, so we are back to square 
one.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
