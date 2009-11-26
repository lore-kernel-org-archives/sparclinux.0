From: Mitch Bradley <wmb@firmworks.com>
Date: Thu, 26 Nov 2009 07:52:35 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <4B0E33C3.1020803@firmworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081827.6216.1896.stgit@angua>	<1259207974.16367.226.camel@pasglop>	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>	<20091125.232818.-1350498258.imp@bsdimp.com>
	<1259219171.16367.331.camel@pasglop>
In-Reply-To: <1259219171.16367.331.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

>
> Right, that's the only sane way to do it, I just didn't remember off
> hand what was said in the OF spec  :-) 


3.2.2.1.2 Property values

The property-encoding format is independent of hardware byte order and 
alignment characteristics.  The encoded byte order is well-defined (in 
particular, it is big endian). ...

...

-- 32-bit integer.  A 32-bit integer is encoded into a property value 
byte array by storing the most significant byte at the next available 
address, followed (at address+1) by the high middle byte, the low middle 
byte, and (at address+3) the least significant byte.

