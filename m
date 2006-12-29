From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 29 Dec 2006 14:32:17 +0000
Subject: 2.6.18-1.2798.al3.1smp: SKB BUG: Invalid truesize (368)
Message-Id: <Pine.BSO.4.63.0612291523540.9165@rudy.mif.pg.gda.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-1505833140-1167402257=:9165"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1505833140-1167402257=:9165
Content-Type: TEXT/PLAIN; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-ID: <Pine.BSO.4.63.0612291524411.9165@rudy.mif.pg.gda.pl>


Hi,

I'm just reboot my system on 2.6.18-1.2798.al3 kernel from Aurora rpm=20
package and after this I observe many log messages (more than=20
few per second) from kernel level like:

SKB BUG: Invalid truesize (368) len=3D1448, sizeof(sk_buff)=3D240
SKB BUG: Invalid truesize (368) len=3D1448, sizeof(sk_buff)=3D240
SKB BUG: Invalid truesize (368) len=3D1448, sizeof(sk_buff)=3D240
SKB BUG: Invalid truesize (368) len=3D900, sizeof(sk_buff)=3D240

This system uses NFS (as client).

Hardware: E250 SMP

# lspci; lsmod
80:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Module
0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Mo=
dule
0001:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
0001:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l (rev 01)
0001:00:02.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0001:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev=
 14)
0001:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev=
 14)
0001:00:05.0 Display controller: 3DLabs Permedia II 2D+3D (rev 01)
0001:01:00.0 Ethernet controller: Sun Microsystems Computer Corp.: Unknown =
device abba (rev 01)
Module                  Size  Used by
nfsd                  252529  13
exportfs                9153  1 nfsd
nfs                   240913  5
lockd                  62833  3 nfsd,nfs
nfs_acl                 7553  2 nfsd,nfs
sunrpc                158321  11 nfsd,nfs,lockd,nfs_acl
ipv6                  283625  17
cassini                60885  0
openpromfs             10761  1
ext3                  143313  3
jbd                    61457  1 ext3
dm_snapshot            19513  0
dm_mod                 54625  1 dm_snapshot
raid1                  24833  8
sym53c8xx              80430  18
scsi_transport_spi     28417  1 sym53c8xx
sd_mod                 22697  84
scsi_mod              140169  3 sym53c8xx,scsi_transport_spi,sd_mod

From above NIC I',m using Sun Swift T1000 (cassini module).

kloczek
--=20
-----------------------------------------------------------
*Ludzie nie maj=B1 problem=F3w, tylko sobie sami je stwarzaj=B1*
-----------------------------------------------------------
Tomasz K=B3oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.p=
l*
--0-1505833140-1167402257=:9165--
