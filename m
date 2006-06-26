From: Rene Rebe <rene@exactcode.de>
Date: Mon, 26 Jun 2006 07:02:12 +0000
Subject: sparc64 fmulq emulation glitch?
Message-Id: <200606260902.12375.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

during some testing I accidently found fmulq that I think is emulated by
the kernel for this CPU type:

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU

to not yield the corrent results for powers of two in the range [-8,+8] . F=
or
example this tiny example:

int main ()
{
        long double a =3D 2;
        long double b =3D 1.0;
        a *=3D b;
        printf ("%Lf\n", a);
}

built with: gcc -m64 -mhard-quad-float

yields: 4

I tried to get thru the kernel code but have not yet garsped
all the macro magic ... Maybe someone has an idea?

(Kernel is 2.6.17-rc6)

Yours,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
