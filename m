From: David Miller <davem@davemloft.net>
Date: Tue, 27 Mar 2007 08:24:02 +0000
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D Framebuffer (sparc64) on
Message-Id: <20070327.012402.101595789.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4608CDC5.6020202@systella.fr>
	<20070327.010456.26278286.davem@davemloft.net>
	<4608D34D.7000300@systella.fr>
In-Reply-To: <4608D34D.7000300@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: joel.bertrand@systella.fr
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 27 Mar 2007 10:18:21 +0200

> 	I understand. Please, can you send to me your .config (for SMP=20
> workstation) and your gcc release. I shall investigate difference=20
> between your configuration and mine. If your U2 is stable, maybe a=20
> kernel option can solve the trouble.

Config is at:

       http://vger.kernel.org/~davem/ultra2.config

GCC is 4.1.2 Ubuntu 4.1.2-0ubuntu4 out of current feisty release.
Current debian gcc-4.1.x is likely almost identical.

My machine is very simply configured, onboard HME ethernet,
Creator3D, and a 45GB scsi disk hung off of the onboard ESP
scsi controller.  512MB of ram.

FWIW my machine was very unstable (it would power off after being
up for more than 4 minutes) until I cleaned all of the dust out of
the inside and reseat all of the RAM and cpus. :-)
