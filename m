From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 18 Dec 2006 03:20:03 +0000
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount /
Message-Id: <20061218032003.GU10316@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl>
In-Reply-To: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> I've been running kernel du jour straight from git on my SPARC Ultra 1 for
> some time now on Aurora Corona (Fedora relative, development branch). For a
> few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked fine,
> as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so I had to
> rebuild a kernel to check if the problem lay elsewhere). Unpacking the
> initrds for 2.6.19 and 2.6.19.1 shows the same (nash script) /init and the
> same modules in both (ext3 + jbd, scsi_mod, sd_mod, esp, others).
> 
> I'm stumped. Any clue?

Is this issue still present in the latest -git?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

