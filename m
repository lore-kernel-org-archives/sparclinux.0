From: william felipe_welter <wfelipew@gmail.com>
Date: Wed, 01 Jun 2011 16:39:04 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <BANLkTind3TMhu-R1t+09V68JyAJv0DCDRQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> The start addresses of fixed and shared mappings need to have a
> certain property relative to other such mappings.
>
> And that property is that the addresses must all be modulo the
> D-cache alias factor, which on sparc64 is 16384 bytes.
>

How can i do this? Calculate?

Example:
addr_orig =3D mmap (NULL, bytes, PROT_NONE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);


addr =3D mmap ( addr_orig , bytes, PROT_READ | PROT_WRITE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MAP_FIXED | MAP_SHARED, fd, 0);

Should i do addr_orig % 16384 ??


--
William Felipe Welter
------------------------------
Consultor em Tecnologias Livres
william.welter@4linux.com.br
www.4linux.com.br
