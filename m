From: Mustafa Hussein <mmhussein@comcast.net>
Date: Thu, 29 Jan 2004 20:13:21 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <200401291413.21650.mmhussein@comcast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Ben,
I tried to boot a ~4.1MB  2.6.2-rc2  image using second.b version 1.4.2 that I 
compiled overnight. Here is what I got:

SILO version 1.4.2
boot: linux2.6.2-rc2
Allocated 8 megs of memory at 0x40000000 for kernel
Uncompressing image ...
Loaded kernel version 2.6.2 ...
Remapping the kernel ... done

And it doesn't go any further,  I had to cold-boot (keyboard unreponsive).
I also have to mention that after unpacking second.b from the silo-loaders 
package into /boot and issueing "silo -f" as per your earlier message; I got 
a Fast Data Access Miss error, and had to boot off the Debian install cd and 
chroot then issue "silo -f" again to fix the problem.
I kept second.b 1.4.2 and it boots the existing image just fine (a 3.4 MB 
kernel 2.6.2-rc1 image)
Ultra10/333MHz/384MB/Elite3D-m3/OBP3.31

Thanks,

Mustafa

On Thursday 29 January 2004 12:29 pm, Ben Collins wrote:
> I've tested and fixed initrd support for sparc64, so that's safe.
>
> I've also cleaned up some things. Upon further testing, I was able to
> boot a 6.8Meg image. Not sure why it didn't work the first time, but
> beware it may be flakey.
>
> I'm a little disappointed. I haven't gotten any feedback from people
> testing this new version. So either no one cares, or it works good and
> people don't want to waste their time sending "worked for me" emails :)
>
> Usual place: http://www.sparc-boot.org/pub/silo/

