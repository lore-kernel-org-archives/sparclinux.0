From: Chris Newport <crn@netunix.com>
Date: Thu, 08 Oct 2009 01:29:25 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <Pine.LNX.4.60.0910080155210.12519@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007135243.GC21646@anhedonia> <4ACCEC67.9070106@firmworks.com>
	<Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
	<20091007.140938.255120957.davem@davemloft.net>
In-Reply-To: <20091007.140938.255120957.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sammy@sammy.net, sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, julian.calaby@gmail.com, wmb@firmworks.com, linuxppc-dev@lists.ozlabs.org

On Wed, 7 Oct 2009, David Miller wrote:

>> Sun4c has also been broken for a long time and sun4d has never worked
>> properly. Is it time to also prune these ?.
>> That would leave only Sun4m in the 32bit kernel, which still works and
>> has plenty of ongoing user interest.
>
> Chris don't over-exaggerate the state.
>
> The truth is that the whole sparc32 port is in a state of mild
> disrepair, and many of the issues apply to all the port rather than
> just one family of systems.  I think someone suitably motivated
> could get most of the bugs sorted out.
>
> There is no reason to drop support for SS1 machines, we already fully
> build the software device tree and use all of the generic OF
> infrastructure in the Linux kernel on those systems.  It is not a road
> block at all for the OF genericization work, if that's what you read
> into wmb's email.

Your call, as you say there is little to be gained other than tidyness.

FWIW my opinions (and ICBW) are based on :-
Sun4c machines have a max of 48 or 64Mb and very few are still working
Sun4d has never had SMP support and this is apparantly problematic
  due to Cray interlectual property causing a lack of bus documentation.
  Running these heavy and power hungry lumps UP is a bit silly.

