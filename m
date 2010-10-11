From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Oct 2010 04:11:02 +0000
Subject: Re: [PATCH 4/5] of: add package-to-path support to pdt
Message-Id: <20101011041102.GE23588@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20101010020609.3adde588@debxo>
In-Reply-To: <20101010020609.3adde588@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Oct 10, 2010 at 02:06:09AM -0700, Andres Salomon wrote:
> 
> package-to-path is a PROM function which tells us the real (full) name of the
> node.  This provides a hook for that in the prom ops struct, and makes use
> of it in the pdt code when attempting to determine a node's name.  If the
> hook is available, try using it (falling back to looking at the "name"
> property if it fails).
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Applied, thanks.

g.

