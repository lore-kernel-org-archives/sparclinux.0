From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 23 Mar 2010 07:06:42 +0000
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node pointers
Message-Id: <fa686aa41003230006v6098afe7s1bcb64f409f11a5a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<1269327424.5953.12.camel@concordia>
In-Reply-To: <1269327424.5953.12.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: michael@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Tue, Mar 23, 2010 at 12:57 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Thu, 2010-03-18 at 09:22 -0600, Grant Likely wrote:
>> Currently, each of_device has a copy of the device tree node pointer in =
both
>> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
>> .dev.archdata.prom_node (sparc). =A0Also, other architectures will be ad=
ding
>> CONFIG_OF support, and they will also need a reference to the device tree
>> node pointer from struct device.
>
> Assuming this is similar to your experimental-devicetree branch, as of
> 96b4b9d7 it causes a few build errors for me:
>
> http://kisskb.ellerman.id.au/kisskb/head/2688/
>
> Broken are 86xx/sbc8641d_defconfig, mpc83xx_defconfig,
> mpc885_ads_defconfig, mpc85xx_defconfig, and pmac32_defconfig.

Hey Michael,

Thanks for the testing.  I haven't built through all the defconfigs
yet so this doesn't surprise me too much that I've missed some
drivers.  The failure is caused in the last three commits which remove
the old variables.  I'll pick through the failing defconfigs, fix and
test them, and refresh my branch.

I'll let you know when the branch is updated.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
