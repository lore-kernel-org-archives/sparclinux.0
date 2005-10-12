From: Meelis Roos <mroos@linux.ee>
Date: Wed, 12 Oct 2005 09:28:17 +0000
Subject: Still some serial console corruption on sunsab
Message-Id: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-559023410-1932422408-1129109297=:29862"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1932422408-1129109297=:29862
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

This U5 booting with serial console @ 9600,8,n,1

su0 at 0x000001fff13062f8 (irq =3D 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq =3D 9,7e9) is a 16550A
Console: ttyS0 (SAB82532)
ttyS0 at MMIO 0x1fff1400000 (irq =3D 7309792) is a SAB82532 V3.2
ttyS1 at MMIO 0x1fff1400040 (irq =3D 7309792) is a SAB82532 V3.2
[...]
Failed to mount /selinux/: No such file or directory
..=C9.=A5=BD..2.86 booting
Starting the hotplug events dispatcher: udevd.

No more corruption on startup. But there is more on shart of shutdown=20
(the first line is the end of startup):

Starting K Display Manager: kdm.
M.=A5=D1.=A1=A5...to runlevel: 6
..=A5...processes the TERM signal

Is this known to corrupt sometimes or is it thought to be fixed?
I'm running todays 2.6.14-rc4-gda64c6ee.

--=20
Meelis Roos (mroos@linux.ee)
---559023410-1932422408-1129109297=:29862--
