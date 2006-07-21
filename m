From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2006 21:39:46 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060721.143946.115918610.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Fri, 21 Jul 2006 15:00:18 -0700 (PDT)

> On Wed, 19 Jul 2006, David Miller wrote:
>=20
> > > EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
> > > #2: unaligned directory entry - offset=3D0, inode =83918864,
> > > rec_lenB42, name_len=3D0
> > >=20
> > Looks like there is something wrong with ESP on your sun4d,
> > that error should never occur on a good filesystem.
> > I doubt anything is wrong with EXT2.
> >=20
>=20
> I enabled some of the esp debug facility, the only item that stands
> out is:
>=20
> esp_work_bus: esp_do_data_finale: trans_sz(4096), bytes_sent(4096),
> !bogus_data, to new phase
>=20
> It looks like !bogus_data occurs on all data requests
>=20
> Is it a wild goose or something to check?

!bogus_data is a normal condition
