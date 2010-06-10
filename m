From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 Jun 2010 06:32:23 +0000
Subject: Re: [PATCH 0/2] Replace of_device with platform_device
Message-Id: <1276151543.1962.48.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
	<AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
In-Reply-To: <AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

On Fri, 2010-06-04 at 15:13 -0600, Grant Likely wrote:
> This series is based on Linus' current tree.  It eliminate struct
> of_device in preparation for the merge of of_platform_bus_type and
> platform_bus_type.
> 
> Assuming there are no objections, I'll be putting these to linux-next
> to stew sometime next week.

I don't see any update to the macio stuff... have you fixed that
separately or are you up to breaking it -again- ? :-)

You should do build tests with a pmac32 or g5 defconfig every now and
then.

Cheers,
Ben.


