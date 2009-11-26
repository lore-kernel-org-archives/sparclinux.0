From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 07:06:11 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <1259219171.16367.331.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
	<20091125.232818.-1350498258.imp@bsdimp.com>
In-Reply-To: <20091125.232818.-1350498258.imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wed, 2009-11-25 at 23:28 -0700, M. Warner Losh wrote:
> In message:
> <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
>             Grant Likely <grant.likely@secretlab.ca> writes:
> : Word from Mitch is the device tree is network byte order.  period.
> 
> OpenFirmware defines the order to be big endian always, even on little
> endian processors.

Right, that's the only sane way to do it, I just didn't remember off
hand what was said in the OF spec :-)

Cheers,
Ben.


