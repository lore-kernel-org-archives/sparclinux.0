From: Thomas Nemeth <tnemeth@free.fr>
Date: Tue, 04 May 2004 16:11:44 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <Pine.LNX.4.53.0405041807590.875@exether.vipere.noire>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Le 04.05.04, Art Haas a tapot=E9 :

| On Tue, May 04, 2004 at 10:04:58AM -0400, Ben Collins wrote:
| > Maybe it's just me, but the original version seems more readable, even
| > if it isn't proper formatting.
| >
| > > -	sparc_cpu_model =3D sun_unknown;
| > > -	if(!strcmp(&cputypval,"sun4 ")) { sparc_cpu_model=3Dsun4; }
| > > -	if(!strcmp(&cputypval,"sun4c")) { sparc_cpu_model=3Dsun4c; }
| > > -	if(!strcmp(&cputypval,"sun4m")) { sparc_cpu_model=3Dsun4m; }
| > > -	if(!strcmp(&cputypval,"sun4s")) { sparc_cpu_model=3Dsun4m; }  /* CP=
-1200 with PROM 2.30 -E */
| > > -	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=3Dsun4d; }
| > > -	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=3Dsun4e; }
| > > -	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=3Dsun4u; }
| > > +	if (!strcmp(&cputypval,"sun4 ")) {
| > > +		sparc_cpu_model=3Dsun4;
| > > +	} else if (!strcmp(&cputypval,"sun4c")) {
| > > +		sparc_cpu_model=3Dsun4c;
| > > +	} else if (!strcmp(&cputypval,"sun4m")) {
| > > +		sparc_cpu_model=3Dsun4m;
| > > +	} else if (!strcmp(&cputypval,"sun4s")) {
| > > +		sparc_cpu_model=3Dsun4m;	 /* CP-1200 with PROM 2.30 -E */
| > > +	} else if (!strcmp(&cputypval,"sun4d")) {
| > > +		sparc_cpu_model=3Dsun4d;
| > > +	} else if (!strcmp(&cputypval,"sun4e")) {
| > > +		sparc_cpu_model=3Dsun4e;
| > > +	} else if (!strcmp(&cputypval,"sun4u")) {
| > > +		sparc_cpu_model=3Dsun4u;
| > > +	} else {
| > > +		sparc_cpu_model =3D sun_unknown;
| > > +	}
|
| I don't like the original because it keeps doing strcmp() tests more
| times than necessary. That was my motivation in doing changing this bit
| of code.

	Hi.

	Why don't you just remove all strcmp's ?
	Something like
if (strlen(&cputypval)=3D4)
	sparc_cpu_model=3Dsun4;
else if (&cputypval[4]=3D'c')
	sparc_cpu_model=3Dsun4c;
else if (&cputypval[4]=3D'd')
	sparc_cpu_model=3Dsun4d;
...

	Could be better :) But of course, if Sun changes its naming
	scheme, it won't work anymore...


Thomas
--=20
printk("VFS: Busy inodes after unmount. "
        "Self-destruct in 5 seconds.  Have a nice day...\n");
        2.3.99-pre8 /usr/src/linux/fs/super.c
