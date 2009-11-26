From: "M. Warner Losh" <imp@bsdimp.com>
Date: Thu, 26 Nov 2009 06:28:18 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <20091125.232818.-1350498258.imp@bsdimp.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
In-Reply-To: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

In message: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
            Grant Likely <grant.likely@secretlab.ca> writes:
: Word from Mitch is the device tree is network byte order.  period.

OpenFirmware defines the order to be big endian always, even on little
endian processors.

Warner
