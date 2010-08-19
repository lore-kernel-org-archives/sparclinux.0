From: Timur Tabi <timur@freescale.com>
Date: Thu, 19 Aug 2010 21:36:39 +0000
Subject: Re: [PATCH] of/device: Replace struct of_device with struct of_platform
Message-Id: <4C6DA3E7.20206@freescale.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100801074831.1099.3318.stgit@angua> <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com> <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
In-Reply-To: <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net, alsa-devel mailing list <alsa-devel@alsa-project.org>

Grant Likely wrote:
> On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
>> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>>>  sound/soc/fsl/mpc8610_hpcd.c                  |    4 +-
>>
>> This file is/was significantly rewritten for 2.6.37.  I posted a fix
>> to the alsa mailing list, but it will conflict with your patch.  You
>> might want to remove all changes to sound/soc/fsl from this commit.
> 
> This change is already in Linus' tree.

Then I suspect the ALSA guys are going to have a merge conflict coming up,
because I had to make these changes to the -next branch.


