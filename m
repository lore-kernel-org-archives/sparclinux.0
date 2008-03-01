From: Jarod Wilson <jwilson@redhat.com>
Date: Sat, 01 Mar 2008 05:23:24 +0000
Subject: Re: [PATCH 0/2] firewire: endinaness warnings (was Re: sparse - make __CHECK_ENDIAN__ default enable
Message-Id: <200803010023.25086.jwilson@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
In-Reply-To: <tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On Saturday 23 February 2008 06:23:30 am Stefan Richter wrote:
> On 20 Feb, Harvey Harrison wrote on LKML:
> > On Wed, 2008-02-20 at 23:03 +0100, Sam Ravnborg wrote:
> >> Hi Harvey.
> >>
> >> Can I ask you to look into the worst offenders so we
> >> can make -D__CHECK_ENDIAN__ enabled per default
> >> in the kernel.
> >> Or maybe we should do it anyway?
> >
> > Well, I've got the worst of fs and drivers/ata done so far, still
> > weeping over the 5500 warnings in drivers. (X86_32 allyesconfig).
> > People ignore the existing warnings anyway, why not toss a few more
> > on the pile?
> >
> > I'll look them over tonight and see how bad it would be.
>
> I looked into drivers/firewire and drivers/ieee1394.  As expected, there
> are quite a lot endianess related warnings in the latter because this is
> code from way before sparse was regularly used.
>
> There are also a few warnings in the former, even though sparse checks
> were run before submission of the whole drivers/firewire stack.  I will
> follow up with two patches:
> 	1/2 firewire: endianess fix
> 	2/2 firewire: endianess annotations
> Whether the "fix" is really a fix remains to be seen; I don't have a big
> endian Linux box myself.

Doesn't hurt anything on my end, spb2 devices work, they survive bus resets 
and so on. The funky uninorth controller definitely doesn't work, but it 
didn't before the patch either, and the fix is being chased in another patch 
series.

Signed-off-by: Jarod Wilson <jwilson@redhat.com>


-- 
Jarod Wilson
jwilson@redhat.com
