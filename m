From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 09 Oct 2009 07:03:57 +0000
Subject: Re: [RFC PATCH 10/12] of: merge of_*_flat_dt*() functions
Message-Id: <fa686aa40910090003i4564385cv90ee672fa4471fb5@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043154.16890.18883.stgit@angua>
	<20091009063635.GD12948@yookeroo.seuss>
In-Reply-To: <20091009063635.GD12948-787xzQ0H9iRg7VrjXcPTGA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Fri, Oct 9, 2009 at 12:36 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Oct 06, 2009 at 10:32:02PM -0600, Grant Likely wrote:
>> Merge common flattened device tree code between Microblaze and PowerPC
>
> And I guess another question is do we want to replace these with a
> libfdt based implementation.

Perhaps.  Let me get things unified and sane first though.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
