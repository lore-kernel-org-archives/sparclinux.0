From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 18 Dec 2006 03:29:59 +0000
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount /
Message-Id: <200612172130.00346.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl> <20061218032003.GU10316@stusta.de>
In-Reply-To: <20061218032003.GU10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Once upon a time Sunday 17 December 2006 9:20 pm, Adrian Bunk wrote:
> On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> > I've been running kernel du jour straight from git on my SPARC Ultra 1
> > for some time now on Aurora Corona (Fedora relative, development branch).
> > For a few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked
> > fine, as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so
> > I had to rebuild a kernel to check if the problem lay elsewhere).
> > Unpacking the initrds for 2.6.19 and 2.6.19.1 shows the same (nash
> > script) /init and the same modules in both (ext3 + jbd, scsi_mod, sd_mod,
> > esp, others).
> >
> > I'm stumped. Any clue?
not 100% sure here.  Check the size of the initrd.  kinda sounds like an issue 
that hit rawhide last week that needed a new mkinitrd.  if its smaller grab 
the srpm from the Fedora Development tree for mkinitrd and rebuild it.  then 
recreate your initrd and see if that works.

Dennis
