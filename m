From: "David S. Miller" <davem@redhat.com>
Date: Mon, 05 Jan 2004 09:17:45 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <20040105011745.3a6603e2.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 5 Jan 2004 03:05:58 -0500 (EST)
Ricky Beam <jfbeam@bluetronic.net> wrote:

> On Sun, 4 Jan 2004, David S. Miller wrote:
> >We cannot just depend upon PCI however for the 8250 driver options
> >as it may appear also in ISA and onboard forms.
> 
> No sparc32 or sparc64 system (that I know of) contain an actual 8250.
> Furthermore, the only systems to have an ISA bus are PCI systems (PCI-ISA
> bridged.) Granted, I've not used an SBUS based system in several years.

The 8250 drives all variants, including the kind used for the 'su' devices
in PCI sparc64 systems, this is what Peter was talking about when he alluded
to merging the sunsu.c driver into the 8250.c code.

Also, any system that has a PCI bus can therefore host one of those
serial/parallel PCI cards which use 8250 chips often.

So I stand where I started, that adding conditions to the 8250 Kconfig
option is totally pointless as no selection of checks are totally suitable.
