From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Wed, 27 Dec 2006 20:38:50 +0000
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount /
Message-Id: <200612272038.kBRKcosK021701@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Mon, 18 Dec 2006 04:20:03 BST." <20061218032003.GU10316@stusta.de> 
References: <20061218032003.GU10316@stusta.de>
In-Reply-To: <20061218032003.GU10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> > I've been running kernel du jour straight from git on my SPARC Ultra 1 for
> > some time now on Aurora Corona (Fedora relative, development branch). For a
> > few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked fine,
> > as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so I had to
> > rebuild a kernel to check if the problem lay elsewhere). Unpacking the
> > initrds for 2.6.19 and 2.6.19.1 shows the same (nash script) /init and the
> > same modules in both (ext3 + jbd, scsi_mod, sd_mod, esp, others).

> > I'm stumped. Any clue?

> Is this issue still present in the latest -git?

Sorry, got sidetracked by other stuff.

Still no boot with 2.9.20-rc1 and -rc2, and none of the kernels I tried in
between.

initrd is sane (the only differences between the one built for working
2.6.19.1 and broken 2.6.20-rc2 are among the modules themselves). What I
did was:

  cd /tmp
  mkdir ird-$version
  cd ird-$version
  zcat /boot/initrd-$version.img | cpio -i

and then "diff -Nur ird-$1 ird-$2". Now to teach diff(1) to compare devices
reasonably...

Tried latest from Fedora rawhide (mkinitrd-6.0.6-1), no boot. initrd is
huge, so I went back to mkinitrd-5.1.19-1.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

