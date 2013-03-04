From: Mario Caruso <caruso@tiscali.com>
Date: Mon, 04 Mar 2013 08:39:59 +0000
Subject: Kernel Panic sunfire v210
Message-Id: <20130304093959.773c094f@uptheirons.ws.tiscali.sys>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/8nEBXvXMdWmGcyMMYGCD4yB"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Sig_/8nEBXvXMdWmGcyMMYGCD4yB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,
I'm experiencing a weird kernel panic on a sun fire v210=20
running debian squeeze and kernel 3.2.35 from backports,
from time to time the machine hangs and on the console=20
I get the following report :=20

Contents of run buffer:

[404832.601822] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[404832.671592] ERROR(0): Highest priority error (0000100000000000) "Unmapp=
ed error from system bus"
[404832.788259] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000=
000000000]
stag[0000000000000000] [404832.914069] ERROR(0): D-cache data0[000000000000=
0000]
data1[0000000000000000] data2[0000000000000000] data3[0000000000000000] [40=
4833.063900] ERROR(0):
I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000=
000000]
u[0000000000000000] l[0000000000000000] [404833.235461] ERROR(0): I-cache I=
NSN0[0000000000000000]
INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000] [40=
4833.385286] ERROR(0):
I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000=
000]
INSN7[0000000000000000] [404833.535114] ERROR(0): E-cache idx[40000000] tag=
[0000000006008ef2]
[404833.616314] ERROR(0): E-cache data0[00477b0000000000] data1[00000000000=
00000]
data2[0000000000000000] data3[0000000000000000] [404833.766149] Kernel pani=
c - not syncing:
Irrecoverable deferred error trap. [404833.766153] [404833.878222] Call Tra=
ce: [404833.911398]
[0000000000429b74] cheetah_deferred_handler+0x4b0/0x4e8 [404833.996036]  [0=
000000000405e50]
c_deferred+0x18/0x24 [404834.062365]  [0000000000407bb0] copy_tsb+0x30/0x80
[404834.126421]  [00000000007acc58] do_sparc64_fault+0x588/0x780
[404834.201902]  [00000000004079a8] sparc64_realfault_common+0x10/0x20
[404834.284257]  [000000000045de44] schedule_tail+0x78/0x88
[404834.354018]  [0000000000406050] ret_from_syscall+0x8/0x18
[404834.426079] Press Stop-A (L1-A) to return to the boot prom

the machine has 1 CPU shown as below :=20

cat /proc/cpuinfo
cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
pmu             : ultra3i
prom            : OBP 4.30.4.a 2010/01/06 14:48
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         : flush,stbar,swap,muldiv,v9,ultra3,mul32,div32,v8plus,vis,=
vis2
Cpu0ClkTck      : 000000004fa1be00
MMU Type        : Cheetah+
State:
CPU0:           online

can anybody suggest a way to debug this issue ?=20

tnx

M.
---------------------------
  () ASCII Ribbon Campaign
  /\ Against HTML E-Mail
---------------------------
This mail is ubuntu Hostile
---------------------------

--Sig_/8nEBXvXMdWmGcyMMYGCD4yB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlE0Xd8ACgkQ9XYbM7TdPPsXQgCgnyinA7gVQqkkkXRyjMXqjbFl
KgoAnieK9gm/V+44hQCU6HqkTfJiJIkL
=Ntx9
-----END PGP SIGNATURE-----

--Sig_/8nEBXvXMdWmGcyMMYGCD4yB--
