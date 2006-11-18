From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Sat, 18 Nov 2006 00:07:05 +0000
Subject: Re: Super/HyperSPARC (2.6.18.2)
Message-Id: <200611180007.kAI075MX028068@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20061116154638.GA3138@rayleigh.systella.fr>
In-Reply-To: <20061116154638.GA3138@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

>	I use some SS20 to tests (as routers). All of these workstations have 2
>	SSII/75, but I have some single and dual RT626.
>
>	On one SS20, I have changed SuperSPARC by HyperSPARC. It runs with a
>	2.6.18.2 linux kernel and a debian/testing. With ROOS, I can see a very
>	strange mistake : apt-get returns a random error (only occurs with
>	hypersparc, UP and SMP).
>
>	I have tested all motherboards and modules I have used for test with Sola=
ris
>	and netbsd. All work fine. I don't understand why I only see this bug with
>	apt-get. Is there any issue ? A bug in hypersparc specific code ?

What PROM version do you use? I had strange errors as well until I updated
the PROMs,

HTH,
Uli
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Cauchemar (Op=E9ration S)
24539 Neumuenster, Germany|Good Looks, Big Deal (Sweatmaster)
