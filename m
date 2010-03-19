From: David Miller <davem@davemloft.net>
Date: Fri, 19 Mar 2010 00:32:03 +0000
Subject: Re: RFC: of_platform and platform bus merge
Message-Id: <20100318.173203.226756208.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <fa686aa41003180952q547ab888kff72a4f0bf258677@mail.gmail.com>
In-Reply-To: <fa686aa41003180952q547ab888kff72a4f0bf258677@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, michal.simek@petalogix.com, jeremy.kerr@canonical.com

From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 10:52:47 -0600

> 2. Merge of_platform_bus_type with platform_bus on sparc too.

Try this, if it explodes we'll just revert it and have
to think of a better idea.

The only issue that can arise is the case where some
platform device driver uses a name that exists in
the OF device tree name space.

We have control over the names that the pure platform device
drivers use, so...  we could fix such conflicts and therefore
maintain the merge on sparc.
