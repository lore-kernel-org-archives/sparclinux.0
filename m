From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 15 Sep 2009 09:58:33 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090915095833.GA18889@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Sep 15, 2009 at 02:11:24AM -0700, David Miller wrote:
> I was able to reproduce the hang with your originally posted config.
> 
> It only triggers when CONFIG_PROM_CONSOLE is enabled, I keep telling
> people to turn it off.  Nobody should be using it, it either breaks
> things or it slows the console down considerably.
> 
> That's it, I'm completely removing that driver from the tree this
> merge window, so you guys can't mess it up any more even if you want
> to :-)

Oh! Well, that's good.

I googled for it now and found in some Ubuntu kernel changelog that Fabio
did it this way:

linux-source-2.6.17 (2.6.17-10.26) edgy; urgency=low

  *  make promcon driver init a boot option:
    - fix Niagara cpu soft lockups. (Closes Ubuntu: #61821)

  The generic PROM_CONSOLE driver is just too slow and blocks IRQ during
  normal output. Ideally the PROM_CONSOLE should be used only if we fail
  to find the correct driver for a certain hardware. In reality when built in
  it will be always used as default. With this workaround, we init the driver
  only on specific requests.
  The pro is that all machines that have a working console driver will notice
  a speed up at boot. The cons is that machines for which we have no driver
  will need to wait for one or boot with "forcepromconsole" boot option.

 -- Fabio M. Di Nitto <email address hidden>   Mon, 02 Oct 2006 06:48:54 +0200

If the PROM console driver still has some utility, maybe the boot option is
the way to go... does it? Does anyone still manufacture new machines with
new and strange console types that we don't support? :)

-- 
     2. That which causes joy or happiness.
