From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 20:33:22 +0000
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
Message-Id: <fa686aa40911241233k7c6d428g8f70f00abdd754e8@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua> <20091124081957.6216.74456.stgit@angua>
	<20091124.093732.203692950.davem@davemloft.net>
In-Reply-To: <20091124.093732.203692950.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu

On Tue, Nov 24, 2009 at 10:37 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 24 Nov 2009 01:20:05 -0700
>
>> In struct device_node, the phandle is named 'linux_phandle' for PowerPC
>> and MicroBlaze, and 'node' for SPARC. =A0There is no good reason for the
>> difference, it is just an artifact of the code diverging over a couple
>> of years. =A0This patch renames .node to .linux_phandle for SPARC.
>
> I know it's just a name, but there is no reason to put "linux" in the
> member name. =A0It's the real device phandle value from OpenFirmware not
> something invented by Linux's OF layer.

I agree, and I also considered renaming it to simply 'phandle' or to
change the powerpc code back to using .node everywhere (more on .node
usage in powerpc below).  I didn't want to use .node because .node is
pretty generic, and is used in other places for different things.
Basically I wanted to avoid confusion.  In particular, .node points to
a device_node, not a phandle, in struct of_device.  Changing all
references to simply 'phandle' seems to be the best, but it does
require changes to more locations in the code.  In the end I decided
on some constructive lazyness by settling for the already-used
.linux_phandle so that I would need to touch as many files, but still
retain a unique name that is easy to find.  If you prefer, I can
change it all to simply '.phandle'.

> PowerPC uses this for something different, it records the information
> here using the special "linux,phandle" and "ibm,phandle" properties.

Agreed, the phandle isn't a real phandle when using the flat tree.
However, though the source of the phandle value is different, the use
case is identical, so it make sense to stuff it into the same member.
Merging them lets me unify more code.  For example,
of_find_node_by_phandle().

> See unflatten_dt_node() in arch/powerpc/kernel/prom.c before your
> changes.

Yup, I looked at this.  The unflatten code stuffs both linux,phandle
and ibm,phandle into .linux_phandle, and linux,phandle also gets
stuffed into .node.  But all the users except one use the
.linux_phandle, not .node, and that remaining user *I think* can
safely use .linux_phandle too.

Thanks for the review,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
