From: Timur Tabi <timur@freescale.com>
Date: Thu, 19 Aug 2010 20:36:21 +0000
Subject: Re: [PATCH] of/device: Replace struct of_device with struct of_platform
Message-Id: <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100801074831.1099.3318.stgit@angua>
In-Reply-To: <20100801074831.1099.3318.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net, alsa-devel mailing list <alsa-devel@alsa-project.org>

On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:

> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +-

This file is/was significantly rewritten for 2.6.37.  I posted a fix
to the alsa mailing list, but it will conflict with your patch.  You
might want to remove all changes to sound/soc/fsl from this commit.

--=20
Timur Tabi
Linux kernel developer at Freescale
