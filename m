From: "David S. Miller" <davem@redhat.com>
Date: Mon, 05 Jan 2004 00:28:31 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <20040104162831.40901ef6.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 04 Jan 2004 17:15:58 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Sun, 2004-01-04 at 16:48, Keith M Wesolowski wrote:
> 
> > This really isn't the right thing to depend on, although I'm not sure
> > what is.  This chip is found almost everywhere.
> 
> Is it natively found in any model of 32bit SPARC? The only possible way
> I can think of getting one in a sparc32 machine is by adding a PCI 8250
> card to a JavaStation, which the PROM won't recognize anyway.

I think we should not disallow this option, as the device may very
well appear on PCI systems.

We cannot just depend upon PCI however for the 8250 driver options
as it may appear also in ISA and onboard forms.

I do not see any reason why allowing this option to be enabled is a problem.
People just have to become knowledgable about what kind of hardware
they actually have right? :)
