From: Ricky Beam <jfbeam@bluetronic.net>
Date: Mon, 05 Jan 2004 08:05:58 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <Pine.GSO.4.33.0401050257001.26470-100000@sweetums.bluetronic.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 4 Jan 2004, David S. Miller wrote:
>I think we should not disallow this option, as the device may very
>well appear on PCI systems.

Correct.

>We cannot just depend upon PCI however for the 8250 driver options
>as it may appear also in ISA and onboard forms.

No sparc32 or sparc64 system (that I know of) contain an actual 8250.
Furthermore, the only systems to have an ISA bus are PCI systems (PCI-ISA
bridged.) Granted, I've not used an SBUS based system in several years.

--Ricky


