From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 09 Oct 2009 06:36:35 +0000
Subject: Re: [RFC PATCH 10/12] of: merge of_*_flat_dt*() functions
Message-Id: <20091009063635.GD12948@yookeroo.seuss>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043154.16890.18883.stgit@angua>
In-Reply-To: <20091007043154.16890.18883.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, Oct 06, 2009 at 10:32:02PM -0600, Grant Likely wrote:
> Merge common flattened device tree code between Microblaze and PowerPC

And I guess another question is do we want to replace these with a
libfdt based implementation.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
