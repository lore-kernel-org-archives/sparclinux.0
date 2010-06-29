From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Date: Tue, 29 Jun 2010 15:56:09 +0000
Subject: RE: Using devices trees on X86
Message-Id: <865b299f-8552-46bb-9524-e21af847e5b8@SG2EHSMHS003.ehs.local>
List-Id: <sparclinux.vger.kernel.org>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
In-Reply-To: <20100629123843.5f94d477.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>



> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Monday, June 28, 2010 7:39 PM
> To: Stephen Neuendorffer
> Cc: grant.likely@secretlab.ca; devicetree-discuss@lists.ozlabs.org;
David Miller;
> sparclinux@vger.kernel.org; Michal Simek;
microblaze-uclinux@itee.uq.edu.au; Benjamin Herrenschmidt;
> Paul Mackerras; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Using devices trees on X86
> 
> Hi Stephen,
> 
> On Mon, 28 Jun 2010 10:57:33 -0700 Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> >
> > 2) config OF is currently implemented in the architecture code.
This
> > should be non-architecture dependent and selected by the arches that
> > need it.
> >
> > Comments greatly appreciated, in particular if you have
> > likely-to-be-easy-to-get-accepted suggestions for 3), or feel like
> > carefully solving 2) in
> > a way which doesn't bork the existing of-based arches.
> 
> See the following patch set.  Parts 1, 2 and 3 could be applied to the
> respective architecture trees as well as Grant's tree to aleviate some
> conflict problems.  Part 5 could wait until a later time if necessary.
> However, this is relatively trivial, so we could just collect ACKs and
> put it all in Grant's tree and live with any minor pain.
> 
> Having OF in more than one Kconfig file should not cause any problems
as
> long as they are all the same.

Ah, well, that simplifies things.. :) Thanks!

Steve

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


