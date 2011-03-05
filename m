From: crn@netunix.com
Date: Sat, 05 Mar 2011 13:32:51 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <alpine.LNX.2.00.1103051321530.6200@web1.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sat, 5 Mar 2011, Kjetil Oftedal wrote:
>
> Hi,
>
> With regards to testing on sun4d, I have run into problems with the
> existing kernel, during the process of getting a test system up and
> running. The system is unable to mount partitions correctly,
> (both ext2 on a hdd, and iso8859 on a cdrom), however dd, running from an
> initrd filesystem is able to read the ext2 blocks correctly. So I have
> started investigating this instead.
>
> Is there anyone aware of any alignment requirements in the sun4d on DMA
> transfers and such ? Or have the datasheet for the FAS2x6 (236) scsi
> controllers ?

First check that you can see the drive correctly from the OBP
ok> probe-scsi-all

If that is OK try booting with no SMP, I forget the correct incantation
but something like "max-cpus=1" sounds familiar.

You could also try booting with a 2.2.x kernel, if that does not work
something is SERIOUSLY wrong. 2.2.x does not support SMP and has
always booted OK for me.

Do you have Solaris, it should boot and run 2.6, 7, or 8 (last supported).
If this fails you certainly have hardware issues.

Sorry to be vague, there has been no properly working Sun4d kernel
since 2.2.x so expect to find bitrot in all sorts of obscure places.

