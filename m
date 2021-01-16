From: Rob Landley <rob@landley.net>
Date: Sat, 16 Jan 2021 06:54:22 +0000
Subject: Re: Old platforms never die, was Re: Old platforms: bring out your dead
Message-Id: <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------14B6DC6FBF1B2EFA5CB0B019"
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
To: Finn Thain <fthain@telegraphics.com.au>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

This is a multi-part message in MIME format.
--------------14B6DC6FBF1B2EFA5CB0B019
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/12/21 6:12 PM, Finn Thain wrote:
> If you're a museum interested in cultural artifacts from decades past, or 
> if you're a business doing data recovery, you're going to need to operate 
> those platforms.

Or if you're camping patent expirations and want to be able to point at prior
art for new hardware development WITHOUT a legal team big enough to have its own
office building.

> Once removed from mainline Linux, a port becomes basically frozen, and may 
> not be compatible with future emulators, which are a moving target. I say 
> that because last year I fixed bugs in Linux/m68k that made it incomatible 
> with recent QEMU releases (it was only compatible with old QEMU releases).

Speaking of which, my qemu m68k system has failed to boot ever since commit:

commit f93bfeb55255bddaa16597e187a99ae6131b964a
Author: Finn Thain <fthain@telegraphics.com.au>
Date:   Sun Jun 28 14:23:12 2020 +1000

    macintosh/via-macii: Poll the device most likely to respond

    Poll the most recently polled device by default, rather than the lowest
    device address that happens to be enabled in autopoll_devs. This improves
    input latency. Re-use macii_queue_poll() rather than duplicate that logic.
    This eliminates a static struct and function.

It hangs in a cpu-eating loop after "random: crng init done". Miniconfig
attached, the qemu invocation is:

qemu-system-m68k -M q800 -nographic -no-reboot -m 256 -kernel vmlinux \
  -initrd cpio.gz -append "panic=1 HOST=m68k console=ttyS0

Rob

P.S. This is the toybox "make root" m68k target from
https://github.com/landley/toybox/blob/master/scripts/mkroot.sh#L171 if that's
useful to know. It doesn't get to the root filesystem and the build just creates
that miniconfig and runs it as the comments say...

--------------14B6DC6FBF1B2EFA5CB0B019
Content-Type: text/plain; charset=UTF-8;
 name="miniconfig-m68k"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="miniconfig-m68k"

IyBtYWtlIEFSQ0g9bTY4ayBhbGxub2NvbmZpZyBLQ09ORklHX0FMTENPTkZJRz1tNjhrLm1p
bmljb25mCiMgbWFrZSBBUkNIPW02OGsgLWogJChucHJvYykKIyBib290IHZtbGludXgKCgoj
IENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CiMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50
CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpDT05GSUdfTk9f
SFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKQ09ORklHX0JMS19ERVY9eQpDT05GSUdf
QkxLX0RFVl9JTklUUkQ9eQpDT05GSUdfUkRfR1pJUD15CkNPTkZJR19CTEtfREVWX0xPT1A9
eQpDT05GSUdfRVhUNF9GUz15CkNPTkZJR19FWFQ0X1VTRV9GT1JfRVhUMj15CkNPTkZJR19W
RkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX1VURjg9eQpDT05GSUdfTUlTQ19GSUxFU1lT
VEVNUz15CkNPTkZJR19TUVVBU0hGUz15CkNPTkZJR19TUVVBU0hGU19YQVRUUj15CkNPTkZJ
R19TUVVBU0hGU19aTElCPXkKQ09ORklHX0RFVlRNUEZTPXkKQ09ORklHX0RFVlRNUEZTX01P
VU5UPXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX1RNUEZTX1BPU0lYX0FDTD15CkNPTkZJR19O
RVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNPTkZJ
R19JUFY2PXkKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0NPUkU9eQpDT05GSUdf
TkVUQ09OU09MRT15CkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19DT01QQVRfMzJCSVRfVElN
RT15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtD
T05GSUdfUFJPQz15CgojIGFyY2hpdGVjdHVyZSBzcGVjaWZpYwpDT05GSUdfTU1VPXkKQ09O
RklHX002ODA0MD15CkNPTkZJR19NNjhLRlBVX0VNVT15CkNPTkZJR19NQUM9eQpDT05GSUdf
U0NTSV9NQUNfRVNQPXkKQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTPXkKQ09ORklHX0FEQj15
CkNPTkZJR19BREJfTUFDSUk9eQpDT05GSUdfTkVUX0NPUkU9eQpDT05GSUdfTUFDU09OSUM9
eQpDT05GSUdfU0VSSUFMX1BNQUNaSUxPRz15CkNPTkZJR19TRVJJQUxfUE1BQ1pJTE9HX1RU
WVM9eQpDT05GSUdfU0VSSUFMX1BNQUNaSUxPR19DT05TT0xFPXkKCgo=
--------------14B6DC6FBF1B2EFA5CB0B019--
