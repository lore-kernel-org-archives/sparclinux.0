From: lists@naasa.net
Date: Sun, 28 Mar 2004 19:53:19 +0000
Subject: srmmu: out of nocache
Message-Id: <200403282153.19509.lists@naasa.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

I have an old SS5 with 128 MB memory. Sometimes, the kernel seems to have s=
ome=20
memory problems:
Mar 24 07:03:05 ferdi kernel: bitmap out: size 8800 used 6242 off 1248 len =
16=20
align 16 count 8816
Mar 24 07:03:05 ferdi kernel: srmmu: out of nocache 4096: 2252800/1597952
Mar 24 07:03:05 ferdi kernel: VM: killing process sendmail

Here is an actual memory overview:=20

ferdi:~# cat /proc/meminfo
MemTotal:       125256 kB
MemFree:          6744 kB
Buffers:         17836 kB
Cached:          51156 kB
SwapCached:      13556 kB
Active:          73420 kB
Inactive:        33572 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125256 kB
LowFree:          6744 kB
SwapTotal:      249652 kB
SwapFree:       228840 kB
Dirty:             188 kB
Writeback:           0 kB
Mapped:          40640 kB
Slab:             7736 kB
Committed_AS:   141536 kB
PageTables:        856 kB
VmallocTotal:    25600 kB
VmallocUsed:       500 kB
VmallocChunk:    25060 kB

These problems are reproducible under high load (e. g. updating spamassassi=
ns=20
bayes-database while receiving a lot of mails). What can I do to fix this=20
behaviour? Are 128 MB memory not enough? My x86-bases systems have no=20
problems with less memory...

regards,
J=F6rg

--=20
Hi! I'm a .signature virus! Copy me into your signature to help me spread!.=
-.
PGP Key: send mail with subject 'SEND PGP-KEY' PGP Key-ID: FD 4E 21 1D    o=
o|
PGP Fingerprint: 388A872AFC5649D3 BCEC65778BE0C605                  _ // /`=
'\
I am Ohm of Borg. Resistance is voltage divided by current.         \X/ (\_=
;/)
