From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 09 May 2005 15:18:45 +0000
Subject: atyfb not working correctly (black on black) on SB100
Message-Id: <1115651925.3017.64.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While doing some Aurora installer testing, I noticed that 2.6.11-rc3
isn't initializing the framebuffer properly on my Sun Blade 100. Its
giving me the "black on black" text, that I've seen on several other
SPARC framebuffers (e.g. the p9100 fix I just emailed to the list). The
SB100 is different, in that it doesn't use a SBUS framebuffer, it uses a
onboard PCI ATI RAGE 64 XL.

My kernel config has the following (relevant) options:

# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_XL_INIT=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_PCI=y

If I boot the kernel with -p, I see the kernel booting properly, and the
framebuffer initializing, but as soon as it initializes, black on black
text, which isn't viewable.

I'm hoping this will be obvious to someone else out there, or that
someone else might be willing to test the same set of config options and
confirm that it doesn't work.

Thanks,

~spot
-- 
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

