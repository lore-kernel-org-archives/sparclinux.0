From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 26 Aug 2006 08:59:23 +0000
Subject: Re: [PATCH] sparc32: max_cache_size fallback
Message-Id: <44f00d6b8b482@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <44de28a4e7531@wp.pl>
In-Reply-To: <44de28a4e7531@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dnia 26-08-2006 o godz. 1:24 David Miller napisa=B3(a):
> This new fallback is "36 * 1024", ie. 36K?  That doesn't make any
> sense.  I thought the smallest SM40 cache size was 512K or
something
> like that.
>=20

According to the documentation I found ("Supersparc II Addendum"
by Sun), the Supersparc processors have 20KB  instruction cache
and 16 KB data cache on CPU. The SMX0 modules were modules
without the L2 cache so only cache on CPU is counted.=20

That max_cache_size counting procedure counts only L2 cache as it
is much bigger than L1. Thus for SMX0 modules it may give 0 (I
have no such SMP machine to test). At least one SMP configuration
was sold with such CPUs - it was called SparcStation 10/402 (it
can be found mentioned on specrate listings).

I peeked into the i386 code and found that for original Pentium
the max_cache_size is set to 16KB. The Pentium has 8KB
instruction cache and 8KB data cache (both L1 as it has no L2 on
he CPU). So I did the same for the Supersparcs.


> If anything it should be a power of two, not some weird number
> like 36K.

I added 20KB and 16Kb and got 36KB total cache size.

Regards,
Krzysztof

----------------------------------------------------
Za=B3=F3=BF konto. Przelewy - 0z=B3. Darmowe konto oszcz=EAdno=B6ciowe - 3,=
25%!
Sprawd=BC i wygraj Toyot=EA Aygo! >> Kliknij:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fing22.html&s=
id=854


