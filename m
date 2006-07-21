From: Raymond Burns <rayburns@comcast.net>
Date: Fri, 21 Jul 2006 21:30:05 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <Pine.LNX.4.10.10607211440110.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, 19 Jul 2006, David Miller wrote:

> > EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
> > #2: unaligned directory entry - offset=3D0, inode =83918864,
> > rec_lenB42, name_len=3D0
> >=20
> Looks like there is something wrong with ESP on your sun4d,
> that error should never occur on a good filesystem.
> I doubt anything is wrong with EXT2.
>=20

I enabled some of the esp debug facility, the only item that stands
out is:

esp_work_bus: esp_do_data_finale: trans_sz(4096), bytes_sent(4096),
!bogus_data, to new phase

It looks like !bogus_data occurs on all data requests

Is it a wild goose or something to check?

esp0: IRQ 44 SCSI ID 7 Clk 40MHz CCYC%000 CCF=3D8 TOut 167
NCR53C9XF(espfast)
esp0: FAST chip is fas236 (family=3D2, version=3D3)

drives are:
  Vendor: SEAGATE   Model: ST32550N SUN2.1G  Rev: 0416


Thanx
  Ray


