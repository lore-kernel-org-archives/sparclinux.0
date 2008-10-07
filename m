From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Tue, 07 Oct 2008 21:39:09 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20081007233909.42427f09.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 4 Oct 2008 15:26:07 +0400
"Alexander Beregalov" <a.beregalov@gmail.com> wrote:

> 2008/10/4  <krzysztof.h1@poczta.fm>:
> > Do you reboot your system with different kernel versions (-next and mainline) or other systems?
> Yes, I tested mainline and sparc-next kernels on two Ultra 10s, but I
> could not find the rule how it happens.
> It means it does not happen every time I use sparc-next or every time
> I use mainline right after sparc-next.
> 

Ok.

I found the problem. The rtc-m48t59 driver sets a century bit if the year is over 2000. It is not correct on sparc as the first year is 1968 (so the century bit is needed in year 2168).

The only sane solution is to reduce mostek_read_byte() and mostek_write_byte() and move the sparc specific year offset (1968) into the rtc-m48t59 driver.

I'll prepare a patch.

Thank you for reporting this,
Krzysztof

----------------------------------------------------------------------
Dodaj strone www do katalogu. Pokaz ze istniejesz!
Sprawdz jak >> http://link.interia.pl/f1f2a 


