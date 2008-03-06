From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 06 Mar 2008 20:23:11 +0000
Subject: Re: [PATCH 1/2] firewire: endianess fix
Message-Id: <20080306202311.GA18925@iram.es>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
	<200802281342.06493.jwilson@redhat.com>
	<1204241162.15052.393.camel@pasglop>
	<47C79CB1.6050104@redhat.com> <20080303091927.GA27105@iram.es>
	<47CC0C95.1030709@s5r6.in-berlin.de>
	<20080305225902.GA27985@iram.es>
	<47CF2C08.5000609@s5r6.in-berlin.de>
In-Reply-To: <47CF2C08.5000609@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>, linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, Harvey Harrison <harvey.harrison@gmail.com>

On Thu, Mar 06, 2008 at 12:26:00AM +0100, Stefan Richter wrote:
> Gabriel Paubert wrote:
> >>>I have a Pismo which I use on a virtually
> >>>daily basis (and about to remove the last remnants of MacOS on it). 
> >>>However I have disabled Firewire because it would not sleep and wake 
> >>>up properly. 
> ...
> >For now I have only tested the new stack with a 6 year old 1.8" disk
> >and everything works, including suspend to RAM. The kernel is 2.6.25-rc4
> >plus additional pull from linux1394-2.6.git: 2.6.25-rc4-00032-g8d36ba4.
> 
> That's great.  Thanks for testing.

The old stack also works. I forgot to mention that with the new
stack (not with the old) there is a message when going to sleep:

firewire_ohci: pci_set_power_state failed with -5

but it is harmless, and if I understand correctly due to the 
fact that the power management on this chip is not implemented 
through capability fields in the PCI configuration space.

	Gabriel
