From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 16 Dec 2005 22:21:54 +0000
Subject: Re: linux 2.6.14.4 sparc compile problem
Message-Id: <20051216222154.GK23349@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512160832350.995@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512160832350.995@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Dec 16, 2005 at 08:33:48AM -0500, Gerhard Mack wrote:
> Hello, 
> 
> I tried to compile kernel 2.6.14.4 on my sparc and I got this:
> 
> drivers/built-in.o(.init.text+0x1184): In function `rtc_init':
> : undefined reference to `ebus_chain'
> drivers/built-in.o(.init.text+0x1188): In function `rtc_init':
> : undefined reference to `ebus_chain'
> drivers/built-in.o(.init.text+0x1190): In function `rtc_init':
> : undefined reference to `isa_chain'
> drivers/built-in.o(.init.text+0x11d4): In function `rtc_init':
> : undefined reference to `isa_chain'
> drivers/built-in.o(.init.text+0x11d8): In function `rtc_init':
> : undefined reference to `isa_chain'
> make: *** [.tmp_vmlinux1] Error 1

Please send your .config .

> Gerhard Mack

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

