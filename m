From: Willem de Groot <willem@byte.nl>
Date: Thu, 11 Mar 2004 11:23:32 +0000
Subject: fdisk geometry issue
Message-Id: <Pine.LNX.4.58.0403111203520.24764@passoa.internal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,

After 12 hours fiddling with disk geometry issues, I give up :)

I want to fdisk an IDE WD800JB drive for use with Linux in a Sun.
According to Western Digital, the geometry is [1]:

Cylinders 16383
Heads 16
Sectors/Track 63
Landing Zone 16383
WPC 16383

According to the Linux kernel (booted from Debian CD) the geometry is
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63,
UDMA(66)

If I try to create a Sun disklabel using the WDC paramters, I end up with
a disk that is too small:

Disk /dev/hda (Sun disk label): 16 heads, 63 sectors, 16383 cylinders
Units =3D cylinders of 1008 * 512 bytes
   Device Flag    Start       End    Blocks   Id  System
/dev/hda1             0     16282   8206128   83  Linux native
/dev/hda2  u      16282     16383     50904   82  Linux swap
/dev/hda3             0     16383   8257032    5  Whole disk

If I try to enter the linux kernel geometry, I get a "Value out of range"
error because it only accepts a maximum of 65535 cylinders (linux reports
155061).

So I followed the suggestion of a previous mail on this list [2], I use
the following figures:

cylinders: 155061 (=155061/3)
heads: 48 (16*3)

With these values, fdisk reports the correct disk size.

HOWEVER, after booting 2.4.25 from the newly partitioned disk, 'df' shows
a total disk size of about 2.2 petabytes! I didn't get any seeking errors
yet, but it does look a bit fragile to me :)

goldstrike:~# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1            2384623153927 16439106515 2247050084910   1% /

What am I doing wrong ?

Thanks!

Willem

[1] http://wdc.custhelp.com/cgi-bin/wdc.cfg/php/enduser/std_adp.php?p_sid=
=3DmyER*16h&p_lva=3D&p_faqidi9&p_created=1037217622&p_sp=CF9zcmNoPTEmcF9ncm=
lkc29ydD0mcF9yb3dfY250PTEmcF9zZWFyY2hfdGV4dD13ZDgwMGpiJnBfc2VhcmNoX3R5cGU9N=
CZwX2NhdF9sdmwxPTgyJnBfc29ydF9ieT1kZmx0JnBfcGFnZT0x&p_li[2] http://marc.the=
aimsgroup.com/?l=3Dlinux-sparc&m=103929302422468&w=3D2
