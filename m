From: Phillip Stevens <phillip.stevens@gmail.com>
Date: Sun, 08 Apr 2018 09:52:24 +0000
Subject: Ultra5 successful install - PGX64 issues
Message-Id: <CAFC0-0VUwpaVEWEVeTBWQirHSOsceXs0vXh_njn-7q8o7QqO+A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With reference to my post on the debian-sparc list,
the advice was to request help here.

I used the April 4 ISO to successfully migrate my Ultra5 to Sparc64.
It should show up in popcon.

However, there remains issues in getting an X desktop running.
I'm looking for any hints on getting a PGX64 ATI card running on this
platform, please.

I think the mach64 module is the right way to proceed, but there are
references to the same error I'm facing, going back over 10 years.

Notes.

The radeon driver causes an error unless modeset is disabled, by this
configuration.
In: /etc/modprobe.d/local.conf
options libata dma=0
options radeon modeset=0

The xserver-xorg-video-mach64 package is not installed by default, yet
it seems to be required for the ATI video hardware.

Another module that is not available in sparc64 is the
xserver-xorg-video-sunffb package.
https://packages.debian.org/wheezy/sparc/xserver-xorg-video-sunffb/download
It was last available for wheezy.

There are several references to the failure of mach64 module to map
mmio aperture arising from the implementation of security mode in the
kernel.
In: /var/log/Xorg.0.log
[    84.251] (II) MACH64(0): Creating default Display subsection in
Screen section "Default Screen Section" for depth/fbbpp 24/32
[    84.251] (=) MACH64(0): Depth 24, (--) framebuffer bpp 32
[    84.252] (=) MACH64(0): Using XAA acceleration architecture
[    84.252] (EE) Unable to map mmio aperture. Invalid argument (22)
[    84.252] (WW) MACH64: Mach64 in slot 2:1:0 could not be detected!
[    84.252] (II) UnloadModule: "mach64"
[    84.253] (EE) Screen(s) found, but none have a usable configuration.

Regards, Phillip
