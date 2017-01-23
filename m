From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Mon, 23 Jan 2017 17:57:01 +0000
Subject: Re: Booting qla2x00_mailbox_command+0x8ac/0xec0
Message-Id: <20170123175700.c2tywixvcodigfmi@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1485045213.3904.4.camel@xs4all.nl>
 <20170123153814.pp4oec3ynssvzlly@oracle.com>
 <1485192462.8703.2.camel@xs4all.nl>
In-Reply-To: <1485192462.8703.2.camel@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Frans van Berckel <fberckel@xs4all.nl>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Scsi list <linux-scsi@vger.kernel.org>

* Frans van Berckel <fberckel@xs4all.nl> [170123 12:27]:
> Hi Liam,
>=20
> On Mon, 2017-01-23 at 10:38 -0500, Liam R. Howlett wrote:
>=20
> > < removed most of dmesg >
> >=20
> > > [=A0=A0=A064.557099] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EH=
CI)
> > > Driver
> > > [=A0=A0=A064.633786] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Chan=
nel
> > > HBA Driver: 8.07.00.38-k.
> > > [=A0=A0=A064.633966] PCI: Enabling device: (0001:00:04.0), cmd 3
> > > [=A0=A0=A064.634261] qla2xxx [0001:00:04.0]-001d: : Found an ISP2200 =
irq
> > > 20 iobase 0x000007fd00100000.
> > > [=A0=A0=A064.647517] sym0: No NVRAM, ID 7, Fast-20, SE, parity checki=
ng
> > > [=A0=A0=A064.652483] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI)
> > > Driver
> > > [=A0=A0=A064.655670] qla2xxx [0001:00:04.0]-0050:1: No matching ROM
> > > signature.
> >=20
> > Is this normal?
>=20
> Comparing with a old kernel that boots well. 3.16.0-0.bpo.4-sparc64-smp=20
> #1 SMP Debian 3.16.7-ckt25-2~bpo70+1 (2016-04-12).
>=20
> I am getting ... so that looks the same.
>=20
> [=A0=A0=A058.792508] qla2xxx [0001:00:04.0]-0050:0: No matching ROM
> signature.
>=20
> > > [=A0=A0=A064.656401] ehci-pci: EHCI PCI platform driver
> > > [=A0=A0=A064.657269] ohci-pci: OHCI PCI platform driver
> > > [=A0=A0=A064.664424] sym0: SCSI BUS has been reset.
> > > [=A0=A0=A064.667307] scsi host0: sym-2.2.3
> > > [=A0=A0=A064.679180] PCI: Enabling device: (0000:00:06.1), cmd 147
> > > [=A0=A0=A064.680362] sym1: <875> rev 0x37 at pci 0000:00:06.1 irq 17
> > > [=A0=A0=A064.713347] gem 0000:00:05.1 enp0s5f1: renamed from eth0
> > > [=A0=A0=A064.758542] qla2xxx [0001:00:04.0]-0064:1: Inconsistent NVRAM
> > > detected: checksum=3D0x0 id> > > [=A0=A0=A064.764091] qla2xxx [0001:0=
0:04.0]-0069:1: NVRAM configuration
> > > failed.
> >=20
> > Does this happen in the success case?
>=20
> Yes a success case, booted=A03.16.0 does.
>=20
> [=A0=A0=A058.895901] qla2xxx [0001:00:04.0]-0069:0: NVRAM configuration
> failed.
>=20
> [=A0=A0=A064.786902] qla2xxx 0001:00:04.0: firmware: direct-loading
> firmware ql2200_fw.bin
> > > [=A0=A0=A064.833101] sym1: No NVRAM, ID 7, Fast-20, SE, parity checki=
ng
> > > [=A0=A0=A064.843136] sym1: SCSI BUS has been reset.
> > > [=A0=A0=A064.845936] scsi host2: sym-2.2.3
>=20
> Witch does, nicely ...
>=20
> [=A0=A0=A058.886906] qla2xxx [0001:00:04.0]-0064:0: Inconsistent NVRAM
> detected: checksum=3D0x0 id> [=A0=A0=A058.889233] PCI: Enabling device: (=
0000:00:06.0), cmd 147
> [=A0=A0=A058.889959] qla2xxx [0001:00:04.0]-0065:0: Falling back to
> functioning (yet invalid -- WWPN) defaults.
> [=A0=A0=A058.890409] sym0: <875> rev 0x37 at pci 0000:00:06.0 irq 16
> [=A0=A0=A058.895901] qla2xxx [0001:00:04.0]-0069:0: NVRAM configuration
> failed.
> [=A0=A0=A058.911709] qla2xxx 0001:00:04.0: firmware: direct-loading firmw=
are
> ql2200_fw.bin
> [=A0=A0=A058.985621] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
> [=A0=A0=A058.995808] sym0: SCSI BUS has been reset.
>=20
> <snap> and some later on ...
>=20
> [=A0=A0=A069.700087] qla2xxx [0001:00:04.0]-00fb:0: QLogic QLA22xx - .
> [=A0=A0=A069.703176] qla2xxx [0001:00:04.0]-00fc:0: ISP2200: PCI (66 MHz)=
 @
> 0001:00:04.0 hdma- host#=3D0 fw=3D2.02.08 TP.
> [=A0=A0=A070.244468] scsi 0:0:0:0: Direct-
> Access=A0=A0=A0=A0=A0SEAGATE=A0=A0ST373307FSUN72G=A0=A00207 PQ: 0 ANSI: 3
> [=A0=A0=A070.252898] scsi 0:0:1:0: Direct-Access=A0=A0=A0=A0=A0FUJITSU=A0=
=A0MAP3735F
> SUN72G=A0=A01201 PQ: 0 ANSI: 4
> [=A0=A0=A074.726434] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
> [=A0=A0=A074.729661] sd 0:0:1:0: [sdb] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
>=20
> > > [=A0=A0=A078.162677] ERROR(0): Cheetah error trap taken
> > > afsr[0000080000000000] afar[000007fd00100040] TL1(0)
> > > [=A0=A0=A078.165632] ERROR(0): TPC[101ade8c] TNPC[101ade90] O7[101ade=
80]
> > > TSTATE[9911001603]
> > > [=A0=A0=A078.168591] ERROR(0):=A0
> > > [=A0=A0=A078.168988] TPC<qla2x00_mailbox_command+0x8ac/0xec0 [qla2xxx=
]>
> > > [=A0=A0=A078.171864] ERROR(0): M_SYND(0),=A0=A0E_SYND(0)
> > > [=A0=A0=A078.174808] ERROR(0): Highest priority error (00000800000000=
00)
> > > "Bus error response from system bus"
> > > [=A0=A0=A078.177788] ERROR(0): D-cache idx[0] tag[0000000000000000]
> > > utag[0000000000000000] stag[0000000000000000]
> > > [=A0=A0=A078.180771] ERROR(0): D-cache data0[0000000000000000]
> > > data1[0000000000000000] data2[0000000000000000]
> > > data3[0000000000000000]
> > > [=A0=A0=A078.183808] ERROR(0): I-cache idx[0] tag[0000000000000000]
> > > utag[0000000000000000] stag[0000000000000000] u[0000000000000000]
> > > l[0000000000000000]
> > > [=A0=A0=A078.186839] ERROR(0): I-cache INSN0[0000000000000000]
> > > INSN1[0000000000000000] INSN2[0000000000000000]
> > > INSN3[0000000000000000]
> > > [=A0=A0=A078.189899] ERROR(0): I-cache INSN4[0000000000000000]
> > > INSN5[0000000000000000] INSN6[0000000000000000]
> > > INSN7[0000000000000000]
> > > [=A0=A0=A078.192971] ERROR(0): E-cache idx[100040] tag[00000000e48dc9=
20]
> > > [=A0=A0=A078.196010] ERROR(0): E-cache data0[0000000000000000]
> > > data1[0000000000000000] data2[0000000000000000]
> > > data3[0000000000000000]
> > > [=A0=A0=A078.199157] Kernel panic - not syncing: Irrecoverable deferr=
ed
> > > error trap.
> > > [=A0=A0=A078.199157]=A0
> > > [=A0=A0=A078.205490] CPU: 0 PID: 80 Comm: systemd-udevd Not tainted
> > > 4.9.0-1-sparc64-smp #1 Debian 4.9.2-2
> > > [=A0=A0=A078.208768] Call Trace:
> > > [=A0=A0=A078.212074]=A0=A0[000000000056b7a8] panic+0xe8/0x298
> > > [=A0=A0=A078.215400]=A0=A0[0000000000429b8c]
> > > cheetah_deferred_handler+0x1ec/0x460
> > > [=A0=A0=A078.218727]=A0=A0[0000000000405e44] c_deferred+0x18/0x24
> > > [=A0=A0=A078.222092]=A0=A0[00000000101ade8c]
> > > qla2x00_mailbox_command+0x8ac/0xec0 [qla2xxx]
> > > [=A0=A0=A078.225391]=A0=A0[00000000101b04e8] qla2x00_init_firmware+0x=
e8/0x1e0
> > > [qla2xxx]
> > > [=A0=A0=A078.228692]=A0=A0[00000000101a53ec] qla2x00_init_rings+0x3ac=
/0x400
> > > [qla2xxx]
> > > [=A0=A0=A078.231985]=A0=A0[00000000101ac410]
> > > qla2x00_initialize_adapter+0x470/0x6e0 [qla2xxx]
> > > [=A0=A0=A078.235306]=A0=A0[000000001019e870] qla2x00_probe_one+0xff0/=
0x29a0
> > > [qla2xxx]
> > > [=A0=A0=A078.238540]=A0=A0[0000000000766d60] pci_device_probe+0x80/0x=
100
> > > [=A0=A0=A078.241858]=A0=A0[00000000007e6480] driver_probe_device+0x18=
0/0x420
> > > [=A0=A0=A078.245132]=A0=A0[00000000007e6820] __driver_attach+0x100/0x=
120
> > > [=A0=A0=A078.248395]=A0=A0[00000000007e3e9c] bus_for_each_dev+0x5c/0x=
a0
> > > [=A0=A0=A078.251625]=A0=A0[00000000007e5b7c] driver_attach+0x1c/0x40
> > > [=A0=A0=A078.254818]=A0=A0[00000000007e5564] bus_add_driver+0x164/0x2=
a0
> > > [=A0=A0=A078.258016]=A0=A0[00000000007e7314] driver_register+0x74/0x1=
20
> > > [=A0=A0=A078.261209]=A0=A0[0000000000765638] __pci_register_driver+0x=
38/0x60
> > > [=A0=A0=A078.264419] Press Stop-A (L1-A) to return to the boot prom
> > > [=A0=A0=A078.267612] ---[ end Kernel panic - not syncing: Irrecoverab=
le
> > > deferred error trap.
> > > [=A0=A0=A078.267612]=A0
> > > [=A0=A0291.373806] random: crng init done
> >=20
> > I am not familiar with cheetah or the qla2xxx card, but it looks like
> > qla2x00_mailbox_command is accessing the PCI bus which is not mapped.
> > Have a look at trap_64 in cheetah_deferred_handler.=A0There is a
> > pci_poke_faulted variable that is used to flag these errors and to
> > skip the instruction.=A0From a quick look at the driver, this shouldn't
> > be happening.=A0The PCI space should be configured first.=A0I would
> > enable ql_dbg output to see more of what is going on.=A0Perhaps one of
> > the messages above indicate an issue and the return value isn't being
> > validated correctly?=A0=A0Or perhaps the error path assumes it is safe =
to
> > access the PCI bus when it's not safe?
>=20
> If someone could dig into trap_64 in cheetah_deferred_handler? I am
> able to install=A0the dbgsym of the linux-image package and set debug on.

Just a small correction to my original email.  The error may not have to
do with the mmapping.  The UltraSPARC-III user's manual specifies this
error (bus error) should still be recoverable when using the peek/poke
that I pointed out but it also specifies an Unmapped error.



>=20
> That will be in the next e-mail if it does what we are looking for.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
