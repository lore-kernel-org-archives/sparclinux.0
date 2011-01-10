From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 08:30:13 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110083013.GA12883@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 10, 2011 at 12:20:37AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 7 Jan 2011 23:41:51 +0100
> 
> > I tried to change resolution like this:
> > 
> > prom> setenv output-device=screen:x1024x768x70
> > prom> reset-all
> > 
> > I then used:
> > prom> cd /pci/SUNW,m64B
> > prom> .properties
> > 
> > This showed that the new resolution had been stored.
> > 
> > But this had no effect on he output :-(
> 
> Weird, because the atyfb code in atyfb_setup_sparc() is designed to
> explicitly respect the OpenFirmware resolution and refresh settings.
> 
> Can you make sure that:
> 
> 	dp = pci_device_to_OF_node(pdev);
> 	if (dp = of_console_device) {
> 
> check does in fact trigger?  The code protected by that conditional is
> the code that implements the importing of OpenFirmware's configured
> resolution.
> 
> I'll try to find time to fire up my sb100 and try to help debug this,
> since I'm actually at the physical location of mine at the moment :-)

I will try when I get home later today - it will be ~10 hours from now.

The display I see on the monitor after the hand-over complete is
a few coloumns of duplicated text.
As my primitive root filesystem halts I cannot produce any output.

When I enter the prom console I continue to see the same text
in the background.
If it is on any help I can try to take a picture.

	Sam
