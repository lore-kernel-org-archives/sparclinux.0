From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Sun, 03 Oct 2004 17:02:31 +0000
Subject: Sun4m hardware docs?
Message-Id: <BAY12-F12rhYQYx3G5a000003fb@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I'm trying to get Qemu's Sparc system emulation working, Sun4m is the targe=
t=20
architecture. Proll is used as prom replacement.   Lance, iommu, nvram and =

TCX  basic functions are implemented. The current status is that Proll=20
initialises, Linux gets loaded and it can reach=20
srmmu_early_allocate_ptable_skeleton before dying mysteriously.

Are there any docs for sun4m hardware (interrupt controllers, timers, etc) =

and  principles of operation (interrupt handling, dvma, boot state, bus=20
management)? I don't plan to implement anything that is not used by Linux.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE* =20
http://join.msn.com/?page=FEatures/junkmail

