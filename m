From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Mon, 10 Aug 2009 13:45:34 +0000
Subject: [2.6.27.21] bbc_envctrl
Message-Id: <4A80247E.6040009@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello,

	I'm seeing some strange shutdowns on two Blade 2000 (kernel 2.6.21.27)=20
due to temp0 > 85 =B0C. I have cleaned these workstations and done some=20
stuff to investigate for some weeks. Problem persists, but it's for me=20
very strange.

	Following lines are printed by bbc_envctlr when this workstation builds=20
a linux kernel with -j4 (loadavg < 4). Room temperature is about 28 =B0C.

Aug 10 15:18:59 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:05 rayleigh kernel: temp0: cpu(62 C) amb(30 C)
Aug 10 15:19:05 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:10 rayleigh kernel: temp0: cpu(62 C) amb(30 C)
Aug 10 15:19:10 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:15 rayleigh kernel: temp0: cpu(62 C) amb(30 C)
Aug 10 15:19:15 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:20 rayleigh kernel: temp0: cpu(62 C) amb(30 C)
Aug 10 15:19:20 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:25 rayleigh kernel: temp0: cpu(61 C) amb(30 C)
Aug 10 15:19:25 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:30 rayleigh kernel: temp0: cpu(61 C) amb(30 C)
Aug 10 15:19:30 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:35 rayleigh kernel: temp0: cpu(61 C) amb(30 C)
Aug 10 15:19:35 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:40 rayleigh kernel: temp0: cpu(61 C) amb(30 C)
Aug 10 15:19:40 rayleigh kernel: temp1: cpu(63 C) amb(30 C)
Aug 10 15:19:45 rayleigh kernel: temp0: cpu(61 C) amb(30 C)
Aug 10 15:19:45 rayleigh kernel: temp1: cpu(63 C) amb(30 C)

	I have checked fan speeds :

Aug 10 15:19:45 rayleigh kernel: fan speeds: cpu(0c) sys(3f)

	These values seem to be good (3f is forced because amb temp >=3D 30 =B0C, =

0c is good because cpu temp < 65 =B0C).

	Sometimes, reported temp0 values can grow until 85 =B0C. When temp0 is=20
growing, system is idle (thus, I don't understand how temperature can be=20
greater than 85 =B0C...).

Aug 10 04:20:06 rayleigh kernel: temp0: Above safe CPU operating=20
temperature, 85 C.
Aug 10 04:20:06 rayleigh kernel: temp0: Outside of safe CPU operating=20
temperature, 85 C.
Aug 10 04:20:06 rayleigh kernel: kenvctrld: Shutting down the system now.
Aug 10 04:20:06 rayleigh shutdown[19130]: shutting down for system halt
Aug 10 04:20:08 rayleigh init: Switching to runlevel: 0

	I have written some code to debug bbc_envctrl without any success and=20
bbc_envctrl seem to be bug free. When system is overheating, kernel=20
always claims against temp0 (never against temp1 even I swap CPU0 and=20
CPU1.).

	Does someone see the same strange shutdown process on UltraSPARC-III? I=20
suspect that a bad temp is reported by sensors for some reasons.

	Regards,

	JKB
