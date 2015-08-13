From: Meelis Roos <mroos@linux.ee>
Date: Thu, 13 Aug 2015 12:23:58 +0000
Subject: Re: bisected: boot hang on sparc64 after PCIe changes
Message-Id: <alpine.LRH.2.20.1508131457130.11532@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> In commit d0751b98dfa391f862e02dc36a233a54615e3f1d "PCI: Add dev->has_sec=
ondary_link to track downstream PCIe links"
> we assumed the first pcie bridge type is root port, I attached a fix patc=
h which try to avoid a potential NULL pointer,
> could you help to test it ?

Tested on V245, boots fine with this patch on top of=20
d0751b98dfa391f862e02dc36a233a54615e3f1d and on top of current git.

However, there is now nothing under /sys/bus/pci/slots but there were=20
entries for PCI-E slots before (in 4.1.0).

> Thanks!
> Yijing.
>=20
>=20
> =1B$B:_=1B(J 2015/8/13 16:15, Meelis Roos =1B$B<LF;=1B(J:
> >> Hi Meelis, could you provide your PCI info on your machine ?
> >>
> >> lspci -vvv and lspci -tv could help us to find it out.
> >=20
> > lspci -vvv:
> >=20
> > 0000:02:00.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: Memory at 00100000 (32-bit, non-prefetchable) [size=128K]
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=02, secondary=03, subordinate
, sec-latency=3D0
> > 	I/O behind bridge: 00000000-00002fff
> > 	Memory behind bridge: 00200000-04ffffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Upstream Port, MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 0.000W
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L=
0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending- InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:03:01.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=03, secondary=04, subordinate=05, sec-latency=3D0
> > 	I/O behind bridge: 00000000-00001fff
> > 	Memory behind bridge: 00200000-03ffffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending- InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:03:02.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=03, secondary=06, subordinate=06, sec-latency=3D0
> > 	I/O behind bridge: 00002000-00001fff
> > 	Memory behind bridge: fff00000-000fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > 			Slot #226, PowerLimit 25.000W; Interlock- NoCompl-
> > 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> > 			Control: AttnInd Off, PwrInd On, Power- Interlock-
> > 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> > 			Changed: MRL- PresDet- LinkState-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending+ InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:03:08.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=03, secondary=07, subordinate=07, sec-latency=3D0
> > 	I/O behind bridge: 00002000-00001fff
> > 	Memory behind bridge: fff00000-000fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L=
0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > 			Slot #224, PowerLimit 25.000W; Interlock- NoCompl-
> > 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> > 			Control: AttnInd Off, PwrInd On, Power- Interlock-
> > 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> > 			Changed: MRL- PresDet- LinkState-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending+ InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:03:09.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=03, secondary=08, subordinate
, sec-latency=3D0
> > 	I/O behind bridge: 00002000-00001fff
> > 	Memory behind bridge: 04000000-045fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #9, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending- InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:03:0a.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI E=
xpress Switch (rev ba) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=03, secondary=0B, subordinate
, sec-latency=3D0
> > 	I/O behind bridge: 00002000-00002fff
> > 	Memory behind bridge: 04600000-04ffffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 1
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #10, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency =
L0s <512ns, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
> > 	Capabilities: [fb4 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
> > 	Capabilities: [138 v1] Power Budgeting <?>
> > 	Capabilities: [148 v1] Virtual Channel
> > 		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
> > 		Arb:	Fixed+ WRR32+ WRR64- WRR128-
> > 		Ctrl:	ArbSelect=3DFixed
> > 		Status:	InProgress+
> > 		Port Arbitration Table [1b8] <?>
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
> > 			Status:	NegoPending- InProgress-
> > 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
> > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
> > 			Status:	NegoPending- InProgress-
> >=20
> > 0000:04:00.0 PCI bridge: ULi Electronics Inc. M5249 HTT to PCI Bridge (=
prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=04, secondary=05, subordinate=05, sec-latency=3D0
> > 	I/O behind bridge: 00001000-00001fff
> > 	Memory behind bridge: 00200000-03ffffff
> > 	Prefetchable memory behind bridge: fff00000-000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [90] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [98] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> > 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <2us, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> >=20
> > 0000:05:1c.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (r=
ev 03) (prog-if 10 [OHCI])
> > 	Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (20000ns max), Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 5
> > 	Region 0: Memory at 01000000 (32-bit, non-prefetchable) [size=16M]
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 2: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 3: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [60] Power Management version 2
> > 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> > 		Address: 00000000  Data: 0000
> > 	Kernel driver in use: ohci-pci
> >=20
> > 0000:05:1c.1 USB controller: ULi Electronics Inc. USB 1.1 Controller (r=
ev 03) (prog-if 10 [OHCI])
> > 	Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (20000ns max), Cache Line Size: 64 bytes
> > 	Interrupt: pin B routed to IRQ 5
> > 	Region 0: Memory at 02000000 (32-bit, non-prefetchable) [size=16M]
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 2: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 3: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [60] Power Management version 2
> > 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME+
> > 	Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> > 		Address: 00000000  Data: 0000
> > 	Kernel driver in use: ohci-pci
> >=20
> > 0000:05:1c.3 USB controller: ULi Electronics Inc. USB 2.0 Controller (r=
ev 01) (prog-if 20 [EHCI])
> > 	Subsystem: ULi Electronics Inc. Device 5238
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
> > 	Interrupt: pin D routed to IRQ 6
> > 	Region 0: Memory at 00200000 (32-bit, non-prefetchable) [size=3D8K]
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 2: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 3: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [50] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [58] Debug port: BAR=3D1 offset=0090
> > 	Capabilities: [78] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> > 		Address: 00000000  Data: 0000
> > 	Kernel driver in use: ehci-pci
> >=20
> > 0000:05:1e.0 ISA bridge: ULi Electronics Inc. M1575 South Bridge
> > 	Subsystem: ULi Electronics Inc. M1575 South Bridge
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (250ns min, 6000ns max)
> > 	Region 0: [virtual] I/O ports at 0000 [size=3D4K]
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 2: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 3: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> >=20
> > 0000:05:1f.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c8) (pr=
og-if 8f [Master SecP SecO PriP PriO])
> > 	Subsystem: ULi Electronics Inc. M5229 IDE
> > 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64, Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 7
> > 	Region 0: I/O ports at 1040 [sized]
> > 	Region 1: I/O ports at 1080 [sized]
> > 	Region 2: I/O ports at 10c0 [sized]
> > 	Region 3: I/O ports at 1100 [sized]
> > 	Region 4: I/O ports at 1000 [sized]
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [60] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> > 		Address: 00000000  Data: 0000
> > 	Kernel driver in use: pata_ali
> >=20
> > 0000:08:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev =
b5) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=08, secondary	, subordinate
, sec-latencyd
> > 	I/O behind bridge: 00002000-00001fff
> > 	Memory behind bridge: 04000000-045fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > 			ExtTag+ AttnBtn+ AttnInd+ PwrInd+ RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <4us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [90] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
> > 		Status: Dev=08:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
> > 		Upstream: Capacity=3D0 CommitmentLimit=3D0
> > 		Downstream: Capacity=3D0 CommitmentLimit=3D0
> > 	Capabilities: [b0] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [100 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> > 	Capabilities: [14c v1] Power Budgeting <?>
> >=20
> > 0000:09:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM571=
4 Gigabit Ethernet (rev a3)
> > 	Subsystem: Oracle/SUN Device 1668
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 91
> > 	Region 0: Memory at 04200000 (64-bit, non-prefetchable) [size=3D2M]
> > 	Region 2: Memory at 04010000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Expansion ROM at 04020000 [disabled] [sizedK]
> > 	Capabilities: [40] PCI-X non-bridge device
> > 		Command: DPERE- ERO- RBCQ2 OST=3D1
> > 		Status: Dev	:04.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DMOS=
T=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
> > 	Capabilities: [48] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
> > 	Capabilities: [50] Vital Product Data
> > 		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
> > 		Read-only fields:
> > 			[PN] Part number: BCM95714
> > 			[EC] Engineering changes: 106679-15
> > 			[SN] Serial number: 0123456789
> > 			[MN] Manufacture ID: 31 34 65 34
> > 			[RV] Reserved: checksum bad, 28 byte(s) reserved
> > 		Read/write fields:
> > 			[YA] Asset tag: XYZ01234567
> > 			[RW] Read-write area: 107 byte(s) free
> > 		End
> > 	Capabilities: [58] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
> > 		Address: 00000003ffff0000  Data: 0000
> > 	Kernel driver in use: tg3
> >=20
> > 0000:09:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM571=
4 Gigabit Ethernet (rev a3)
> > 	Subsystem: Oracle/SUN Device 1668
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
> > 	Interrupt: pin B routed to IRQ 8
> > 	Region 0: Memory at 04400000 (64-bit, non-prefetchable) [size=3D2M]
> > 	Region 2: Memory at 04030000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [40] PCI-X non-bridge device
> > 		Command: DPERE- ERO+ RBCQ2 OST=3D1
> > 		Status: Dev	:04.1 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DMOS=
T=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
> > 	Capabilities: [48] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
> > 	Capabilities: [50] Vital Product Data
> > 		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
> > 		Read-only fields:
> > 			[PN] Part number: BCM95714
> > 			[EC] Engineering changes: 106679-15
> > 			[SN] Serial number: 0123456789
> > 			[MN] Manufacture ID: 31 34 65 34
> > 			[RV] Reserved: checksum bad, 28 byte(s) reserved
> > 		Read/write fields:
> > 			[YA] Asset tag: XYZ01234567
> > 			[RW] Read-write area: 107 byte(s) free
> > 		End
> > 	Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
> > 		Address: 932c4922702691c0  Data: 15db
> > 	Kernel driver in use: tg3
> >=20
> > 0000:09:08.0 PCI bridge: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge (re=
v b4) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary	, secondary
, subordinate
, sec-latencyd
> > 	I/O behind bridge: 00002000-00001fff
> > 	Memory behind bridge: fff00000-000fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [90] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=3Dconv
> > 		Status: Dev	:08.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
> > 		Upstream: Capacity=3D8 CommitmentLimit=3D8
> > 		Downstream: Capacity=3D8 CommitmentLimit=3D8
> >=20
> > 0000:0b:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev =
b5) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=0B, secondary=0C, subordinate
, sec-latencyd
> > 	I/O behind bridge: 00002000-00002fff
> > 	Memory behind bridge: 04600000-04ffffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > 			ExtTag+ AttnBtn+ AttnInd+ PwrInd+ RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <4us
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [90] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
> > 		Status: Dev=0B:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
> > 		Upstream: Capacity=3D0 CommitmentLimit=3D0
> > 		Downstream: Capacity=3D0 CommitmentLimit=3D0
> > 	Capabilities: [b0] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [100 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 04, GenCap- CGenEn- ChkCap- ChkEn-
> > 	Capabilities: [14c v1] Power Budgeting <?>
> >=20
> > 0000:0c:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM571=
4 Gigabit Ethernet (rev a3)
> > 	Subsystem: Oracle/SUN Device 1668
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 8
> > 	Region 0: Memory at 04800000 (64-bit, non-prefetchable) [size=3D2M]
> > 	Region 2: Memory at 04610000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Expansion ROM at 04620000 [disabled] [sizedK]
> > 	Capabilities: [40] PCI-X non-bridge device
> > 		Command: DPERE- ERO+ RBCQ2 OST=3D1
> > 		Status: Dev=0C:04.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DM=
OST=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
> > 	Capabilities: [48] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
> > 	Capabilities: [50] Vital Product Data
> > 		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
> > 		Read-only fields:
> > 			[PN] Part number: BCM95714
> > 			[EC] Engineering changes: 106679-15
> > 			[SN] Serial number: 0123456789
> > 			[MN] Manufacture ID: 31 34 65 34
> > 			[RV] Reserved: checksum bad, 28 byte(s) reserved
> > 		Read/write fields:
> > 			[YA] Asset tag: XYZ01234567
> > 			[RW] Read-write area: 107 byte(s) free
> > 		End
> > 	Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
> > 		Address: f7b9f7ebfbbbffa8  Data: fc80
> > 	Kernel driver in use: tg3
> >=20
> > 0000:0c:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM571=
4 Gigabit Ethernet (rev a3)
> > 	Subsystem: Oracle/SUN Device 1668
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
> > 	Interrupt: pin B routed to IRQ 9
> > 	Region 0: Memory at 04a00000 (64-bit, non-prefetchable) [size=3D2M]
> > 	Region 2: Memory at 04630000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 4: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	Capabilities: [40] PCI-X non-bridge device
> > 		Command: DPERE- ERO+ RBCQ2 OST=3D1
> > 		Status: Dev=0C:04.1 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DM=
OST=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
> > 	Capabilities: [48] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
> > 	Capabilities: [50] Vital Product Data
> > 		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
> > 		Read-only fields:
> > 			[PN] Part number: BCM95714
> > 			[EC] Engineering changes: 106679-15
> > 			[SN] Serial number: 0123456789
> > 			[MN] Manufacture ID: 31 34 65 34
> > 			[RV] Reserved: checksum bad, 28 byte(s) reserved
> > 		Read/write fields:
> > 			[YA] Asset tag: XYZ01234567
> > 			[RW] Read-write area: 107 byte(s) free
> > 		End
> > 	Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
> > 		Address: ffec4e39bb357b78  Data: e4ef
> > 	Kernel driver in use: tg3
> >=20
> > 0000:0c:08.0 PCI bridge: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge (re=
v b4) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 64, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=0C, secondary
, subordinate
, sec-latencyd
> > 	I/O behind bridge: 00002000-00002fff
> > 	Memory behind bridge: 04c00000-04ffffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80700000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [90] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=3Dconv
> > 		Status: Dev=0C:08.0 64bit+ 133MHz+ SCD- USC- SCO+ SRD-
> > 		Upstream: Capacity=3D8 CommitmentLimit=3D8
> > 		Downstream: Capacity=3D8 CommitmentLimit=3D8
> >=20
> > 0000:0d:01.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1064=
 PCI-X Fusion-MPT SAS (rev 02)
> > 	Subsystem: LSI Logic / Symbios Logic Device 3020
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 248 (16000ns min, 2500ns max), Cache Line Size: 512 bytes
> > 	Interrupt: pin A routed to IRQ 10
> > 	Region 0: I/O ports at 2000 [disabled] [size%6]
> > 	Region 1: Memory at 04c00000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 3: Memory at 04c10000 (64-bit, non-prefetchable) [sizedK]
> > 	Region 5: [virtual] Memory at fffff80700000000 (32-bit, non-prefetchab=
le)
> > 	Expansion ROM at 04e00000 [disabled] [size=3D2M]
> > 	Capabilities: [50] Power Management version 2
> > 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [98] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [68] PCI-X non-bridge device
> > 		Command: DPERE- ERO- RBCQ2 OST=16
> > 		Status: Dev
:01.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DMOST=16 DMCRS=128 RSC=
EM- 266MHz- 533MHz-
> > 	Kernel driver in use: mptsas
> >=20
> > 0001:02:00.0 PCI bridge: Intel Corporation 41210 [Lanai] Serial to Para=
llel PCI Bridge (A-Segment Bridge) (rev 09) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=02, secondary=03, subordinate=03, sec-latencyd
> > 	I/O behind bridge: 00000000-00000fff
> > 	Memory behind bridge: 00100000-001fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80900000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [44] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> > 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> > 		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Exit Latency L0s =
unlimited, L1 unlimited
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [6c] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [d8] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
> > 		Status: Dev=02:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
> > 		Upstream: Capacitye535 CommitmentLimite535
> > 		Downstream: Capacitye535 CommitmentLimite535
> > 	Capabilities: [100 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq+ ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
> > 	Capabilities: [300 v1] Power Budgeting <?>
> >=20
> > 0001:02:00.2 PCI bridge: Intel Corporation 41210 [Lanai] Serial to Para=
llel PCI Bridge (B-Segment Bridge) (rev 09) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Region 0: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Region 1: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Bus: primary=02, secondary=04, subordinate=04, sec-latencyd
> > 	I/O behind bridge: 00001000-00000fff
> > 	Memory behind bridge: fff00000-000fffff
> > 	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
> > 	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- <SERR- <PERR-
> > 	[virtual] Expansion ROM at fffff80900000000 [disabled]
> > 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [44] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> > 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> > 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> > 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> > 		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Exit Latency L0s =
unlimited, L1 unlimited
> > 			ClockPM- Surprise- LLActRep- BwNot-
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWM=
gmt- ABWMgmt-
> > 	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [6c] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [d8] PCI-X bridge device
> > 		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
> > 		Status: Dev=02:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
> > 		Upstream: Capacitye535 CommitmentLimite535
> > 		Downstream: Capacitye535 CommitmentLimite535
> > 	Capabilities: [100 v1] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq+ ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > 		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
> > 	Capabilities: [300 v1] Power Budgeting <?>
> >=20
> > 0001:03:02.0 Fibre Channel: QLogic Corp. ISP2312-based 2Gb Fibre Channe=
l to PCI-X HBA (rev 02)
> > 	Subsystem: Compaq Computer Corporation Device 0100
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ St=
epping- SERR+ FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 128 (16000ns min), Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 13
> > 	Region 0: I/O ports at 0000 [size%6]
> > 	Region 1: Memory at 00100000 (64-bit, non-prefetchable) [size=3D8K]
> > 	Region 3: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Region 4: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Region 5: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchab=
le)
> > 	Expansion ROM at 00120000 [disabled] [size=128K]
> > 	Capabilities: [44] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> > 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > 	Capabilities: [4c] PCI-X non-bridge device
> > 		Command: DPERE- ERO+ RBCQ2 OST=3D3
> > 		Status: Dev=03:02.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC@96 DM=
OST=3D3 DMCRS2 RSCEM- 266MHz- 533MHz-
> > 	Capabilities: [54] MSI: Enable- Count=3D1/8 Maskable- 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 	Capabilities: [64] CompactPCI hot-swap <?>
> > 	Kernel driver in use: qla2xxx
> >=20
> >=20
> >=20
> > lspci -vt
> >=20
> > -+-[0001:02]-+-00.0-[03]----02.0  QLogic Corp. ISP2312-based 2Gb Fibre =
Channel to PCI-X HBA
> >  |           \-00.2-[04]--
> >  +-[0000:02]---00.0-[03-0d]--+-01.0-[04-05]----00.0-[05]--+-1c.0  ULi E=
lectronics Inc. USB 1.1 Controller
> >  |                           |                            +-1c.1  ULi E=
lectronics Inc. USB 1.1 Controller
> >  |                           |                            +-1c.3  ULi E=
lectronics Inc. USB 2.0 Controller
> >  |                           |                            +-1e.0  ULi E=
lectronics Inc. M1575 South Bridge
> >  |                           |                            \-1f.0  ULi E=
lectronics Inc. M5229 IDE
> >  |                           +-02.0-[06]--
> >  |                           +-08.0-[07]--
> >  |                           +-09.0-[08-0a]----00.0-[09-0a]--+-04.0  Br=
oadcom Corporation NetXtreme BCM5714 Gigabit Ethernet
> >  |                           |                               +-04.1  Br=
oadcom Corporation NetXtreme BCM5714 Gigabit Ethernet
> >  |                           |                               \-08.0-[0a=
]--
> >  |                           \-0a.0-[0b-0d]----00.0-[0c-0d]--+-04.0  Br=
oadcom Corporation NetXtreme BCM5714 Gigabit Ethernet
> >  |                                                           +-04.1  Br=
oadcom Corporation NetXtreme BCM5714 Gigabit Ethernet
> >  |                                                           \-08.0-[0d=
]----01.0  LSI Logic / Symbios Logic SAS1064 PCI-X Fusion-MPT SAS
> >  \-[0000:00]-
> >=20
> > prtconf -pv:
> >=20
> > System Configuration:  Sun Microsystems  sun4u
> > Memory size: 4096 Megabytes
> > System Peripherals (PROM Nodes):
> >=20
> > Node 0xf002a25c
> >     .node:  f002a25c
> >     interrupt-map:  00000400.0fd30000.00000001.f006872c.0000003d.000004=
00.0fd20000.00000001.f006872c.0000003c
> >     interrupt-map-mask:  00000fff.0fff0000.00000003
> >     #interrupt-cells:  00000001
> >     banner-name: 'Sun Fire V245'
> >     model: 'SUNW,375-3464'
> >     idprom:  01840014.4f720e2e.00000000.720e2ede.f1010a00.00000000.0000=
0000.000000fa
> >     scsi-initiator-id:  00000007
> >     name: 'SUNW,Sun-Fire-V245'
> >     stick-frequency:  01312d00
> >     clock-frequency:  0b34a700
> >     breakpoint-trap:  0000007f
> >     #size-cells:  00000002
> >     device_type: 'jbus'
> >=20
> >     Node 0xf002d444
> >         .node:  f002d444
> >         name: 'packages'
> >=20
> >         Node 0xf0049e30
> >             .node:  f0049e30
> >             name: 'SUNW,builtin-drivers'
> >=20
> >         Node 0xf005a350
> >             .node:  f005a350
> >             lba64: =20
> >             disk-write-fix: =20
> >             name: 'deblocker'
> >=20
> >         Node 0xf005aa4c
> >             .node:  f005aa4c
> >             name: 'disk-label'
> >=20
> >         Node 0xf005b3a8
> >             .node:  f005b3a8
> >             iso6429-1983-colors: =20
> >             name: 'terminal-emulator'
> >=20
> >         Node 0xf00630c8
> >             .node:  f00630c8
> >             source: '/flashprom:'
> >             name: 'dropins'
> >=20
> >         Node 0xf007b1a4
> >             .node:  f007b1a4
> >             name: 'kbd-translator'
> >=20
> >         Node 0xf007c4b8
> >             .node:  f007c4b8
> >             name: 'obp-tftp'
> >=20
> >         Node 0xf008be5c
> >             .node:  f008be5c
> >             name: 'SUNW,i2c-ram-device'
> >=20
> >         Node 0xf008c6a0
> >             .node:  f008c6a0
> >             name: 'SUNW,fru-device'
> >=20
> >         Node 0xf008cea8
> >             .node:  f008cea8
> >             maximum-reason-length:  000000fa
> >             name: 'SUNW,asr'
> >=20
> >     Node 0xf002d4bc
> >         .node:  f002d4bc
> >         bootargs:  00
> >         bootpath: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0=
,0:a'
> >         mmu:  fff74080
> >         memory:  fff74290
> >         stdout:  fefffb00
> >         stdin:  fefffd90
> >         stdout-#lines:  ffffffff
> >         name: 'chosen'
> >=20
> >     Node 0xf002d530
> >         .node:  f002d530
> >         version: 'OBP 4.30.4 2009/08/19 07:18'
> >         model: 'SUNW,4.30.4'
> >         aligned-allocator: =20
> >         relative-addressing: =20
> >         name: 'openprom'
> >=20
> >         Node 0xf002d5c0
> >             .node:  f002d5c0
> >             name: 'client-services'
> >=20
> >     Node 0xf002d678
> >         .node:  f002d678
> >         asr-policy: 'normal'
> >         keyboard-layout: 'US-English'
> >         test-args: =20
> >         diag-passes: '1'
> >         local-mac-address?: 'true'
> >         fcode-debug?: 'false'
> >         scsi-initiator-id: '7'
> >         oem-logo: =20
> >         oem-logo?: 'false'
> >         oem-banner: 'Ehh ei tea'
> >         oem-banner?: 'false'
> >         ansi-terminal?: 'true'
> >         screen-#columns: '80'
> >         screen-#rows: '34'
> >         ttyb-rts-dtr-off: 'false'
> >         ttyb-ignore-cd: 'true'
> >         ttya-rts-dtr-off: 'false'
> >         ttya-ignore-cd: 'true'
> >         ttyb-mode: '9600,8,n,1,-'
> >         ttya-mode: '9600,8,n,1,-'
> >         output-device: 'screen'
> >         input-device: 'keyboard'
> >         auto-boot-on-error?: 'true'
> >         error-reset-recovery: 'sync'
> >         load-base: '16384'
> >         auto-boot?: 'true'
> >         network-boot-arguments: =20
> >         boot-command: 'boot'
> >         diag-file: =20
> >         diag-device: 'net'
> >         boot-file: =20
> >         boot-device: 'disk net'
> >         use-nvramrc?: 'false'
> >         nvramrc: =20
> >         security-mode: 'none'
> >         security-password: =20
> >         security-#badlogins: '0'
> >         verbosity: 'normal'
> >         diag-trigger: 'error-reset power-on-reset '
> >         service-mode?: 'false'
> >         diag-script: 'normal'
> >         diag-level: 'max'
> >         diag-switch?: 'false'
> >         name: 'options'
> >=20
> >     Node 0xf002d6f0
> >         .node:  f002d6f0
> >         net: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4'
> >         net0: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4'
> >         net1: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4,1'
> >         net2: '/pci@1e,600000/pci@0/pci@a/pci@0/network@4'
> >         net3: '/pci@1e,600000/pci@0/pci@a/pci@0/network@4,1'
> >         cdrom: '/pci@1e,600000/pci@0/pci@1/pci@0/ide@1f/cdrom@0,0:f'
> >         ide: '/pci@1e,600000/pci@0/pci@1/pci@0/ide@1f'
> >         disk: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0,0'
> >         disk0: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0,0'
> >         disk1: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@1,0'
> >         disk2: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@2,0'
> >         disk3: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@3,0'
> >         scsi: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1'
> >         ttya: '/ebus@1f,464000/serial@2,80'
> >         ttyb: '/ebus@1f,464000/serial@2,40'
> >         sc-control: '/ebus@1f,464000/rmc-comm@2,0'
> >         name: 'aliases'
> >=20
> >     Node 0xf003fce0
> >         .node:  f003fce0
> >         reg:  00000000.00000000.00000000.80000000.00000001.00000000.000=
00000.80000000
> >         available:  00000001.7fee6000.00000000.00002000.00000001.7fee00=
00.00000000.00004000.00000001.7fe44000.00000000.0001c000.00000001.7f000000.=
00000000.00e34000.00000001.00000000.00000000.7effe000.00000000.00000000.000=
00000.80000000
> >         name: 'memory'
> >=20
> >     Node 0xf00402ec
> >         .node:  f00402ec
> >         translations:  00000000.00002000.00000000.003fe000.80000000.000=
02036.00000000.00400000.00000000.00800000.80000001.00000036.00000000.400000=
00.00000000.04000000.80000001.00000036.00000000.f0000000.00000000.00080000.=
80000001.7ff800b6.00000000.f0080000.00000000.00010000.80000001.7ff200b6.000=
00000.f0090000.00000000.00010000.80000001.7ff100b6.00000000.f00a0000.000000=
00.00010000.80000001.7fed00b6.00000000.f00b0000.00000000.00010000.80000001.=
7fec00b6.00000000.f00c0000.00000000.00020000.80000001.7fea00b6.00000000.f00=
e0000.00000000.00020000.80000001.7fe800b6.00000000.f0100000.00000000.000100=
00.80000001.7fe700b6.00000000.f0110000.00000000.00010000.80000001.7fe600b6.=
00000000.feb20000.00000000.00200000.800007ff.f000008e.00000000.fed20000.000=
00000.000f0000.80000400.0ff0008e.00000000.fee10000.00000000.000f0000.800004=
00.0f60008e.00000000.fefe4000.00000000.0001c000.80000001.7feee0b6.00000000.=
fff10000.00000000.00002000.800007f8.1000008e.00000000.fff12000.00000000.000=
02000.800007f9.
 0!
> 020
> >  408e.00000000.fff14000.00000000.00002000.800007f9.0020008e.00000000.ff=
f16000.00000000.00002000.800007f9.0020008e.00000000.fff1c000.00000000.00002=
000.800007ff.f200008e.00000000.fff1e000.00000000.00002000.80000001.7feec0b6=
.00000000.fff20000.00000000.00002000.800007f9.0020008e.00000000.fff22000.00=
000000.00002000.80000001.7ff340b6.00000000.fff24000.00000000.00002000.80000=
001.7ff320b6.00000000.fff26000.00000000.00002000.800007ff.f100008e.00000000=
.fff28000.00000000.00002000.80000001.7ff360b6.00000000.fff2a000.00000000.00=
002000.80000001.7ff440b6.00000000.fff2c000.00000000.00006000.80000001.7ff0a=
0b6.00000000.fff32000.00000000.00002000.800007ff.f300008e.00000000.fff34000=
.00000000.00002000.80000001.7effe0b6.00000000.fff36000.00000000.00002000.80=
0007f6.0020008e.00000000.fff38000.00000000.00004000.80000001.7ff380b6.00000=
000.fff3c000.00000000.00002000.80000400.0fc0008e.00000000.fff3e000.00000000=
.00002000.800007f8.00d0808e.00000000.fff40000.00000000.00004000.80000001.7f=
f3c0b6.00000000
 .!
> fff
> >  44000.00000000.00002000.80000400.0f40008e.00000000.fff46000.00000000.0=
0004000.80000001.7ff400b6.00000000.fff4a000.00000000.00002000.80000400.0fd3=
008e.00000000.fff50000.00000000.00002000.80000001.7ff5e0b6.00000000.fff5200=
0.00000000.00016000.80000001.7ff460b6.00000000.fff68000.00000000.00008000.8=
0000001.7ff600b6.00000000.fff70000.00000000.00010000.80000001.7ff700b6
> >         existing:  00000000.00000000.00000800.00000000.fffff800.0000000=
0.00000800.00000000
> >         available:  fffff800.00000000.000007fc.00000000.00000001.000000=
00.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.=
00000000.f0000000.00000000.fff18000.00000000.00004000.00000000.fff00000.000=
00000.00010000.00000000.fef00000.00000000.000e4000.00000000.f0800000.000000=
00.0e320000
> >         page-size:  00002000
> >         name: 'virtual-memory'
> >=20
> >     Node 0xf0067eac
> >         .node:  f0067eac
> >         clock-divisors:  00000001.00000002.00000020
> >         clock-frequency:  59a53800
> >         manufacturer#:  0000003e
> >         implementation#:  00000016
> >         mask#:  00000034
> >         ecache-associativity:  00000004
> >         ecache-line-size:  00000040
> >         sparc-version:  00000009
> >         #dtlb-entries:  00000010
> >         dcache-associativity:  00000004
> >         dcache-line-size:  00000020
> >         dcache-size:  00010000
> >         #itlb-entries:  00000010
> >         icache-associativity:  00000004
> >         icache-line-size:  00000020
> >         icache-size:  00008000
> >         device_type: 'cpu'
> >         cpuid:  00000000
> >         portid:  00000000
> >         reg:  00000400.00000000.00000000.00010000
> >         ecache-size:  00100000
> >         name: 'SUNW,UltraSPARC-IIIi'
> >=20
> >     Node 0xf00685f0
> >         .node:  f00685f0
> >         memory-control-register-1:  5000010a.3e901cb7
> >         memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30=
000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000=
000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5=
.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9b=
a1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6=
e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021=
.2327287e.7f838500
> >         compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6=
300.53554e57.2c6d6300
> >         portid:  00000000
> >         reg:  00000400.00000000.00000000.00000008
> >         device_type: 'memory-controller'
> >         name: 'memory-controller'
> >=20
> >     Node 0xf006872c
> >         .node:  f006872c
> >         interrupt-map:  00000000.00000000.00000000.00000001.f006872c.00=
000014.00000000.00000000.00000000.00000002.f006872c.00000015.00000000.00000=
000.00000000.00000003.f006872c.00000016.00000000.00000000.00000000.00000004=
.f006872c.00000017
> >         interrupt-map-mask:  00000000.00000000.00000000.00000007
> >         #interrupt-cells:  00000001
> >         available:  81000000.00000000.00003000.00000000.0000d000.820000=
00.00000000.00120000.00000000.000e0000.82000000.00000000.05000000.00000000.=
7aff0000.c3000000.00000001.00000000.00000000.ffff0000
> >         reg:  00000400.0f600000.00000000.000f0000.00000400.0f410000.000=
00000.00064000
> >         ranges:  00000000.00000000.00000000.000007f8.00000000.00000000.=
10000000.01000000.00000000.00000000.000007f8.10000000.00000000.10000000.020=
00000.00000000.00000000.000007f9.00000000.00000000.7fff0000.03000000.000000=
00.00000000.000007fc.00000000.00000001.ffff0000
> >         msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff00=
00.00010000
> >         msi-eq-devino:  00000000.00000024.00000018
> >         #msi-eqs:  00000024
> >         msix-data-width:  00000020
> >         msi-eq-size:  00000080
> >         msi-ranges:  00000000.00000100
> >         msi-data-mask:  000000ff
> >         #msi:  00000100
> >         bus-range:  00000002.0000000d
> >         bus-parity-generated: =20
> >         compatible: 'pciex108e,80f0'
> >         name: 'pci'
> >         device_type: 'pciex'
> >         #address-cells:  00000003
> >         #size-cells:  00000002
> >         module-manufacturer#:  00000036
> >         fire-revision#:  00000003
> >         module-revision#:  00000003
> >         portid:  0000001e
> >         ino-bitmap:  fff7f817.ffffffff
> >         interrupts:  0000003f.0000003e
> >=20
> >         Node 0xf00ad404
> >             .node:  f00ad404
> >             assigned-addresses:  82020010.00000000.00100000.00000000.00=
020000
> >             ranges:  81000000.00000000.00000000.81000000.00000000.00000=
000.00000000.00003000.82000000.00000000.00200000.82000000.00000000.00200000=
.00000000.04e00000
> >             bus-range:  00000003.0000000d
> >             compatible:  70636965.78313062.352c3835.33322e62.61007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
> >             reg:  00020000.00000000.00000000.00000000.00000000
> >             #address-cells:  00000003
> >             #size-cells:  00000002
> >             device_type: 'pciex'
> >             name: 'pci'
> >             interrupts:  00000001
> >             cache-line-size:  00000010
> >             class-code:  00060400
> >             revision-id:  000000ba
> >             device-id:  00008532
> >             vendor-id:  000010b5
> >=20
> >             Node 0xf00af7c8
> >                 .node:  f00af7c8
> >                 ranges:  81000000.00000000.00000000.81000000.00000000.0=
0000000.00000000.00002000.82000000.00000000.00200000.82000000.00000000.0020=
0000.00000000.03e00000
> >                 bus-range:  00000004.00000005
> >                 compatible:  70636965.78313062.352c3835.33322e62.610070=
63.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.=
63696578.636c6173.732c3036.303400
> >                 reg:  00030800.00000000.00000000.00000000.00000000
> >                 #address-cells:  00000003
> >                 #size-cells:  00000002
> >                 device_type: 'pciex'
> >                 name: 'pci'
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  00060400
> >                 revision-id:  000000ba
> >                 device-id:  00008532
> >                 vendor-id:  000010b5
> >=20
> >                 Node 0xf00b1b8c
> >                     .node:  f00b1b8c
> >                     interrupt-map:  0000e000.00000000.00000000.00000001=
.f006872c.00000000.0000e100.00000000.00000000.00000002.f006872c.00000000.00=
00e200.00000000.00000000.00000003.f006872c.00000000.0000e300.00000000.00000=
000.00000004.f006872c.00000001.0000f800.00000000.00000000.00000001.f006872c=
.00000004
> >                     interrupt-map-mask:  0000ff00.00000000.00000000.000=
00007
> >                     #interrupt-cells:  00000001
> >                     available:  81000000.00000000.00001140.00000000.000=
00ec0.82000000.00000000.00202000.00000000.00002000.82000000.00000000.002080=
00.00000000.00df8000
> >                     ranges:  81000000.00000000.00001000.81000000.000000=
00.00001000.00000000.00001000.82000000.00000000.00200000.82000000.00000000.=
00200000.00000000.03e00000
> >                     bus-range:  00000005.00000005
> >                     compatible:  70636965.78313062.392c3532.34392e30.00=
706369.65783130.62392c35.32343900.70636965.78636c61.73732c30.36303430.30007=
063.69657863.6c617373.2c303630.3400
> >                     reg:  00040000.00000000.00000000.00000000.00000000
> >                     #address-cells:  00000003
> >                     #size-cells:  00000002
> >                     device_type: 'pciex'
> >                     name: 'pci'
> >                     cache-line-size:  00000010
> >                     class-code:  00060400
> >                     revision-id:  00000000
> >                     device-id:  00005249
> >                     vendor-id:  000010b9
> >=20
> >                     Node 0xf00b3f2c
> >                         .node:  f00b3f2c
> >                         assigned-addresses:  8205e010.00000000.01000000=
.00000000.01000000
> >                         sunw,find-fcode:  f00b975c
> >                         maximum-frame#:  0000ffff
> >                         reg:  0005e000.00000000.00000000.00000000.00000=
000.0205e010.00000000.00000000.00000000.01000000
> >                         #size-cells:  00000000
> >                         #address-cells:  00000001
> >                         compatible:  70636931.3062392c.35323337.2e31306=
2.392e3532.33372e33.00706369.31306239.2c353233.372e3130.62392e35.32333700.7=
0636931.3062392c.35323337.00706369.31306239.2c353233.372e3300.70636931.3062=
392c.35323337.00706369.636c6173.732c3063.30333130.00706369.636c6173.732c306=
3.303300
> >                         name: 'usb'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000050
> >                         min-grant:  00000000
> >                         interrupts:  00000001
> >                         cache-line-size:  00000010
> >                         class-code:  000c0310
> >                         subsystem-id:  00005237
> >                         subsystem-vendor-id:  000010b9
> >                         revision-id:  00000003
> >                         device-id:  00005237
> >                         vendor-id:  000010b9
> >=20
> >                     Node 0xf00ba5f8
> >                         .node:  f00ba5f8
> >                         assigned-addresses:  8205e110.00000000.02000000=
.00000000.01000000
> >                         sunw,find-fcode:  f00bfe28
> >                         maximum-frame#:  0000ffff
> >                         reg:  0005e100.00000000.00000000.00000000.00000=
000.0205e110.00000000.00000000.00000000.01000000
> >                         #size-cells:  00000000
> >                         #address-cells:  00000001
> >                         compatible:  70636931.3062392c.35323337.2e31306=
2.392e3532.33372e33.00706369.31306239.2c353233.372e3130.62392e35.32333700.7=
0636931.3062392c.35323337.00706369.31306239.2c353233.372e3300.70636931.3062=
392c.35323337.00706369.636c6173.732c3063.30333130.00706369.636c6173.732c306=
3.303300
> >                         name: 'usb'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000050
> >                         min-grant:  00000000
> >                         interrupts:  00000002
> >                         cache-line-size:  00000010
> >                         class-code:  000c0310
> >                         subsystem-id:  00005237
> >                         subsystem-vendor-id:  000010b9
> >                         revision-id:  00000003
> >                         device-id:  00005237
> >                         vendor-id:  000010b9
> >=20
> >                         Node 0xf00c0c40
> >                             .node:  f00c0c40
> >                             #size-cells:  00000000
> >                             #address-cells:  00000001
> >                             endpoints: '0,8,81,1'
> >                             interface#:  00000000
> >                             compatible:  75736233.65622c33.3330312e.333=
03000.75736233.65622c33.33303100.75736233.65622c63.6c617373.392e302e.300075=
73.62336562.2c636c61.7373392e.30007573.62336562.2c636c61.73733900.7573622c.=
636c6173.73392e30.2e300075.73622c63.6c617373.392e3000.7573622c.636c6173.733=
90075.73626966.3365622c.636c6173.73392e30.2e300075.73626966.3365622c.636c61=
73.73392e30.00757362.69663365.622c636c.61737339.00757362.69662c63.6c617373.=
392e302e.30007573.6269662c.636c6173.73392e30.00757362.69662c63.6c617373.3900
> >                             name: 'hub'
> >                             reg:  00000001
> >                             assigned-address:  00000002
> >                             0max-packet:  00000008
> >=20
> >                     Node 0xf00cc644
> >                         .node:  f00cc644
> >                         assigned-addresses:  8205e310.00000000.00200000=
.00000000.00002000
> >                         reg:  0005e300.00000000.00000000.00000000.00000=
000.0205e310.00000000.00000000.00000000.00002000
> >                         compatible:  70636931.3062392c.35323339.2e31306=
2.392e3532.33382e32.30303100.70636931.3062392c.35323339.2e313062.392e3532.3=
3380070.63693130.62392c35.32333800.70636931.3062392c.35323339.2e323030.3100=
7063.69313062.392c3532.33390070.6369636c.6173732c.30633033.32300070.6369636=
c.6173732c.30633033.00
> >                         name: 'usb'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000020
> >                         min-grant:  00000010
> >                         interrupts:  00000004
> >                         cache-line-size:  00000010
> >                         class-code:  000c0320
> >                         subsystem-id:  00005238
> >                         subsystem-vendor-id:  000010b9
> >                         revision-id:  00000001
> >                         device-id:  00005239
> >                         vendor-id:  000010b9
> >=20
> >                     Node 0xf00ccd3c
> >                         .node:  f00ccd3c
> >                         assigned-addresses:  8105f010.00000000.00000000=
.00000000.00001000
> >                         ranges:  00000000.00000000.8105f010.00000000.00=
000000.00001000
> >                         reg:  0005f000.00000000.00000000.00000000.00000=
000.8105f010.00000000.00000000.00000000.00001000
> >                         #size-cells:  00000001
> >                         #address-cells:  00000002
> >                         name: 'isa'
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000018
> >                         min-grant:  00000001
> >                         cache-line-size:  00000000
> >                         class-code:  00060100
> >                         subsystem-id:  00001575
> >                         subsystem-vendor-id:  000010b9
> >                         revision-id:  00000000
> >                         device-id:  00001575
> >                         vendor-id:  000010b9
> >=20
> >                         Node 0xf00cdb98
> >                             .node:  f00cdb98
> >                             address:  fff10070
> >                             reg:  00000000.00000070.00000004
> >                             compatible: 'isa-m5823p'
> >                             model: 'm5823'
> >                             name: 'rtc'
> >=20
> >                     Node 0xf00ceac0
> >                         .node:  f00ceac0
> >                         assigned-addresses:  8105f810.00000000.00001040=
.00000000.00000040.8105f814.00000000.00001080.00000000.00000040.8105f818.00=
000000.000010c0.00000000.00000040.8105f81c.00000000.00001100.00000000.00000=
040.8105f820.00000000.00001000.00000000.00000040
> >                         reg:  0005f800.00000000.00000000.00000000.00000=
000.0105f810.00000000.00000000.00000000.00000028.0105f814.00000000.00000000=
.00000000.00000024.0105f818.00000000.00000000.00000000.00000028.0105f81c.00=
000000.00000000.00000000.00000024.0105f820.00000000.00000000.00000000.00000=
030
> >                         compatible:  70636931.3062392c.35323239.2e31306=
2.392e3532.32392e63.38007063.69313062.392c3532.32392e31.3062392e.35323239.0=
0706369.31306239.2c353232.39007063.69313062.392c3532.32392e63.38007063.6931=
3062.392c3532.32390070.6369636c.6173732c.30313031.38660070.6369636c.6173732=
c.30313031.00
> >                         #address-cells:  00000002
> >                         device_type: 'ide'
> >                         name: 'ide'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000000
> >                         min-grant:  00000000
> >                         interrupts:  00000001
> >                         cache-line-size:  00000010
> >                         class-code:  0001018f
> >                         subsystem-id:  00005229
> >                         subsystem-vendor-id:  000010b9
> >                         revision-id:  000000c8
> >                         device-id:  00005229
> >                         vendor-id:  000010b9
> >=20
> >                         Node 0xf00d1da4
> >                             .node:  f00d1da4
> >                             device_type: 'block'
> >                             name: 'disk'
> >                             compatible: 'ide-disk'
> >=20
> >                         Node 0xf00d2498
> >                             .node:  f00d2498
> >                             device_type: 'block'
> >                             name: 'cdrom'
> >                             compatible: 'ide-cdrom'
> >=20
> >             Node 0xf00d3084
> >                 .node:  f00d3084
> >                 slot-names:  00000001.5043492d.45203200
> >                 ranges:  82000000.00000000.fff00000.82000000.00000000.f=
ff00000.ffffffff.00200000
> >                 bus-range:  00000006.00000006
> >                 compatible:  70636965.78313062.352c3835.33322e62.610070=
63.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.=
63696578.636c6173.732c3036.303400
> >                 reg:  00031000.00000000.00000000.00000000.00000000
> >                 physical-slot#:  000000e2
> >                 #address-cells:  00000003
> >                 #size-cells:  00000002
> >                 device_type: 'pciex'
> >                 name: 'pci'
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  00060400
> >                 revision-id:  000000ba
> >                 device-id:  00008532
> >                 vendor-id:  000010b5
> >=20
> >             Node 0xf00d550c
> >                 .node:  f00d550c
> >                 slot-names:  00000001.5043492d.45203000
> >                 ranges:  82000000.00000000.fff00000.82000000.00000000.f=
ff00000.ffffffff.00200000
> >                 bus-range:  00000007.00000007
> >                 compatible:  70636965.78313062.352c3835.33322e62.610070=
63.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.=
63696578.636c6173.732c3036.303400
> >                 reg:  00034000.00000000.00000000.00000000.00000000
> >                 physical-slot#:  000000e0
> >                 #address-cells:  00000003
> >                 #size-cells:  00000002
> >                 device_type: 'pciex'
> >                 name: 'pci'
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  00060400
> >                 revision-id:  000000ba
> >                 device-id:  00008532
> >                 vendor-id:  000010b5
> >=20
> >             Node 0xf00d7994
> >                 .node:  f00d7994
> >                 ranges:  82000000.00000000.04000000.82000000.00000000.0=
4000000.00000000.00600000
> >                 bus-range:  00000008.0000000a
> >                 compatible:  70636965.78313062.352c3835.33322e62.610070=
63.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.=
63696578.636c6173.732c3036.303400
> >                 reg:  00034800.00000000.00000000.00000000.00000000
> >                 #address-cells:  00000003
> >                 #size-cells:  00000002
> >                 device_type: 'pciex'
> >                 name: 'pci'
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  00060400
> >                 revision-id:  000000ba
> >                 device-id:  00008532
> >                 vendor-id:  000010b5
> >=20
> >                 Node 0xf00d9d58
> >                     .node:  f00d9d58
> >                     available:  82000000.00000000.04000000.00000000.000=
10000.82000000.00000000.04040000.00000000.001c0000
> >                     ranges:  82000000.00000000.04000000.82000000.000000=
00.04000000.00000000.00600000
> >                     bus-range:  00000009.0000000a
> >                     compatible:  70636965.78313136.362c3130.332e6235.00=
706369.65783131.36362c31.30330070.63696578.636c6173.732c3036.30343030.00706=
369.6578636c.6173732c.30363034.00
> >                     reg:  00080000.00000000.00000000.00000000.00000000
> >                     #address-cells:  00000003
> >                     #size-cells:  00000002
> >                     device_type: 'pciex'
> >                     name: 'pci'
> >                     cache-line-size:  00000010
> >                     class-code:  00060400
> >                     revision-id:  000000b5
> >                     device-id:  00000103
> >                     vendor-id:  00001166
> >=20
> >                     Node 0xf00dc0f4
> >                         .node:  f00dc0f4
> >                         local-mac-address:  00144f72.0e2e
> >                         assigned-addresses:  82092010.00000000.04200000=
.00000000.00200000.82092018.00000000.04010000.00000000.00010000.82092030.00=
000000.04020000.00000000.00010000
> >                         compatible:  70636931.3465342c.31363638.2e31303=
8.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.0=
0706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.6931=
3465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732=
c.30323030.00
> >                         reg:  00092000.00000000.00000000.00000000.00000=
000.03092010.00000000.00000000.00000000.00200000.03092018.00000000.00000000=
.00000000.00010000
> >                         max-frame-size:  00010000
> >                         address-bits:  00000030
> >                         network-interface-type: 'ethernet'
> >                         device_type: 'network'
> >                         name: 'network'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000000
> >                         min-grant:  00000040
> >                         interrupts:  00000001
> >                         cache-line-size:  00000010
> >                         class-code:  00020000
> >                         subsystem-id:  00001668
> >                         subsystem-vendor-id:  0000108e
> >                         revision-id:  000000a3
> >                         device-id:  00001668
> >                         vendor-id:  000014e4
> >=20
> >                     Node 0xf00e2f6c
> >                         .node:  f00e2f6c
> >                         local-mac-address:  00144f72.0e2f
> >                         assigned-addresses:  82092110.00000000.04400000=
.00000000.00200000.82092118.00000000.04030000.00000000.00010000
> >                         compatible:  70636931.3465342c.31363638.2e31303=
8.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.0=
0706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.6931=
3465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732=
c.30323030.00
> >                         reg:  00092100.00000000.00000000.00000000.00000=
000.03092110.00000000.00000000.00000000.00200000.03092118.00000000.00000000=
.00000000.00010000
> >                         max-frame-size:  00010000
> >                         address-bits:  00000030
> >                         network-interface-type: 'ethernet'
> >                         device_type: 'network'
> >                         name: 'network'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000000
> >                         min-grant:  00000040
> >                         interrupts:  00000002
> >                         cache-line-size:  00000010
> >                         class-code:  00020000
> >                         subsystem-id:  00001668
> >                         subsystem-vendor-id:  0000108e
> >                         revision-id:  000000a3
> >                         device-id:  00001668
> >                         vendor-id:  000014e4
> >=20
> >                     Node 0xf00e9dd0
> >                         .node:  f00e9dd0
> >                         ranges:  82000000.00000000.fff00000.82000000.00=
000000.fff00000.ffffffff.00200000
> >                         bus-range:  0000000a.0000000a
> >                         compatible:  70636931.3136362c.3130342e.6234007=
0.63693131.36362c31.30340070.6369636c.6173732c.30363034.30300070.6369636c.6=
173732c.30363034.00
> >                         reg:  00094000.00000000.00000000.00000000.00000=
000
> >                         #address-cells:  00000003
> >                         #size-cells:  00000002
> >                         device_type: 'pci'
> >                         name: 'pci'
> >                         66mhz-capable: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         cache-line-size:  00000010
> >                         class-code:  00060400
> >                         revision-id:  000000b4
> >                         device-id:  00000104
> >                         vendor-id:  00001166
> >=20
> >             Node 0xf00ec3f0
> >                 .node:  f00ec3f0
> >                 ranges:  81000000.00000000.00002000.81000000.00000000.0=
0002000.00000000.00001000.82000000.00000000.04600000.82000000.00000000.0460=
0000.00000000.00a00000
> >                 bus-range:  0000000b.0000000d
> >                 compatible:  70636965.78313062.352c3835.33322e62.610070=
63.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.=
63696578.636c6173.732c3036.303400
> >                 reg:  00035000.00000000.00000000.00000000.00000000
> >                 #address-cells:  00000003
> >                 #size-cells:  00000002
> >                 device_type: 'pciex'
> >                 name: 'pci'
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  00060400
> >                 revision-id:  000000ba
> >                 device-id:  00008532
> >                 vendor-id:  000010b5
> >=20
> >                 Node 0xf00ee7b4
> >                     .node:  f00ee7b4
> >                     available:  82000000.00000000.04600000.00000000.000=
10000.82000000.00000000.04640000.00000000.001c0000
> >                     ranges:  81000000.00000000.00002000.81000000.000000=
00.00002000.00000000.00001000.82000000.00000000.04600000.82000000.00000000.=
04600000.00000000.00a00000
> >                     bus-range:  0000000c.0000000d
> >                     compatible:  70636965.78313136.362c3130.332e6235.00=
706369.65783131.36362c31.30330070.63696578.636c6173.732c3036.30343030.00706=
369.6578636c.6173732c.30363034.00
> >                     reg:  000b0000.00000000.00000000.00000000.00000000
> >                     #address-cells:  00000003
> >                     #size-cells:  00000002
> >                     device_type: 'pciex'
> >                     name: 'pci'
> >                     cache-line-size:  00000010
> >                     class-code:  00060400
> >                     revision-id:  000000b5
> >                     device-id:  00000103
> >                     vendor-id:  00001166
> >=20
> >                     Node 0xf00f0b50
> >                         .node:  f00f0b50
> >                         local-mac-address:  00144f72.0e30
> >                         assigned-addresses:  820c2010.00000000.04800000=
.00000000.00200000.820c2018.00000000.04610000.00000000.00010000.820c2030.00=
000000.04620000.00000000.00010000
> >                         compatible:  70636931.3465342c.31363638.2e31303=
8.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.0=
0706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.6931=
3465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732=
c.30323030.00
> >                         reg:  000c2000.00000000.00000000.00000000.00000=
000.030c2010.00000000.00000000.00000000.00200000.030c2018.00000000.00000000=
.00000000.00010000
> >                         max-frame-size:  00010000
> >                         address-bits:  00000030
> >                         network-interface-type: 'ethernet'
> >                         device_type: 'network'
> >                         name: 'network'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000000
> >                         min-grant:  00000040
> >                         interrupts:  00000001
> >                         cache-line-size:  00000010
> >                         class-code:  00020000
> >                         subsystem-id:  00001668
> >                         subsystem-vendor-id:  0000108e
> >                         revision-id:  000000a3
> >                         device-id:  00001668
> >                         vendor-id:  000014e4
> >=20
> >                     Node 0xf00f79c8
> >                         .node:  f00f79c8
> >                         local-mac-address:  00144f72.0e31
> >                         assigned-addresses:  820c2110.00000000.04a00000=
.00000000.00200000.820c2118.00000000.04630000.00000000.00010000
> >                         compatible:  70636931.3465342c.31363638.2e31303=
8.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.0=
0706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.6931=
3465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732=
c.30323030.00
> >                         reg:  000c2100.00000000.00000000.00000000.00000=
000.030c2110.00000000.00000000.00000000.00200000.030c2118.00000000.00000000=
.00000000.00010000
> >                         max-frame-size:  00010000
> >                         address-bits:  00000030
> >                         network-interface-type: 'ethernet'
> >                         device_type: 'network'
> >                         name: 'network'
> >                         66mhz-capable: =20
> >                         fast-back-to-back: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         max-latency:  00000000
> >                         min-grant:  00000040
> >                         interrupts:  00000002
> >                         cache-line-size:  00000010
> >                         class-code:  00020000
> >                         subsystem-id:  00001668
> >                         subsystem-vendor-id:  0000108e
> >                         revision-id:  000000a3
> >                         device-id:  00001668
> >                         vendor-id:  000014e4
> >=20
> >                     Node 0xf00fe82c
> >                         .node:  f00fe82c
> >                         interrupt-map:  00000000.00000000.00000000.0000=
0001.f006872c.0000000f.00000000.00000000.00000000.00000002.f006872c.0000001=
0.00000000.00000000.00000000.00000003.f006872c.00000011.00000000.00000000.0=
0000000.00000004.f006872c.00000012
> >                         interrupt-map-mask:  00000000.00000000.00000000=
.00000007
> >                         #interrupt-cells:  00000001
> >                         available:  81000000.00000000.00002100.00000000=
.00000f00.82000000.00000000.04c20000.00000000.001e0000
> >                         ranges:  81000000.00000000.00002000.81000000.00=
000000.00002000.00000000.00001000.82000000.00000000.04c00000.82000000.00000=
000.04c00000.00000000.00400000
> >                         bus-range:  0000000d.0000000d
> >                         compatible:  70636931.3136362c.3130342e.6234007=
0.63693131.36362c31.30340070.6369636c.6173732c.30363034.30300070.6369636c.6=
173732c.30363034.00
> >                         reg:  000c4000.00000000.00000000.00000000.00000=
000
> >                         #address-cells:  00000003
> >                         #size-cells:  00000002
> >                         device_type: 'pci'
> >                         name: 'pci'
> >                         66mhz-capable: =20
> >                         devsel-speed:  00000001
> >                         latency-timer:  00000040
> >                         cache-line-size:  00000010
> >                         class-code:  00060400
> >                         revision-id:  000000b4
> >                         device-id:  00000104
> >                         vendor-id:  00001166
> >=20
> >                         Node 0xf0100c30
> >                             .node:  f0100c30
> >                             firmware-version: '1.08.04.00'
> >                             mpt-version: '1.05'
> >                             assigned-addresses:  810d0810.00000000.0000=
2000.00000000.00000100.820d0814.00000000.04c00000.00000000.00010000.820d081=
c.00000000.04c10000.00000000.00010000.820d0830.00000000.04e00000.00000000.0=
0200000
> >                             compatible:  70636931.3030302c.35302e31.303=
0302e.33303230.2e320070.63693130.30302c35.302e3130.30302e33.30323000.706369=
31.3030302c.33303230.00706369.31303030.2c35302e.32007063.69313030.302c3530.=
00706369.636c6173.732c3031.30303030.00706369.636c6173.732c3031.30300070.636=
93130.30302c35.3600
> >                             model: 'LSI,1064'
> >                             reg:  000d0800.00000000.00000000.00000000.0=
0000000.010d0810.00000000.00000000.00000000.00000100.030d0814.00000000.0000=
0000.00000000.00010000.030d081c.00000000.00000000.00000000.00010000.020d083=
0.00000000.00000000.00000000.00200000
> >                             version: '1.00.41'
> >                             wide:  00000010
> >                             device_type: 'scsi-2'
> >                             name: 'scsi'
> >                             local-wwid:  50800200.00002999
> >                             devsel-speed:  00000001
> >                             latency-timer:  000000f8
> >                             max-latency:  0000000a
> >                             min-grant:  00000040
> >                             interrupts:  00000001
> >                             cache-line-size:  00000080
> >                             class-code:  00010000
> >                             subsystem-id:  00003020
> >                             subsystem-vendor-id:  00001000
> >                             revision-id:  00000002
> >                             device-id:  00000050
> >                             vendor-id:  00001000
> >=20
> >                             Node 0xf010d3e8
> >                                 .node:  f010d3e8
> >                                 device_type: 'byte'
> >                                 compatible: 'st'
> >                                 name: 'tape'
> >=20
> >                             Node 0xf010e128
> >                                 .node:  f010e128
> >                                 lba64: =20
> >                                 device_type: 'block'
> >                                 compatible: 'sd'
> >                                 name: 'disk'
> >=20
> >     Node 0xf0071e78
> >         .node:  f0071e78
> >         interrupt-map:  00000000.00000000.00000000.00000001.f0071e78.00=
000014.00000000.00000000.00000000.00000002.f0071e78.00000015.00000000.00000=
000.00000000.00000003.f0071e78.00000016.00000000.00000000.00000000.00000004=
.f0071e78.00000017
> >         interrupt-map-mask:  00000000.00000000.00000000.00000007
> >         #interrupt-cells:  00000001
> >         available:  81000000.00000000.00001000.00000000.0ffff000.820000=
00.00000000.00200000.00000000.7fdf0000.c3000000.00000001.00000000.00000000.=
ffff0000
> >         reg:  00000400.0ff00000.00000000.000f0000.00000400.0fc10000.000=
00000.00064000
> >         ranges:  00000000.00000000.00000000.000007f6.00000000.00000000.=
10000000.01000000.00000000.00000000.000007f6.10000000.00000000.10000000.020=
00000.00000000.00000000.000007f7.00000000.00000000.7fff0000.03000000.000000=
00.00000000.000007f4.00000000.00000001.ffff0000
> >         msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff00=
00.00010000
> >         msi-eq-devino:  00000000.00000024.00000018
> >         #msi-eqs:  00000024
> >         msix-data-width:  00000020
> >         msi-eq-size:  00000080
> >         msi-ranges:  00000000.00000100
> >         msi-data-mask:  000000ff
> >         #msi:  00000100
> >         bus-range:  00000002.00000004
> >         bus-parity-generated: =20
> >         compatible: 'pciex108e,80f0'
> >         name: 'pci'
> >         device_type: 'pciex'
> >         #address-cells:  00000003
> >         #size-cells:  00000002
> >         module-manufacturer#:  00000036
> >         fire-revision#:  00000003
> >         module-revision#:  00000003
> >         portid:  0000001f
> >         ino-bitmap:  fff3c77d.ffffffff
> >         interrupts:  0000003f.0000003e
> >=20
> >         Node 0xf009ca88
> >             .node:  f009ca88
> >             slot-names:  00000004.5043492d.58203300
> >             interrupt-map:  00000000.00000000.00000000.00000001.f0071e7=
8.0000000e.00000000.00000000.00000000.00000002.f0071e78.0000000f.00000000.0=
0000000.00000000.00000003.f0071e78.00000010.00000000.00000000.00000000.0000=
0004.f0071e78.00000011
> >             interrupt-map-mask:  00000000.00000000.00000000.00000007
> >             #interrupt-cells:  00000001
> >             available:  81000000.00000000.00000100.00000000.00000f00.82=
000000.00000000.00102000.00000000.0001e000.82000000.00000000.00140000.00000=
000.000c0000
> >             ranges:  81000000.00000000.00000000.81000000.00000000.00000=
000.00000000.00001000.82000000.00000000.00100000.82000000.00000000.00100000=
.00000000.00100000
> >             bus-range:  00000003.00000003
> >             compatible:  70636965.78383038.362c3334.302e3900.70636965.7=
8383038.362c3334.30007063.69657863.6c617373.2c303630.34303000.70636965.7863=
6c61.73732c30.36303400
> >             reg:  00020000.00000000.00000000.00000000.00000000
> >             #address-cells:  00000003
> >             #size-cells:  00000002
> >             device_type: 'pciex'
> >             name: 'pci'
> >             cache-line-size:  00000010
> >             class-code:  00060400
> >             revision-id:  00000009
> >             device-id:  00000340
> >             vendor-id:  00008086
> >=20
> >             Node 0xf009ee24
> >                 .node:  f009ee24
> >                 assigned-addresses:  81031010.00000000.00000000.0000000=
0.00000100.82031014.00000000.00100000.00000000.00002000.82031030.00000000.0=
0120000.00000000.00020000
> >                 name: 'QLGC,qlc'
> >                 model: 'QLA2340'
> >                 port-wwn:  210000e0.8b90d24a
> >                 node-wwn:  200000e0.8b90d24a
> >                 reg:  00031000.00000000.00000000.00000000.00000000.0103=
1010.00000000.00000000.00000000.00000100.03031014.00000000.00000000.0000000=
0.00001000
> >                 compatible:  70636931.3037372c.32333132.2e653131.2e3130=
30.2e320070.63693130.37372c32.3331322e.6531312e.31303000.70636965.31312c31.=
30300070.63693130.37372c32.3331322e.32007063.69313037.372c3233.31320070.636=
9636c.6173732c.63303430.3000
> >                 manufacturer: 'QLGC'
> >                 #size-cells:  00000000
> >                 #address-cells:  00000002
> >                 device_type: 'scsi-fcp'
> >                 version: 'ISP2312 Host Adapter fcode version 1.17 08/09=
/07'
> >                 fcode-rom-offset:  00000000
> >                 66mhz-capable: =20
> >                 devsel-speed:  00000001
> >                 latency-timer:  00000040
> >                 max-latency:  00000000
> >                 min-grant:  00000040
> >                 interrupts:  00000001
> >                 cache-line-size:  00000010
> >                 class-code:  000c0400
> >                 subsystem-id:  00000100
> >                 subsystem-vendor-id:  00000e11
> >                 revision-id:  00000002
> >                 device-id:  00002312
> >                 vendor-id:  00001077
> >=20
> >                 Node 0xf00a996c
> >                     .node:  f00a996c
> >                     #size-cells:  00000000
> >                     #address-cells:  00000004
> >                     reg:  00000000.00000000
> >                     device_type: 'fp'
> >                     name: 'fp'
> >=20
> >                     Node 0xf00aa068
> >                         .node:  f00aa068
> >                         device_type: 'block'
> >                         compatible: 'ssd'
> >                         name: 'disk'
> >=20
> >         Node 0xf00aaf68
> >             .node:  f00aaf68
> >             slot-names:  00000002.5043492d.58203100
> >             interrupt-map:  00000000.00000000.00000000.00000001.f006872=
c.0000000b.00000000.00000000.00000000.00000002.f006872c.0000000c.00000000.0=
0000000.00000000.00000003.f006872c.0000000d.00000000.00000000.00000000.0000=
0004.f006872c.0000000e
> >             interrupt-map-mask:  00000000.00000000.00000000.00000007
> >             #interrupt-cells:  00000001
> >             ranges:  82000000.00000000.fff00000.82000000.00000000.fff00=
000.ffffffff.00200000
> >             bus-range:  00000004.00000004
> >             compatible:  70636965.78383038.362c3334.312e3900.70636965.7=
8383038.362c3334.31007063.69657863.6c617373.2c303630.34303000.70636965.7863=
6c61.73732c30.36303400
> >             reg:  00020200.00000000.00000000.00000000.00000000
> >             #address-cells:  00000003
> >             #size-cells:  00000002
> >             device_type: 'pciex'
> >             name: 'pci'
> >             cache-line-size:  00000010
> >             class-code:  00060400
> >             revision-id:  00000009
> >             device-id:  00000341
> >             vendor-id:  00008086
> >=20
> >     Node 0xf0091c20
> >         .node:  f0091c20
> >         interrupt-map:  00000002.00000080.00000001.f0071e78.00000008.00=
000002.00000040.00000001.f0071e78.00000009.00000002.00000000.00000001.f0071=
e78.0000000a.00000003.00000000.00000001.f0071e78.00000000.00000003.00000040=
.00000001.f0071e78.00000003
> >         interrupt-map-mask:  00000003.000fffff.00000003
> >         #interrupt-cells:  00000001
> >         ranges:  00000000.00000000.000007ff.f0000000.01000000.00000001.=
00000000.000007ff.f1000000.01000000.00000002.00000000.000007ff.f2000000.010=
00000.00000003.00000000.000007ff.f3000000.01000000
> >         revision:  00000000
> >         #size-cells:  00000001
> >         #address-cells:  00000002
> >         reg:  00000400.0fc64000.00000000.00000020
> >         portid:  0000001f
> >         device_type: 'ebus'
> >         compatible: 'jbus-ebus'
> >         name: 'ebus'
> >=20
> >         Node 0xf00927d0
> >             .node:  f00927d0
> >             model: 'SUNW,525-2320'
> >             version:  4f425020.342e3330.2e342032.3030392f.30382f31.3920=
3037.3a313820.53756e20.46697265.20563231.352f5632.34350050.4f535420.342e333=
0.2e342032.3030392f.30382f31.39203037.3a333500.4f424449.41472034.2e33302e.3=
4203230.30392f30.382f3139.2030373a.32392020.00
> >             name: 'flashprom'
> >             reg:  00000000.00000000.00200000
> >=20
> >         Node 0xf00934ec
> >             .node:  f00934ec
> >             ignore-cd: =20
> >             reg:  00000002.00000080.00000008
> >             interrupts:  00000001
> >             compatible:  73753136.35353200.73753136.35353000.737500
> >             device_type: 'serial'
> >             name: 'serial'
> >=20
> >         Node 0xf009504c
> >             .node:  f009504c
> >             ignore-cd: =20
> >             reg:  00000002.00000040.00000008
> >             interrupts:  00000001
> >             compatible:  73753136.35353200.73753136.35353000.737500
> >             device_type: 'serial'
> >             name: 'serial'
> >=20
> >         Node 0xf0096bac
> >             .node:  f0096bac
> >             reg:  00000002.00000000.00000008
> >             interrupts:  00000001
> >             compatible: 'rmc_comm'
> >             device_type: 'serial'
> >             name: 'rmc-comm'
> >=20
> >         Node 0xf009871c
> >             .node:  f009871c
> >             reg:  00000002.000000c0.00000001
> >             compatible: 'pmugpio'
> >             gpio-device-type: 'SUNW,cpld'
> >             name: 'gpio'
> >=20
> >         Node 0xf009880c
> >             .node:  f009880c
> >             version: '5.10'
> >             reg:  00000003.00000000.00000081
> >             compatible: 'epic'
> >             name: 'env-monitor'
> >=20
> >         Node 0xf0098b3c
> >             .node:  f0098b3c
> >             interrupts:  00000001
> >             button: =20
> >             reg:  00000003.00000040.00000082
> >             power-device-type: 'SUNW,pic18lf65j10'
> >             name: 'power'
> >=20
> >     Node 0xf0098ea0
> >         .node:  f0098ea0
> >         interrupt-map:  00000000.000000d0.00000001.f0071e78.00000006
> >         interrupt-map-mask:  000000ff.000000ff.00000003
> >         #interrupt-cells:  00000001
> >         reg:  00000400.0fd30000.00000000.00000040
> >         i2c-clock-val:  0000000f
> >         portid:  0000001f
> >         interrupts:  00000001
> >         device_type: 'i2c'
> >         compatible: 'fire-i2c'
> >         #size-cells:  00000000
> >         #address-cells:  00000002
> >         name: 'i2c'
> >=20
> >         Node 0xf009a59c
> >             .node:  f009a59c
> >             reg:  00000000.00000032
> >             compatible: 'i2c-at24c64'
> >             device_type: 'fru-prom'
> >             name: 'pdb-fru-prom'
> >=20
> >         Node 0xf009a848
> >             .node:  f009a848
> >             reg:  00000000.00000064
> >             compatible: 'i2c-at24c64'
> >             device_type: 'fru-prom'
> >             name: 'sasbp-fru-prom'
> >=20
> >         Node 0xf009aaf4
> >             .node:  f009aaf4
> >             name: 'power-supply-fru-prom'
> >             reg:  00000000.0000006c
> >             compatible: 'i2c-at34c02'
> >=20
> >         Node 0xf009ace4
> >             .node:  f009ace4
> >             reg:  00000000.0000007c
> >             compatible: 'i2c-pcf8574'
> >             name: 'ioexp'
> >=20
> >         Node 0xf009ae98
> >             .node:  f009ae98
> >             reg:  00000000.00000080
> >             compatible: 'i2c-pca9555'
> >             name: 'gpio'
> >=20
> >         Node 0xf009af58
> >             .node:  f009af58
> >             reg:  00000000.000000a2
> >             compatible: 'i2c-at24c64'
> >             device_type: 'fru-prom'
> >             name: 'motherboard-fru-prom'
> >=20
> >         Node 0xf009b210
> >             .node:  f009b210
> >             reg:  00000000.000000a6
> >             compatible: 'i2c-at24c64'
> >             device_type: 'nvram'
> >             name: 'nvram'
> >=20
> >         Node 0xf009b5f4
> >             .node:  f009b5f4
> >             device_type: 'idprom'
> >             reg:  00000000.000000a6
> >             name: 'idprom'
> >=20
> >         Node 0xf009bb98
> >             .node:  f009bb98
> >             reg:  00000000.000000a8
> >             compatible: 'i2c-at24c64'
> >             device_type: 'fru-prom'
> >             name: 'riser-fru-prom'
> >=20
> >         Node 0xf009be44
> >             .node:  f009be44
> >             reg:  00000000.000000aa
> >             compatible: 'i2c-at24c64'
> >             device_type: 'fru-prom'
> >             name: 'riser-fru-prom'
> >=20
> >         Node 0xf009c0f0
> >             .node:  f009c0f0
> >             reg:  00000000.000000b0
> >             compatible: 'i2c-adt7462'
> >             name: 'hardware-monitor'
> >=20
> >         Node 0xf009c1bc
> >             .node:  f009c1bc
> >             reg:  00000000.000000d0
> >             compatible: 'i2c-ds1307'
> >             name: 'rscrtc'
> >=20
> >         Node 0xf009c27c
> >             .node:  f009c27c
> >             reg:  00000000.000000dc
> >             compatible: 'i2c-ics9fg108'
> >             name: 'clock-generator'
> >=20
> >         Node 0xf009c34c
> >             .node:  f009c34c
> >             reg:  00000000.000000e0
> >             compatible: 'i2c-at34c02'
> >             name: 'dimm-spd'
> >=20
> >         Node 0xf009c50c
> >             .node:  f009c50c
> >             reg:  00000000.000000e2
> >             compatible: 'i2c-at34c02'
> >             name: 'dimm-spd'
> >=20
> >=20
> >>
> >> If you could not boot up with 4.2-rc2, dump above information
> >> with 4.1.0. We want to know what the pcie tree in your machine, thanks!
> >>
> >> Thanks!
> >> Yijing.
> >>
> >> =1B$B:_=1B(J 2015/8/13 2:56, Meelis Roos =1B$B<LF;=1B(J:
> >>> 4.1.0 worked but 4.2-rc2 hangs on boot after switching console but=20
> >>> before reprinting dmesg to the new console. That happens on 2 of my=20
> >>> sparc64's: T2000 and V245. These happen to have the PCIe slot names i=
n=20
> >>> sysfs so it may be related. The following commit breaks the boot at=20
> >>> least on V245 where I performed the bisection:
> >>>
> >>> d0751b98dfa391f862e02dc36a233a54615e3f1d is the first bad commit
> >>> commit d0751b98dfa391f862e02dc36a233a54615e3f1d
> >>> Author: Yijing Wang <wangyijing@huawei.com>
> >>> Date:   Thu May 21 15:05:02 2015 +0800
> >>>
> >>>     PCI: Add dev->has_secondary_link to track downstream PCIe links
> >>>
> >>>     A PCIe Port is an interface to a Link.  A Root Port is a PCI-PCI =
bridge in
> >>>     a Root Complex and has a Link on its secondary (downstream) side.=
  For
> >>>     other Ports, the Link may be on either the upstream (closer to th=
e Root
> >>>     Complex) or downstream side of the Port.
> >>>
> >>>     The usual topology has a Root Port connected to an Upstream Port.=
  We
> >>>     previously assumed this was the only possible topology, and that a
> >>>     Downstream Port's Link was always on its downstream side, like th=
is:
> >>>
> >>>                       +---------------------+
> >>>       +------+        |          Downstream |
> >>>       | Root |        | Upstream       Port +--Link--
> >>>       | Port +--Link--+ Port                |
> >>>       +------+        |          Downstream |
> >>>                       |                Port +--Link--
> >>>                       +---------------------+
> >>>
> >>>     But systems do exist (see URL below) where the Root Port is conne=
cted to a
> >>>     Downstream Port.  In this case, a Downstream Port's Link may be o=
n either
> >>>     the upstream or downstream side:
> >>>
> >>>                       +---------------------+
> >>>       +------+        |            Upstream |
> >>>       | Root |        | Downstream     Port +--Link--
> >>>       | Port +--Link--+ Port                |
> >>>       +------+        |          Downstream |
> >>>                       |                Port +--Link--
> >>>                       +---------------------+
> >>>
> >>>     We can't use the Port type to determine which side the Link is on=
, so add a
> >>>     bit in struct pci_dev to keep track.
> >>>
> >>>     A Root Port's Link is always on the Port's secondary side.  A com=
ponent
> >>>     (Endpoint or Port) on the other end of the Link obviously has the=
 Link on
> >>>     its upstream side.  If that component is a Port, it is part of a =
Switch or
> >>>     a Bridge.  A Bridge has a PCI or PCI-X bus on its secondary side,=
 not a
> >>>     Link.  The internal bus of a Switch connects the Port to another =
Port whose
> >>>     Link is on the downstream side.
> >>>
> >>>     [bhelgaas: changelog, comment, cache "type", use if/else]
> >>>     Link: http://lkml.kernel.org/r/54EB81B2.4050904@pobox.com
> >>>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=94361
> >>>     Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>     Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>
> >>> :040000 040000 3ab85bca5c0a1bdb75f7b83131482fe63110c96f dc49c2621bd45=
0d16eea33491a27affc1dab35ce M      drivers
> >>> :040000 040000 37493ef5238ad154ccad6a184617975e8502730e ef846910636ac=
2405879bcf5395e261df396e266 M      include
> >>>
> >>>
> >>
> >=20
>=20

--=20
Meelis Roos (mroos@linux.ee)
