From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 19 Apr 2018 14:10:54 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <c4e35c5e-e4d2-2222-83ca-7e044ead4004@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 04/19/2018 07:47 AM, Ren=C3=A9 Rebe wrote:
> Any chance this is non-sun4v related? This is an Ultra30 sun4u, ...

Don't think so:

root@ravirin:~# dmesg |grep -i bug
[    3.616698] tg3 0000:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
[    3.968679] tg3 0003:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
root@ravirin:~# grep CONFIG_TRANSPARENT_HUGEPAGE /boot/config-$(uname -r)
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
root@ravirin:~# cat /proc/cpuinfo
cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
pmu             : ultra3i
prom            : OBP 4.22.33 2007/06/18 12:45
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         : flush,stbar,swap,muldiv,v9,ultra3,mul32,div32,v8plus,vis,=
vis2
Cpu0ClkTck      : 000000005995f5c0
MMU Type        : Cheetah+
MMU PGSZs       : 8K,64K,512K,4MB
State:
CPU0:           online
root@ravirin:~#

--=20
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
