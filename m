From: "C.Newport" <crn@netunix.com>
Date: Mon, 16 Feb 2004 13:59:11 +0000
Subject: Re: [Q] sun mouse on 2.6.x
Message-Id: <200402161359.11544.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040215002314.GH19221@net-ronin.org>
In-Reply-To: <20040215002314.GH19221@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 16 February 2004 7:50 am, carbonated beverage wrote:
> On Sun, Feb 15, 2004 at 03:05:48PM +0200, Balint Cristian wrote:
> > 	If i power on from standby it happens that always not work,
> > but if I boot in 2.4 kernel than reboot in 2.6 it always works !!
> >
> > 	So 2.4 has someting that 2.6 miss at one point, it initialize
> > someting that 2.6 not, ant that init is reboot independent.
>
> Hmm... tried this, and whaddya know.  It works.  So somehow, 2.4.x
> is initializing the hardware state in a way 2.6.x isn't.  Thanks,
> I'll go and see what's different between the two...

What happens if you power down and cold boot rather than doing
a warm reboot.

I have a similar issue here on a triple boot Linux/Windoze/Solaris 
laptop, rebooting from windows and selecting solaris always goofs
up, it seems that some hardware is left in an odd state which gets
correctly initialised by the bios only if I do a cold boot.

