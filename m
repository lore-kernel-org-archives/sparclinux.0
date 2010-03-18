From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 16:52:47 +0000
Subject: RFC: of_platform and platform bus merge
Message-Id: <fa686aa41003180952q547ab888kff72a4f0bf258677@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>

Hi Dave,

I need your opinion on the of_platform bus.  For powerpc, microblaze,
and all others I intend to merge the current of_platform_bus_type with
platform_bus_type.  powerpc and microblaze basically use of_platform
bus as if it were the platform bus, so this is an easy decision to
make.  As I mentioned, I've already written a patch that makes
of_device and platform_device the same structure.  I also think I have
a way to adapt the of_platform_driver registration to make existing
of_platform_drivers register on the platform bus without any driver
changes, and preserving the existing OF-style match behaviour
(basically by moving the of_match_table into struct device_driver when
CONFIG_OF is set; I've got a patch that does this too), and preserving
the existing device hierarchy.

However, I know that sparc uses a different model in that every node
in a sparc device tree gets registered on the of_platform_bus, not
just the things that would be analogous to 'platform' devices.
Therefore, the merging of_platform_bus_type and platform_bus_type, and
the inherent co-mingling of device drivers for both buses, has a
higher likelyhood of causing problems on sparc than it does on powerpc
or microblaze.

I see two possible ways to proceed.
1. Split of_platform code so that sparc preserves the old behaviour,
while powerpc, mb, arm, etc. go ahead with the of_platform bus merge.
ie. when building sparc, of_platform_drivers will get registered on
the of_platform_bus_type as they currently do.  When building
everything else, of_platform_driver registration will use an adapter
shim to register of_platform_drivers onto the platform bus.  Non-sparc
of_platform_drivers will slowly get migrated to normal platform
drivers, and eventually the of_platform_bus APIs will be a
sparc-specific thing.

2. Merge of_platform_bus_type with platform_bus on sparc too.

I'm happy to take either path, so I need to know your opinion on the
of_platform/platform bus merger.  I will of course do all the sparc
compile testing on any changes that I make, but I'll need help making
sure I don't break things at runtime.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
