From: "Jester 2.0" <Jester2.0@comcast.net>
Date: Mon, 03 May 2004 05:42:36 +0000
Subject: Debian 3.01, kernel 2.6 compile error.
Message-Id: <S263600AbUECFmn/20040503054243Z+38@vger.kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a SMP Ultra2 running woody with gcc (GCC) 3.3.3.  When compiling
2.6.5, I receive the following error.

helios:/usr/src/linux-2.6.5# make
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTCC  scripts/sumversion.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/bin2c
  CC      init/main.o
init/main.c:70: #error Sorry, your GCC is too old. It builds incorrect
kernels.
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

- From the prompt, gcc --version shows 3.3.3 as above.

With using egcs, I get the following.

helios:/usr/src/linux-2.6.5# make CC=/usr/bin/sparc64-linux-gcc.egcs64
  CC      scripts/empty.o
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTCC  scripts/sumversion.o
  HOSTLD  scripts/modpost
  CC      init/main.o
init/main.c:70: #error Sorry, your GCC is too old. It builds incorrect
kernels.
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

I am out of ideas at this point.  Any help or suggestions is
appreciated.

Thanks,
 Jon


-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0.3

iQEVAwUBQJXbzA7mcyfFtUHcAQJ5TQf+LqQ1VyKASEHtq+g6gCdaxlH1P5KodTVH
JX65YE+CqBUAzXlL+JhOrvweWhabRXQLI+LEFm/nDNqEpe7TOjjX1N7f2964ia73
uiMXqggSnFY6EdW6w0UTOesWatFrFAPJqiV0v3J3SihxmPfWHrL+2/lgYM2K73L2
GByNXKy0btME1JW+n/3i6zq2gwRSvTE2IGadu3/XA019/qBCMumBAusDK4lchJ3N
54o+Tbr+Mctw55n20SY8Z8mBOr/nVCYvWS9SrsoJ6sMmidiZnk8T/kU5p+AoXKPY
yvjJdbaja6pah+xOY8JWW4Em7pn1eKwKbV7uy61RnfqzHr3UwefQxA=
=3Nrl
-----END PGP SIGNATURE-----

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.674 / Virus Database: 436 - Release Date: 5/2/2004



