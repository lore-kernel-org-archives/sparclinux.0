From: Alex Smith <ans1024@rit.edu>
Date: Sun, 25 Jan 2004 04:29:23 +0000
Subject: Ultra5 + Linux kernel 2.6.1 =  hangs while booting
Message-Id: <002801c3e2fb$d22e3c60$6400010a@goldeneye>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

(Also submitted to debian sparc list)

Hi Everyone,
=A0
I currently have version 2.4.18 #2 of the kernel, which came when I
installed Debian woody for Sparc.=A0 Everything is 'stable', except for gcc
and related packages which were upgraded to 'testing' (gcc 3.3.2).=A0 I have
been trying to compile a version of 2.6.1 for over a week with lots of
problems and I'm finally stuck, exhausting the web and forums, and need some
help.=A0=20
=A0
I have tried endless .config permutations, the most promising being the 2.6
Ultra10 example from:
=A0
http://dev.gentoo.org/~ciaranm/configs/kernel/
=A0
It seems like a lot of people like me have trouble with the size of the
kernel, and I can't ever use vmlinux, even compressed, so I follow these
steps:
=A0
make menuconfig
make
make image
make modules
make modules_install
=A0
The arch/sparc64/boot/image is then placed in /boot (along with the new
/boot/System.map) and added to silo.conf.
=A0
Whenever I try to boot to this from silo, I get:
=A0
=A0=A0=A0=A0=A0 boot: linux6
=A0=A0=A0=A0=A0 Loaded kernel version 2.6.1
=A0
=A0=A0=A0=A0=A0 Remapping the kernel... done.
=A0=A0=A0=A0=A0 Booting Linux...
=A0
Where it flashes the keyboard LEDs once, then appears to freeze
indefinitely. I have tried many of the graphics modules, but is there one I
need specifically?=A0 How will my Ultra5 config need to be different from t=
he
Ultra10?=A0 Should I go back to a 2.6 instead of 2.6.1?
=A0
Any ideas would be truly appreciated; I'm just tired of compiling.
=A0
Thanks,
=A0
=A0=A0=A0=A0=A0 Alex Smith
=A0=A0=A0=A0=A0 ans1024@rit.edu


