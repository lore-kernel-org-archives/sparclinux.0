From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 20 Feb 2007 23:49:34 +0000
Subject: Re: SILO limits and requirements
Message-Id: <Pine.LNX.4.61.0702210046180.7132@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <200702202337.l1KNb42F020734@sunsmoke.org>
In-Reply-To: <200702202337.l1KNb42F020734@sunsmoke.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Feb 20 2007 18:37, Rev. G. Lim wrote:
>
>Here goes:
>1. Is it correct to say that SILO can only read kernels from ext2/3,
>with UFS planned for the somewhat near future? IOW, it cannot boot a
>kernel located on ReiserFS or XFS or JFS.

Yes, but all dynamic bootloaders that walk filesystems have that problem. You
cannot boot from HFS with GRUB at this time. Or ADFS. (Not that they would be
important, but the idea is - you need a fsdriver).

On the other hand, static bootloaders like LILO work straight away since they
read raw blocks. Then again, this does not work with encrypted filesystems or
with filesystems that relayout files (reiser4 perhaps).


Jan
-- 
ft: http://freshmeat.net/p/chaostables/
