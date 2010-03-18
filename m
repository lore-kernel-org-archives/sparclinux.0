From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 15:35:30 +0000
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node pointers
Message-Id: <fa686aa41003180835k5af2d0e4o11f8ab9ca2e905ed@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au

On Thu, Mar 18, 2010 at 9:22 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Currently, each of_device has a copy of the device tree node pointer in b=
oth
> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
> .dev.archdata.prom_node (sparc). =A0Also, other architectures will be add=
ing
> CONFIG_OF support, and they will also need a reference to the device tree
> node pointer from struct device.
>
> This series consolidates the device node pointer by adding .of_node to
> struct device (conditional on CONFIG_OF) and removing the archdata.of_nod=
e,
> archdata.prom_node and of_device.node users. =A0The pointer is moved out =
of
> dev_archdata and into struct device proper so that of_node doesn't need to
> get manually added to archdata for each architecture that enables CONFIG_=
OF.

This series is also available in my git tree:

git://git.secretlab.ca/git/linux-2.6 experimental-devicetree
