From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 01 Feb 2009 21:51:13 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <Pine.LNX.4.61.0902012149450.12403@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

Silly question. If ARCH=sparc is not 64bit then how do you make a 32bit 
sparc kernel?

Regards
 	Mark.

On Sun, 1 Feb 2009, Bastian Blank wrote:

> On Sun, Feb 01, 2009 at 10:00:29PM +0300, Alexey Dobriyan wrote:
>> generates 64-bit kernel, while earlier it generated 32-bit kernel.
>
> This is in line with the other 32/64bit arches, s390 and powerpc. If
> you think this is a problem, you should bring that to the kbuild
> maintainers, because they need to find something then.
>
> Bastian
>
> -- 
> Suffocating together ... would create heroic camaraderie.
> 		-- Khan Noonian Singh, "Space Seed", stardate 3142.8
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
