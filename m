From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 24 Nov 2019 13:48:41 +0000
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
Message-Id: <20191124134840.GA6630@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <20191124085720.6201-1-rppt@kernel.org>
 <e91984fa-3544-8b7e-d577-54125b075fbe@physik.fu-berlin.de>
In-Reply-To: <e91984fa-3544-8b7e-d577-54125b075fbe@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

On Sun, Nov 24, 2019 at 10:44:36AM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 11/24/19 9:57 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and replace 5leve-fixup.h with pgtable-nop4d.h.                                      
>                                       ^^^^^ typo?

Oops, indeed :)

David, if everything else is ok, could you please fix this when applying?

> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
Sincerely yours,
Mike.
