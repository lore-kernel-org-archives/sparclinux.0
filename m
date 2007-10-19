From: "Ross S. W. Walker" <rwalker@medallion.com>
Date: Fri, 19 Oct 2007 21:08:25 +0000
Subject: RE: [Iscsitarget-devel] [BUG] Raid1/5 over iSCSI trouble
Message-Id: <E2BB8074E5500C42984D980D4BD78EF9017A2970@MFG-NYC-EXCH2.mfg.prv>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr>
	<47161CE3.80909@systella.fr>	<e9c3a7c20710170758p4046ca44labe370e94bca6e93@mail.gmail.com>	<e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>	<47181CB2.1060602@tmr.com>
	<471864F8.9010209@systella.fr><1192809103.30976.11.camel@dwillia2-linux.ch.intel.com><4718DE66.8000905@tmr.com>
	<471916B5.6080709@systella.fr><47191855.4020402@systella.fr>
	<47191BCF.2000908@systella.fr>
In-Reply-To: <47191BCF.2000908@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>, Bill Davidsen <davidsen@tmr.com>
Cc: linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, iscsitarget-devel@lists.sourceforge.net

BERTRAND Jo=EBl wrote:
>=20
> BERTRAND Jo=EBl wrote:
> > BERTRAND Jo=EBl wrote:
> >> Bill Davidsen wrote:
> >>> Dan Williams wrote:
> >>>> On Fri, 2007-10-19 at 01:04 -0700, BERTRAND Jo=EBl wrote:
> >>>> =20
> >>>>>         I run for 12 hours some dd's (read and write in nullio)
> >>>>> between
> >>>>> initiator and target without any disconnection. Thus=20
> iSCSI code seems
> >>>>> to
> >>>>> be robust. Both initiator and target are alone on a=20
> single gigabit
> >>>>> ethernet link (without any switch). I'm investigating...
> >>>>>    =20
> >>>>
> >>>> Can you reproduce on 2.6.22?
> >>>>
> >>>> Also, I do not think this is the cause of your failure,=20
> but you have
> >>>> CONFIG_DMA_ENGINE=3Dy in your config.  Setting this to 'n'=20
> will compile
> >>>> out the unneeded checks for offload engines in async_memcpy and
> >>>> async_xor.
> >>>
> >>> Given that offload engines are far less tested code, I=20
> think this is=20
> >>> a very good thing to try!
> >>
> >>     I'm trying wihtout CONFIG_DMA_ENGINE=3Dy. istd1 only=20
> uses 40% of one=20
> >> CPU when I rebuild my raid1 array. 1% of this array was now=20
> >> resynchronized without any hang.
> >>
> >> Root gershwin:[/usr/scripts] > cat /proc/mdstat
> >> Personalities : [raid1] [raid6] [raid5] [raid4]
> >> md7 : active raid1 sdi1[2] md_d0p1[0]
> >>       1464725632 blocks [2/1] [U_]
> >>       [>....................]  recovery =3D  1.0%=20
> (15705536/1464725632)=20
> >> finish=1103.9min speed!875K/sec
> >=20
> >     Same result...
> >=20
> > connection2:0: iscsi: detected conn error (1011)
> >=20
> >          session2: iscsi: session recovery timed out after 120 secs
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> > sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
>=20
> 	Sorry for this last mail. I have found another mistake,=20
> but I don't=20
> know if this bug comes from iscsi-target or raid5 itself.=20
> iSCSI target=20
> is disconnected because istd1 and md_d0_raid5 kernel threads=20
> use 100% of=20
> CPU each !
>=20
> Tasks: 235 total,   6 running, 227 sleeping,   0 stopped,   2 zombie
> Cpu(s):  0.1%us, 12.5%sy,  0.0%ni, 87.4%id,  0.0%wa,  0.0%hi,=20
>  0.0%si,=20
> 0.0%st
> Mem:   4139032k total,   218424k used,  3920608k free,   =20
> 10136k buffers
> Swap:  7815536k total,        0k used,  7815536k free,   =20
> 64808k cached
>=20
>    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND=20
>=20
>   5824 root      15  -5     0    0    0 R  100  0.0  10:34.25 istd1=20
>=20
>   5599 root      15  -5     0    0    0 R  100  0.0   7:25.43=20
> md_d0_raid5
>=20
> 	Regards,
>=20
> 	JKB

If you have 2 iSCSI sessions mirrored then any failure along either
path will hose the setup. Plus having iSCSI and MD RAID fight over
same resources in kernel is a recipe for a race condition.

How about exploring MPIO and DRBD?

-Ross

______________________________________________________________________
This e-mail, and any attachments thereto, is intended only for use by
the addressee(s) named herein and may contain legally privileged
and/or confidential information. If you are not the intended recipient
of this e-mail, you are hereby notified that any dissemination,
distribution or copying of this e-mail, and any attachments thereto,
is strictly prohibited. If you have received this e-mail in error,
please immediately notify the sender and permanently delete the
original and any copy or printout thereof.

