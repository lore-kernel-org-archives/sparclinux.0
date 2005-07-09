From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 09 Jul 2005 02:22:50 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <Pine.LNX.4.61.0507082212580.3006@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 6 Jun 2005, William Lee Irwin III wrote:

> I got a bit heavy-handed as suggested and just blew away the whole lot
> of macro wrappers etc. I did leave around some of the asm called from
> there but am plotting to nuke them as well after making sure we aren't
> trying to BTFIXUP code that doesn't exist.

Sorry to say that, but it does not help. On the positive side, I have 
finally managed to boot 2.6.12.2 on my Hypersparc, by eliminating the 
initrd support and compiling SCSI drivers into the kernel. The weird thing 
is that it is enough to replace the call to __copy_1page in 
__constant_memcpy (include/asm-sparc/string.h) by the call to __memcpy to 
break the initrd boot. Initrd is then mounted, but attempts to run any 
script (including linuxrc and init) are immediately killed by SIGSEGV, so 
kernel panics unable to mount the root from the hdd. This is a complete 
mystery to me because judging by the code __memcpy is supposed to be a 
more generic routine. Please let me know if you have any ideas.

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

