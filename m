From: Joshua Kwan <joshk@triplehelix.org>
Date: Sun, 28 Nov 2004 09:36:24 +0000
Subject: [2.4.27] zs_open tts/%d0, tty overwrite.
Message-Id: <20041128093624.GA16005@darjeeling.triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

It seems like there's some problems with info->tty getting replaced
with something funny in zs_open on 2.4.27. Either this problem has
existed since 2.2 days or it's just now come back to haunt us.

Here is the final stage of a Debian install on sparc32, where 'init Q'
is called so that inittab is re-read, and a getty can be started on ttyS0:

INIT: Sending przs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
zs_open tts/%d0, tty overwrite.
=2E... many, many times ....

And then an oops (i've parsed it):

tsk->{mm,active_mm}->context =3D 00000c07
tsk->{mm,active_mm}->pgd =3D fc009400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops
PSR: 40401fc1 PC: f00e1c40 NPC: f00e1bf8 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: fe34a850 g1: 00000000 g2: 00000067 g3: 00000000 g4: f01df634 g5: fffffc=
18 g6: f000e000 g7: 00000003
o0: 00000064 o1: 00000001 o2: 000000e4 o3: f0199000 o4: fe34a850 o5: f0b39d=
c0 sp: f000fce0 o7: f00e1a28
l0: 00000007 l1: f8f20000 l2: 00000064 l3: 00000001 l4: f01e6000 l5: fffffc=
18 l6: f8ed8000 l7: f43db7d4
i0: f0220060 i1: f000fe78 i2: 000000e4 i3: 00000000 i4: fe34a400 i5: fe34a4=
00 fp: f000fd48 i7: f00e1eec
Caller[f00e1eec]
Caller[f0014e44]
Caller[f0012668]
Caller[f00161ac]
Caller[f01b4eec]
Caller[f01b4790]
Caller[00000000]
Instruction DUMP: 10bffff0  84102002  10bfffef <c0284000> 7ffce52d  81e8000=
0  7fffff1b  81e80000  7ffff9ad=20


>>PC;  f00e1c40 <receive_chars+250/298>   <=3D=3D=3D=3D=3D

>>g0; fe34a850 <[jbd].text.end+a7d/252d>
>>g4; f01df634 <kstat+30/1460>
>>g6; f000e000 <init_task_union+0/2000>
>>o3; f0199000 <init_signals+59c/604>
>>o4; fe34a850 <[jbd].text.end+a7d/252d>
>>o5; f0b39dc0 <end+91e770/e0f1a10>
>>sp; f000fce0 <init_task_union+1ce0/2000>
>>o7; f00e1a28 <receive_chars+38/298>
>>l1; f8f20000 <end+8d049b0/e0f1a10>
>>l4; f01e6000 <log_buf+3ca8/4000>
>>l6; f8ed8000 <end+8cbc9b0/e0f1a10>
>>l7; f43db7d4 <end+41c0184/e0f1a10>
>>i0; f0220060 <end+4a10/e0f1a10>
>>i1; f000fe78 <init_task_union+1e78/2000>
>>i4; fe34a400 <[jbd].text.end+62d/252d>
>>i5; fe34a400 <[jbd].text.end+62d/252d>
>>fp; f000fd48 <init_task_union+1d48/2000>
>>i7; f00e1eec <zs_interrupt+118/130>

Trace; f00e1eec <zs_interrupt+118/130>
Trace; f0014e44 <handler_irq+84/d4>
Trace; f0012668 <patch_handler_irq+0/24>
Trace; f00161ac <cpu_idle+7c/15c>
Trace; f01b4eec <start_kernel+1c8/1dc>
Trace; f01b4790 <sun4c_continue_boot+314/324>
Trace; 00000000 Before first symbol

Code;  f00e1c34 <receive_chars+244/298>
00000000 <_PC>:
Code;  f00e1c34 <receive_chars+244/298>
   0:   10 bf ff f0       b  ffffffc0 <_PC+0xffffffc0>
Code;  f00e1c38 <receive_chars+248/298>
   4:   84 10 20 02       mov  2, %g2
Code;  f00e1c3c <receive_chars+24c/298>
   8:   10 bf ff ef       b  ffffffc4 <_PC+0xffffffc4>
Code;  f00e1c40 <receive_chars+250/298>   <=3D=3D=3D=3D=3D
   c:   c0 28 40 00       clrb  [ %g1 ]   <=3D=3D=3D=3D=3D
Code;  f00e1c44 <receive_chars+254/298>
  10:   7f fc e5 2d       call  fff394c4 <_PC+0xfff394c4>
Code;  f00e1c48 <receive_chars+258/298>
  14:   81 e8 00 00       restore=20
Code;  f00e1c4c <receive_chars+25c/298>
  18:   7f ff ff 1b       call  fffffc84 <_PC+0xfffffc84>
Code;  f00e1c50 <receive_chars+260/298>
  1c:   81 e8 00 00       restore=20
Code;  f00e1c54 <receive_chars+264/298>
  20:   7f ff f9 ad       call  ffffe6d4 <_PC+0xffffe6d4>
Code;  f00e1c58 <receive_chars+268/298>
  24:   00 00 00 00       unimp  0

Kernel panic: Aiee, killing interrupt handler!

And that was that. Everything behaved fine once I rebooted, which leads
me to believe that there's a nasty race condition that got fired as the
getty was started on ttyS0.

*Completely* uninformed and most likely wrong postulation:
Could it be that do_serial_hangup() is getting called while a new
zs_open() is getting called, and the new tty is replaced with the
invalidated old one and bad things happen?

This is getting old, but..
Any ideas?

--=20
Joshua Kwan

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQamcGKOILr94RG8mAQJbbw/6A97/RjRGUk/AdxnlnehnwzcfAXpAafHV
1uDNHrXAZ+M+AtYUZFS5st6py2H+L0NRYhdhJ/e3mAV+O6CIURtz04MlwEi60wDB
i0nEbA9h4CeZ8aj3LATjnhMpfPdKddKRSlMiSK7qu14EK/+ocm7ogqXXI+Bto38h
t9qWX3ZQPpvV7MV751VDE84mSLg/NccfgUrOyaJmCcAosm9ZM/VEaj5CDy9zM071
mckGPfAOLoyh6ux3JH1FjrGjFxvm/+b80beZhVEpueH2HVjFhRX1WSEnVNcD23hi
RWQOVfRhVzavbd8bOEj4PE8ab/GS7rbEwIktB2hjeC5DhXh9TN7s5mCYxjNL42/6
Pji80si9ca0ub/qPdDsiwmFfEAf3hAf89xijyHkIYd3UZtMkhsGG7vz5VLnO0QYJ
VpvKP+H0jDLU8hcZybGEu8uBrbEiLADAAIac+1SOsu54cvPxOljxFnSgBunCPe2s
PWOVrXB/6tzefs5SjFvNgBV4Egm3LiWOS9ihR0ghOmw/N7cHMXTWcAIbEI+yR+TX
E32CZF3pFEwqQanfaM7sIm4wifYqgS2yiLN0xNmK/HzTHypm0qyoUC1BfEt6mg6M
mBLgTYJmLjB+nEAtx+GHohTfGPqGzDwZC2+WFP1d9NqN3f35+Ysh9obk+nIHDtZ8
lX14juCwdYI=
=X0h7
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
