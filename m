From: Christian Joensson <christian@j-son.org>
Date: Wed, 12 May 2004 14:21:38 +0000
Subject: Re: 2.4.26 on UP sun4m: ksymoops for kernel NULL pointer dereference
Message-Id: <20040512162138.B11421@fw.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040511122855.A11421@fw.j-son.org>
In-Reply-To: <20040511122855.A11421@fw.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, May 12, 2004 at 07:17:42AM -0700, Keith M Wesolowski wrote:
> On Tue, May 11, 2004 at 12:28:55PM +0200, Christian Joensson wrote:
>=20
> > Instruction DUMP: 80a46000  0280001c  01000000 <d0044000> d2020000  80a=
24018  02800012  213f8c7b  a0142188=20
> >=20
> > >>PC;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <=3D=3D=
> > >>O7;  f0050a44 <filp_open+2c/54>
> > >>I7;  fe32d750 <[ext3].text.start+86f0/eb4f>
> > Trace; fe32d750 <[ext3].text.start+86f0/eb4f>
> > Trace; f006852c <__mark_inode_dirty+3c/ac>
>=20
> Unfortunately this trace looks bogus.  Specifically the actual pc
> value at time of exception isn't being correctly looked up.  Since
> it's in a module, you'll have to try manually looking it up in
> /proc/ksyms.  If it really is within the kstrtab, something has gone
> horribly wrong long before the MNA.

oh, well, can=E4t have it all all the time :)

>=20
> > Code;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <=3D=3D=
> >    c:   d0 04 40 00       ld  [ %l1 ], %o0   <=3D=3D>=20
> The instruction decode is ok, and consistent with the regs.  You might
> try looking for the instruction sequence in that module if ksyms isn't
> helpful.

i'll drop it for now, let me know if I can help, though. =20

Cheers,

/ChJ
