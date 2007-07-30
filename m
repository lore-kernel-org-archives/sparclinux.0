From: gavin duley <gduley@une.edu.au>
Date: Mon, 30 Jul 2007 09:16:53 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070730091651.GA19219@snoopy.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Jul 30, 2007 at 09:04:27AM +0200, BERTRAND Jo=EBl <joel.bertrand@sy=
stella.fr> wrote:
[snip]
>> You seem to see the problem only on the systems that have the 450Mhz
>> cpus, any chance you can test the ultra60 with a different cpu
>> variant?  Perhaps those chips are part of the problem.
>
> 	And we can explain why on my U2/SMP (Uii@296MHz), I cannot reproduce the=
=20
> bug. I only have Uii@296 MHz and Uii@450 MHz, and I cannot switch CPU's=20
> between my U2 and one of my U60 (I need a running U2). If you want, I can=
=20
> open a ssh access on one of my U60 to do some tests.
> What's cache size on your CPU's ? 450 has 4 MB, 296, only 2 MB.
>
> 	Gavin, what are your CPU's ?

My Sun box is a Sun Ultra 5 with just one processor: a TI UltraSparc IIi=20
(Sabre). From memory, it is 333MHz with 2MB cache.

gavin,


[Please cc: me as I'm not on this list. Thanks.]
--=20
Wonder is the beginning of all science.
	-- Aristotle

Gavin Duley
<gduley@une.edu.au>   <gduley@turing.une.edu.au>
http://www-personal.une.edu.au/~gduley/
