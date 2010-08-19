From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 19 Aug 2010 21:32:32 +0000
Subject: Re: [PATCH] of/device: Replace struct of_device with struct of_platform
Message-Id: <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100801074831.1099.3318.stgit@angua>
	<AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
In-Reply-To: <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Timur Tabi <timur@freescale.com>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, alsa-devel mailing list <alsa-devel@alsa-project.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
>> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
>
> This file is/was significantly rewritten for 2.6.37. =A0I posted a fix
> to the alsa mailing list, but it will conflict with your patch. =A0You
> might want to remove all changes to sound/soc/fsl from this commit.

This change is already in Linus' tree.

g.
