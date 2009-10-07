From: Rob Landley <rob@landley.net>
Date: Wed, 07 Oct 2009 07:09:58 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <200910070209.59311.rob@landley.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua> <fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
In-Reply-To: <fa686aa40910062149p5d7141e4x3ff849fd4d191f38-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org

On Tuesday 06 October 2009 23:49:04 Grant Likely wrote:
>
> However, I've completely devoted to this work for at least the next
> two months, so there are plenty more patches to follow.  Once I've
> got all the common code merged between Microblaze, PowerPC and Sparc
> I'll be fix the endian problems and making it easily usable by other
> architectures like ARM and MIPS.  Lots of work to be done.

Is there any news on getting QEMU to parse a device tree to figure out what 
hardware to emulate?  (I.E. using the device tree code to let qemu provide 
configurable board emulations instead of hardwiring them in C code?)

Also, what would be involved in getting x86 to (at least have the option to) 
use the device tree stuff?

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
