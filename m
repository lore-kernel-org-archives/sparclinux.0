From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Oct 2013 15:37:21 +0000
Subject: Hang on T2000 in pci_apply_final_quirks() when enabling USB controllers
Message-Id: <alpine.SOC.1.00.1310101827140.25198@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Recently I got a T2000. Installed Debian Wheezy on it (bare metal, no=20
virtualization) without a problem. However, neither my 3.11 kernel nor=20
Debians 3.10 boot on this hardware. Below is full dmesg with=20
debug_initcall, but it gets stuck in enabling USB host controllers.=20
Usually it hangs on the first PCI HCI (0001:05:05.0), once I have seen=20
second one too a lot later (0001:05:05.0).

lspci, .config for my 3.11, prtconf -pv and dmesg are below.

lspci:
0000:02:00.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at 00100000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=02, secondary=03, subordinate=07, sec-latency=3D0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00200000-007fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0000:03:01.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00200000-002fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0000:03:02.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=05, subordinate=05, sec-latency=3D0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0000:03:08.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=06, subordinate=06, sec-latency=3D0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #224, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0000:03:09.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=07, subordinate=07, sec-latency=3D0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00300000-007fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #9, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0000:04:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Etherne=
t Controller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 119
	Region 0: Memory at 00200000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: I/O ports at <unassigned>
	Region 3: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L=
1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-14-4f-ff-ff-86-99-26
	Kernel driver in use: e1000e

0000:04:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Etherne=
t Controller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 120
	Region 0: Memory at 00220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: I/O ports at 0020 [size2]
	Region 3: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff1600000000 [disabled] [size=3D1]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0001
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L=
1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-14-4f-ff-ff-86-99-26
	Kernel driver in use: e1000e

0000:07:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1064ET P=
CI-Express Fusion-MPT SAS (rev 02)
	Subsystem: LSI Logic / Symbios Logic Device 1000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 512 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 1000 [disabled] [size%6]
	Region 1: Memory at 00300000 (64-bit, non-prefetchable) [sizedK]
	Region 3: Memory at 00310000 (64-bit, non-prefetchable) [sizedK]
	Region 5: [virtual] Memory at ffffff1600000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at 00400000 [disabled] [size=3D4M]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [68] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <64ns, =
L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [98] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
		Vector table: BAR=3D1 offset=00002000
		PBA: BAR=3D1 offset=00003000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: mptsas

0001:02:00.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at 00100000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=02, secondary=03, subordinate	, sec-latency=3D0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00200000-030fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0001:03:01.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=04, subordinate=06, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00200000-02ffffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0001:03:02.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=07, subordinate=07, sec-latency=3D0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 03000000-030fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0001:03:08.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary=08, subordinate=08, sec-latency=3D0
	I/O behind bridge: 00002000-00001fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #225, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0001:03:09.0 PCI bridge: PLX Technology, Inc. PEX 8532  Versatile PCI Expre=
ss Switch (rev bc) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=03, secondary	, subordinate	, sec-latency=3D0
	I/O behind bridge: 00002000-00001fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #9, Speed 2.5GT/s, Width x8, ASPM L0s L1, Latency L0 <2us, L=
1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #226, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32+ WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		Port Arbitration Table [1b8] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-

0001:04:00.0 PCI bridge: Intel Corporation 41210 [Lanai] Serial to Parallel=
 PCI Bridge (A-Segment Bridge) (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00200000-02ffffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency L0 unlimited,=
 L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d8] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=3Dconv
		Status: Dev=04:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacitye535 CommitmentLimite535
		Downstream: Capacitye535 CommitmentLimite535
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [300 v1] Power Budgeting <?>

0001:04:00.2 PCI bridge: Intel Corporation 41210 [Lanai] Serial to Parallel=
 PCI Bridge (B-Segment Bridge) (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=04, secondary=06, subordinate=06, sec-latencyd
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency L0 unlimited,=
 L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d8] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
		Status: Dev=04:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacitye535 CommitmentLimite535
		Downstream: Capacitye535 CommitmentLimite535
 	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [300 v1] Power Budgeting <?>

0001:05:02.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA =
Bridge [Aladdin IV/V/V+]
	Subsystem: ULi Electronics Inc. ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] I/O ports at <unassigned>
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-

0001:05:05.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 0=
3) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at 01000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: ohci_hcd

0001:05:06.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 0=
3) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 02000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: ohci_hcd

0001:05:08.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c4) (prog-i=
f ff)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at 0100 [size=3D8]
	Region 1: I/O ports at 0118 [size=3D8]
	Region 2: I/O ports at 0110 [size=3D8]
	Region 3: I/O ports at 0108 [size=3D8]
	Region 4: I/O ports at 0120 [size=16]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pata_ali

0001:07:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Etherne=
t Controller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at 03000000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: I/O ports at 1000 [size2]
	Region 3: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L=
1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-14-4f-ff-ff-86-99-28
	Kernel driver in use: e1000e

0001:07:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Etherne=
t Controller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 122
	Region 0: Memory at 03020000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: I/O ports at 1020 [size2]
	Region 3: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at ffffff0e00000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at ffffff0e00000000 [disabled] [size=3D1]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0001
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L=
1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-14-4f-ff-ff-86-99-28
	Kernel driver in use: e1000e

config:
#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 3.11.0 Kernel Configuration
#
CONFIG_64BIT=3Dy
CONFIG_SPARC=3Dy
# CONFIG_SPARC32 is not set
CONFIG_SPARC64=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/sparc/configs/sparc64_defconfig"
CONFIG_IOMMU_HELPER=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_MMU=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=3Dy

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT2
CONFIG_CROSS_COMPILE=3D""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_FHANDLE=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_AUDIT_WATCH=3Dy
CONFIG_AUDIT_TREE=3Dy
# CONFIG_AUDIT_LOGINUID_IMMUTABLE is not set
CONFIG_HAVE_GENERIC_HARDIRQS=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_IRQ_PREFLOW_FASTEOI=3Dy
CONFIG_IRQ_DOMAIN=3Dy
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_PREEMPT_RCU is not set
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_FANOUT2
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
CONFIG_RCU_FAST_NO_HZ=3Dy
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_RESOURCE_COUNTERS=3Dy
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CGROUP_PERF=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_BLK_CGROUP=3Dy
# CONFIG_DEBUG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_RD_LZ4=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_KPROBES=3Dy
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_NMI_WATCHDOG=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_HAVE_RCU_TABLE_FREE=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_ODD_RT_SIGACTION=3Dy
CONFIG_OLD_SIGSUSPEND=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
# CONFIG_BLK_DEV_THROTTLING is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=3Dy
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_CFQ_GROUP_IOSCHED=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_PADATA=3Dy
CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
CONFIG_INLINE_READ_UNLOCK=3Dy
CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
CONFIG_INLINE_WRITE_UNLOCK=3Dy
CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_FREEZER=3Dy

#
# Processor type and features
#
CONFIG_SMP=3Dy
CONFIG_NR_CPUS%6
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ%0
CONFIG_SCHED_HRTICK=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_SPARC64_SMP=3Dy
CONFIG_EARLYFB=3Dy
CONFIG_SECCOMP=3Dy
# CONFIG_HOTPLUG_CPU is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dm
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dm
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm

#
# SPARC CPU frequency scaling drivers
#
# CONFIG_SPARC_US3_CPUFREQ is not set
# CONFIG_SPARC_US2E_CPUFREQ is not set
CONFIG_US3_MC=3Dy
# CONFIG_NUMA is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_NO_BOOTMEM=3Dy
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_BALLOON_COMPACTION=3Dy
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D0
CONFIG_NEED_BOUNCE_POOL=3Dy
CONFIG_KSM=3Dy
CONFIG_DEFAULT_MMAP_MIN_ADDR@96
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_ZBUD is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM_RUNTIME is not set
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options (PCI etc.)
#
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
CONFIG_SUN_LDOMS=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_SYSCALL=3Dy
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=3Dm
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_IOV=3Dy
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set

#
# PCI host controller drivers
#
# CONFIG_PCCARD is not set
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_SPARC64_PCI=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_KEYS_COMPAT=3Dy
CONFIG_NET=3Dy
CONFIG_COMPAT_NETLINK_MESSAGES=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=3Dy
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
CONFIG_XFRM_USER=3Dm
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_FIB_TRIE_STATS=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
CONFIG_IP_PNP=3Dy
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE_DEMUX=3Dm
CONFIG_NET_IP_TUNNEL=3Dm
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_ARPD=3Dy
CONFIG_SYN_COOKIES=3Dy
# CONFIG_NET_IPVTI is not set
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
# CONFIG_INET_UDP_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dy
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_SNMP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE_CT is not set
CONFIG_NETFILTER_TPROXY=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm
CONFIG_NETFILTER_XT_SET=3Dm

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
CONFIG_NETFILTER_XT_TARGET_LED=3Dm
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
CONFIG_IP_SET=3Dm
CONFIG_IP_SET_MAX%6
CONFIG_IP_SET_BITMAP_IP=3Dm
CONFIG_IP_SET_BITMAP_IPMAC=3Dm
CONFIG_IP_SET_BITMAP_PORT=3Dm
CONFIG_IP_SET_HASH_IP=3Dm
CONFIG_IP_SET_HASH_IPPORT=3Dm
CONFIG_IP_SET_HASH_IPPORTIP=3Dm
CONFIG_IP_SET_HASH_IPPORTNET=3Dm
CONFIG_IP_SET_HASH_NET=3Dm
CONFIG_IP_SET_HASH_NETPORT=3Dm
CONFIG_IP_SET_HASH_NETIFACE=3Dm
CONFIG_IP_SET_LIST_SET=3Dm
CONFIG_IP_VS=3Dm
CONFIG_IP_VS_IPV6=3Dy
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_AH_ESP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy
CONFIG_IP_VS_PROTO_SCTP=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=3D8

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=3Dy
CONFIG_IP_VS_PE_SIP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
# CONFIG_NF_NAT_IPV4 is not set
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm
# CONFIG_NF_NAT_IPV6 is not set

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_NET_DCCPPROBE=3Dm
CONFIG_IP_SCTP=3Dm
CONFIG_NET_SCTPPROBE=3Dm
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=3Dy
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_RDS=3Dm
CONFIG_RDS_RDMA=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_PORTS=8191
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=3Dm
CONFIG_L2TP_DEBUGFS=3Dm
CONFIG_L2TP_V3=3Dy
CONFIG_L2TP_IP=3Dm
CONFIG_L2TP_ETH=3Dm
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=3Dy
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=3Dm
CONFIG_DECNET_ROUTER=3Dy
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=3Dm
CONFIG_DEV_APPLETALK=3Dm
CONFIG_IPDDP=3Dm
CONFIG_IPDDP_ENCAP=3Dy
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=3Dm
CONFIG_IEEE802154=3Dm
CONFIG_IEEE802154_6LOWPAN=3Dm
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFB=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
CONFIG_NET_SCH_MQPRIO=3Dm
CONFIG_NET_SCH_CHOKE=3Dm
CONFIG_NET_SCH_QFQ=3Dm
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
# CONFIG_NET_SCH_PLUG is not set

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dy
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK2
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPSET is not set
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dy
CONFIG_BATMAN_ADV=3Dm
CONFIG_BATMAN_ADV_BLA=3Dy
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_NET_MPLS_GSO is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
# CONFIG_NETPRIO_CGROUP is not set
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_NET_TCPPROBE is not set
CONFIG_NET_DROP_MONITOR=3Dy
# CONFIG_HAMRADIO is not set
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
CONFIG_CAN_SLCAN=3Dm
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_MCP251X=3Dm
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_SJA1000=3Dm
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
# CONFIG_CAN_SJA1000_OF_PLATFORM is not set
CONFIG_CAN_EMS_PCI=3Dm
CONFIG_CAN_PEAK_PCI=3Dm
CONFIG_CAN_PEAK_PCIEC=3Dy
CONFIG_CAN_KVASER_PCI=3Dm
CONFIG_CAN_PLX_PCI=3Dm
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set

#
# CAN USB interfaces
#
CONFIG_CAN_EMS_USB=3Dm
CONFIG_CAN_ESD_USB2=3Dm
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_8DEV_USB is not set
CONFIG_CAN_SOFTING=3Dm
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_AF_RXRPC=3Dm
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=3Dm
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_WIRELESS_EXT=3Dy
CONFIG_WEXT_CORE=3Dy
CONFIG_WEXT_PROC=3Dy
CONFIG_WEXT_SPY=3Dy
CONFIG_WEXT_PRIV=3Dy
CONFIG_CFG80211=3Dm
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=3Dy
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=3Dy
CONFIG_LIB80211=3Dm
CONFIG_LIB80211_CRYPT_WEP=3Dm
CONFIG_LIB80211_CRYPT_CCMP=3Dm
CONFIG_LIB80211_CRYPT_TKIP=3Dm
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
CONFIG_MAC80211_MESH=3Dy
CONFIG_MAC80211_LEDS=3Dy
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_WIMAX=3Dm
CONFIG_WIMAX_DEBUG_LEVEL=3D8
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
# CONFIG_RFKILL_REGULATOR is not set
CONFIG_NET_9P=3Dm
CONFIG_NET_9P_VIRTIO=3Dm
CONFIG_NET_9P_RDMA=3Dm
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=3Dm
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=3Dm
CONFIG_NFC_NCI=3Dm
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_PN533=3Dm
# CONFIG_NFC_SIM is not set
CONFIG_HAVE_BPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D""
CONFIG_DEVTMPFS=3Dy
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=3D""
CONFIG_FW_LOADER_USER_HELPER=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dm
CONFIG_DMA_SHARED_BUFFER=3Dy

#
# Bus devices
#
CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy
# CONFIG_MTD is not set
CONFIG_OF=3Dy

#
# Device Tree and Open Firmware support
#
# CONFIG_OF_SELFTEST is not set
CONFIG_OF_PROMTREE=3Dy
CONFIG_OF_I2C=3Dm
CONFIG_OF_NET=3Dy
CONFIG_OF_MDIO=3Dm
CONFIG_OF_PCI=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_SUNBPP=3Dm
CONFIG_PARPORT_AX88796=3Dm
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_DRBD=3Dm
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_NVME is not set
CONFIG_BLK_DEV_OSD=3Dm
CONFIG_BLK_DEV_SX8=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=3Dm
CONFIG_SUNVDC=3Dm
CONFIG_VIRTIO_BLK=3Dm
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_RBD=3Dm
# CONFIG_BLK_DEV_RSXX is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=3Dm
CONFIG_AD525X_DPOT=3Dm
CONFIG_AD525X_DPOT_I2C=3Dm
CONFIG_AD525X_DPOT_SPI=3Dm
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=3Dm
CONFIG_TIFM_CORE=3Dm
CONFIG_TIFM_7XX1=3Dm
CONFIG_ICS932S401=3Dm
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=3Dm
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=3Dm
CONFIG_ISL29003=3Dm
CONFIG_ISL29020=3Dm
CONFIG_SENSORS_TSL2550=3Dm
CONFIG_SENSORS_BH1780=3Dm
CONFIG_SENSORS_BH1770=3Dm
CONFIG_SENSORS_APDS990X=3Dm
CONFIG_HMC6352=3Dm
CONFIG_DS1682=3Dm
CONFIG_TI_DAC7512=3Dm
# CONFIG_BMP085_I2C is not set
# CONFIG_BMP085_SPI is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_C2PORT=3Dm

#
# EEPROM support
#
CONFIG_EEPROM_AT24=3Dm
CONFIG_EEPROM_AT25=3Dm
CONFIG_EEPROM_LEGACY=3Dm
CONFIG_EEPROM_MAX6875=3Dm
CONFIG_EEPROM_93CX6=3Dm
# CONFIG_EEPROM_93XX46 is not set
CONFIG_CB710_CORE=3Dm
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_SPI is not set
CONFIG_SENSORS_LIS3_I2C=3Dm

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_TGT=3Dm
CONFIG_SCSI_NETLINK=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_FC_TGT_ATTRS=3Dy
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dy
CONFIG_SCSI_SAS_LIBSAS=3Dm
CONFIG_SCSI_SAS_ATA=3Dy
CONFIG_SCSI_SAS_HOST_SMP=3Dy
CONFIG_SCSI_SRP_ATTRS=3Dm
CONFIG_SCSI_SRP_TGT_ATTRS=3Dy
CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
CONFIG_ISCSI_BOOT_SYSFS=3Dm
CONFIG_SCSI_CXGB3_ISCSI=3Dm
CONFIG_SCSI_CXGB4_ISCSI=3Dm
CONFIG_SCSI_BNX2_ISCSI=3Dm
CONFIG_SCSI_BNX2X_FCOE=3Dm
CONFIG_BE2ISCSI=3Dm
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
CONFIG_SCSI_HPSA=3Dm
CONFIG_SCSI_3W_9XXX=3Dm
CONFIG_SCSI_3W_SAS=3Dm
CONFIG_SCSI_ACARD=3Dm
CONFIG_SCSI_AACRAID=3Dm
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE2
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
CONFIG_SCSI_AIC79XX=3Dm
CONFIG_AIC79XX_CMDS_PER_DEVICE2
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_ENABLE=3Dy
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC94XX=3Dm
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=3Dm
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=3Dm
CONFIG_SCSI_ARCMSR=3Dm
CONFIG_MEGARAID_NEWGEN=3Dy
CONFIG_MEGARAID_MM=3Dm
CONFIG_MEGARAID_MAILBOX=3Dm
CONFIG_MEGARAID_LEGACY=3Dm
CONFIG_MEGARAID_SAS=3Dm
CONFIG_SCSI_MPT2SAS=3Dm
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS_LOGGING is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_SCSI_HPTIOP=3Dm
CONFIG_LIBFC=3Dm
CONFIG_LIBFCOE=3Dm
CONFIG_FCOE=3Dm
CONFIG_SCSI_DMX3191D=3Dm
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=3Dm
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=3Dm
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGSd
CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
CONFIG_SCSI_IPR=3Dm
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=3Dm
CONFIG_SCSI_QLOGICPTI=3Dm
CONFIG_SCSI_QLA_FC=3Dm
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=3Dm
CONFIG_SCSI_LPFC=3Dm
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_DC395x=3Dm
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_SUNESP=3Dm
CONFIG_SCSI_PMCRAID=3Dm
CONFIG_SCSI_PM8001=3Dm
CONFIG_SCSI_SRP=3Dm
CONFIG_SCSI_BFA_FC=3Dm
CONFIG_SCSI_VIRTIO=3Dm
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=3Dm
CONFIG_SCSI_DH_RDAC=3Dm
CONFIG_SCSI_DH_HP_SW=3Dm
CONFIG_SCSI_DH_EMC=3Dm
CONFIG_SCSI_DH_ALUA=3Dm
CONFIG_SCSI_OSD_INITIATOR=3Dm
CONFIG_SCSI_OSD_ULD=3Dm
CONFIG_SCSI_OSD_DPRINT_SENSE=3D1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=3Dm
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dm
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_SATA_INIC162X=3Dm
CONFIG_SATA_ACARD_AHCI=3Dm
CONFIG_SATA_SIL24=3Dm
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=3Dm
CONFIG_SATA_QSTOR=3Dm
CONFIG_SATA_SX4=3Dm
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=3Dm
# CONFIG_SATA_HIGHBANK is not set
CONFIG_SATA_MV=3Dm
CONFIG_SATA_NV=3Dm
CONFIG_SATA_PROMISE=3Dm
# CONFIG_SATA_RCAR is not set
CONFIG_SATA_SIL=3Dm
CONFIG_SATA_SIS=3Dm
CONFIG_SATA_SVW=3Dm
CONFIG_SATA_ULI=3Dm
CONFIG_SATA_VIA=3Dm
CONFIG_SATA_VITESSE=3Dm

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=3Dm
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=3Dm
# CONFIG_PATA_ATIIXP is not set
CONFIG_PATA_ATP867X=3Dm
CONFIG_PATA_CMD64X=3Dm
CONFIG_PATA_CS5520=3Dm
CONFIG_PATA_CS5530=3Dm
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
CONFIG_PATA_IT8213=3Dm
CONFIG_PATA_IT821X=3Dm
CONFIG_PATA_JMICRON=3Dm
CONFIG_PATA_MARVELL=3Dm
CONFIG_PATA_NETCELL=3Dm
CONFIG_PATA_NINJA32=3Dm
CONFIG_PATA_NS87415=3Dm
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=3Dm
CONFIG_PATA_PDC_OLD=3Dm
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=3Dm
# CONFIG_PATA_SC1200 is not set
CONFIG_PATA_SCH=3Dm
CONFIG_PATA_SERVERWORKS=3Dm
CONFIG_PATA_SIL680=3Dm
CONFIG_PATA_SIS=3Dm
CONFIG_PATA_TOSHIBA=3Dm
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=3Dm
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
CONFIG_PATA_NS87410=3Dm
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_ATA_GENERIC=3Dm
CONFIG_PATA_LEGACY=3Dm
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=3Dm
CONFIG_DM_BIO_PRISON=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
# CONFIG_DM_CACHE is not set
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_RAID=3Dm
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
CONFIG_DM_DELAY=3Dm
CONFIG_DM_UEVENT=3Dy
CONFIG_DM_FLAKEY=3Dm
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
CONFIG_TARGET_CORE=3Dm
CONFIG_TCM_IBLOCK=3Dm
CONFIG_TCM_FILEIO=3Dm
CONFIG_TCM_PSCSI=3Dm
CONFIG_LOOPBACK_TARGET=3Dm
CONFIG_TCM_FC=3Dm
CONFIG_ISCSI_TARGET=3Dm
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=3Dy
CONFIG_FUSION_SPI=3Dm
CONFIG_FUSION_FC=3Dm
CONFIG_FUSION_SAS=3Dy
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=3Dm
CONFIG_FUSION_LAN=3Dm
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
CONFIG_FIREWIRE_NOSY=3Dm
# CONFIG_I2O is not set
CONFIG_NETDEVICES=3Dy
CONFIG_MII=3Dm
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_NET_FC=3Dy
CONFIG_IFB=3Dm
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=3Dm
CONFIG_MACVTAP=3Dm
# CONFIG_VXLAN is not set
CONFIG_NETCONSOLE=3Dm
CONFIG_NETCONSOLE_DYNAMIC=3Dy
CONFIG_NETPOLL=3Dy
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_TUN=3Dm
CONFIG_VETH=3Dm
CONFIG_VIRTIO_NET=3Dm
# CONFIG_NLMON is not set
CONFIG_SUNGEM_PHY=3Dm
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=3Dy
CONFIG_ATM_DUMMY=3Dm
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
CONFIG_ATM_NICSTAR=3Dm
CONFIG_ATM_NICSTAR_USE_SUNI=3Dy
CONFIG_ATM_NICSTAR_USE_IDT77105=3Dy
# CONFIG_ATM_IDT77252 is not set
CONFIG_ATM_IA=3Dm
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=3Dm
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=3D0
# CONFIG_ATM_HE is not set
CONFIG_ATM_SOLOS=3Dm

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
# CONFIG_NET_DSA_MV88E6131 is not set
# CONFIG_NET_DSA_MV88E6123_61_65 is not set
CONFIG_ETHERNET=3Dy
CONFIG_MDIO=3Dm
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
CONFIG_NET_VENDOR_ADAPTEC=3Dy
CONFIG_ADAPTEC_STARFIRE=3Dm
# CONFIG_GRETH is not set
CONFIG_NET_VENDOR_ALTEON=3Dy
CONFIG_ACENIC=3Dm
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_NET_VENDOR_AMD=3Dy
# CONFIG_AMD8111_ETH is not set
CONFIG_PCNET32=3Dm
CONFIG_SUNLANCE=3Dm
CONFIG_NET_VENDOR_ARC=3Dy
CONFIG_NET_VENDOR_ATHEROS=3Dy
CONFIG_ATL2=3Dm
CONFIG_ATL1=3Dm
CONFIG_ATL1E=3Dm
CONFIG_ATL1C=3Dm
CONFIG_ALX=3Dm
CONFIG_NET_CADENCE=3Dy
# CONFIG_ARM_AT91_ETHER is not set
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
CONFIG_B44=3Dm
CONFIG_B44_PCI_AUTOSELECT=3Dy
CONFIG_B44_PCICORE_AUTOSELECT=3Dy
CONFIG_B44_PCI=3Dy
CONFIG_BNX2=3Dm
CONFIG_CNIC=3Dm
CONFIG_TIGON3=3Dm
CONFIG_BNX2X=3Dm
CONFIG_BNX2X_SRIOV=3Dy
CONFIG_NET_VENDOR_BROCADE=3Dy
CONFIG_BNA=3Dm
# CONFIG_NET_CALXEDA_XGMAC is not set
CONFIG_NET_VENDOR_CHELSIO=3Dy
CONFIG_CHELSIO_T1=3Dm
CONFIG_CHELSIO_T1_1G=3Dy
CONFIG_CHELSIO_T3=3Dm
CONFIG_CHELSIO_T4=3Dm
CONFIG_CHELSIO_T4VF=3Dm
CONFIG_NET_VENDOR_CISCO=3Dy
CONFIG_ENIC=3Dm
CONFIG_DNET=3Dm
CONFIG_NET_VENDOR_DEC=3Dy
CONFIG_NET_TULIP=3Dy
# CONFIG_DE2104X is not set
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=3Dy
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
CONFIG_TULIP_DM910X=3Dy
# CONFIG_DE4X5 is not set
CONFIG_WINBOND_840=3Dm
CONFIG_DM9102=3Dm
CONFIG_ULI526X=3Dm
CONFIG_NET_VENDOR_DLINK=3Dy
CONFIG_DL2K=3Dm
CONFIG_SUNDANCE=3Dm
CONFIG_SUNDANCE_MMIO=3Dy
CONFIG_NET_VENDOR_EMULEX=3Dy
CONFIG_BE2NET=3Dm
CONFIG_NET_VENDOR_EXAR=3Dy
CONFIG_S2IO=3Dm
CONFIG_VXGE=3Dm
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_HP=3Dy
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_INTEL=3Dy
CONFIG_E100=3Dm
CONFIG_E1000=3Dm
CONFIG_E1000E=3Dm
CONFIG_IGB=3Dm
CONFIG_IGB_HWMON=3Dy
CONFIG_IGBVF=3Dm
CONFIG_IXGB=3Dm
CONFIG_IXGBE=3Dm
CONFIG_IXGBE_HWMON=3Dy
CONFIG_IXGBE_DCB=3Dy
CONFIG_IXGBEVF=3Dm
CONFIG_NET_VENDOR_I825XX=3Dy
CONFIG_IP1000=3Dm
CONFIG_JME=3Dm
CONFIG_NET_VENDOR_MARVELL=3Dy
# CONFIG_MVMDIO is not set
CONFIG_SKGE=3Dm
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=3Dy
CONFIG_SKY2=3Dm
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=3Dy
CONFIG_MLX4_EN=3Dm
CONFIG_MLX4_EN_DCB=3Dy
CONFIG_MLX4_CORE=3Dm
CONFIG_MLX4_DEBUG=3Dy
CONFIG_NET_VENDOR_MICREL=3Dy
CONFIG_KS8851=3Dm
CONFIG_KS8851_MLL=3Dm
CONFIG_KSZ884X_PCI=3Dm
CONFIG_NET_VENDOR_MICROCHIP=3Dy
CONFIG_ENC28J60=3Dm
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_NET_VENDOR_MYRI=3Dy
CONFIG_MYRI10GE=3Dm
CONFIG_FEALNX=3Dm
CONFIG_NET_VENDOR_NATSEMI=3Dy
CONFIG_NATSEMI=3Dm
CONFIG_NS83820=3Dm
CONFIG_NET_VENDOR_8390=3Dy
CONFIG_NE2K_PCI=3Dm
CONFIG_NET_VENDOR_NVIDIA=3Dy
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=3Dy
CONFIG_ETHOC=3Dm
CONFIG_NET_PACKET_ENGINE=3Dy
CONFIG_HAMACHI=3Dm
CONFIG_YELLOWFIN=3Dm
CONFIG_NET_VENDOR_QLOGIC=3Dy
CONFIG_QLA3XXX=3Dm
CONFIG_QLCNIC=3Dm
CONFIG_QLCNIC_SRIOV=3Dy
CONFIG_QLGE=3Dm
CONFIG_NETXEN_NIC=3Dm
CONFIG_NET_VENDOR_REALTEK=3Dy
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=3Dm
# CONFIG_SH_ETH is not set
CONFIG_NET_VENDOR_RDC=3Dy
CONFIG_R6040=3Dm
CONFIG_NET_VENDOR_SEEQ=3Dy
CONFIG_NET_VENDOR_SILAN=3Dy
CONFIG_SC92031=3Dm
CONFIG_NET_VENDOR_SIS=3Dy
CONFIG_SIS900=3Dm
CONFIG_SIS190=3Dm
CONFIG_SFC=3Dm
CONFIG_SFC_MCDI_MON=3Dy
CONFIG_SFC_SRIOV=3Dy
CONFIG_NET_VENDOR_SMSC=3Dy
CONFIG_EPIC100=3Dm
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=3Dm
CONFIG_NET_VENDOR_STMICRO=3Dy
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=3Dy
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNBMAC=3Dm
CONFIG_SUNQE=3Dm
CONFIG_SUNGEM=3Dm
CONFIG_CASSINI=3Dm
CONFIG_SUNVNET=3Dm
CONFIG_NIU=3Dm
CONFIG_NET_VENDOR_TEHUTI=3Dy
CONFIG_TEHUTI=3Dm
CONFIG_NET_VENDOR_TI=3Dy
CONFIG_TLAN=3Dm
CONFIG_NET_VENDOR_VIA=3Dy
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_VELOCITY=3Dm
CONFIG_NET_VENDOR_WIZNET=3Dy
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_FDDI=3Dy
CONFIG_DEFXX=3Dm
# CONFIG_DEFXX_MMIO is not set
CONFIG_SKFP=3Dm
# CONFIG_HIPPI is not set
CONFIG_PHYLIB=3Dm

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
CONFIG_MARVELL_PHY=3Dm
CONFIG_DAVICOM_PHY=3Dm
CONFIG_QSEMI_PHY=3Dm
CONFIG_LXT_PHY=3Dm
CONFIG_CICADA_PHY=3Dm
CONFIG_VITESSE_PHY=3Dm
CONFIG_SMSC_PHY=3Dm
CONFIG_BROADCOM_PHY=3Dm
# CONFIG_BCM87XX_PHY is not set
CONFIG_ICPLUS_PHY=3Dm
CONFIG_REALTEK_PHY=3Dm
CONFIG_NATIONAL_PHY=3Dm
CONFIG_STE10XP=3Dm
CONFIG_LSI_ET1011C_PHY=3Dm
CONFIG_MICREL_PHY=3Dm
CONFIG_MDIO_BITBANG=3Dm
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOATM=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPTP=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLHC=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# USB Network Adapters
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
# CONFIG_USB_RTL8152 is not set
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_AX88179_178A=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dm
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_USB_NET_CX82310_ETH=3Dm
CONFIG_USB_NET_KALMIA=3Dm
# CONFIG_USB_NET_QMI_WWAN is not set
CONFIG_USB_HSO=3Dm
CONFIG_USB_NET_INT51X1=3Dm
CONFIG_USB_CDC_PHONET=3Dm
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
CONFIG_USB_VL600=3Dm
CONFIG_WLAN=3Dy
CONFIG_LIBERTAS_THINFIRM=3Dm
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=3Dm
# CONFIG_ATMEL is not set
CONFIG_AT76C50X_USB=3Dm
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_RTL8180=3Dm
CONFIG_RTL8187=3Dm
CONFIG_RTL8187_LEDS=3Dy
CONFIG_ADM8211=3Dm
CONFIG_MAC80211_HWSIM=3Dm
CONFIG_MWL8K=3Dm
# CONFIG_ATH_CARDS is not set
CONFIG_B43=3Dm
CONFIG_B43_BCMA=3Dy
CONFIG_B43_SSB=3Dy
CONFIG_B43_PCI_AUTOSELECT=3Dy
CONFIG_B43_PCICORE_AUTOSELECT=3Dy
CONFIG_B43_BCMA_PIO=3Dy
CONFIG_B43_PIO=3Dy
CONFIG_B43_PHY_N=3Dy
CONFIG_B43_PHY_LP=3Dy
CONFIG_B43_PHY_HT=3Dy
CONFIG_B43_LEDS=3Dy
CONFIG_B43_HWRNG=3Dy
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=3Dm
CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
CONFIG_B43LEGACY_LEDS=3Dy
CONFIG_B43LEGACY_HWRNG=3Dy
CONFIG_B43LEGACY_DEBUG=3Dy
CONFIG_B43LEGACY_DMA=3Dy
CONFIG_B43LEGACY_PIO=3Dy
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=3Dm
CONFIG_BRCMSMAC=3Dm
# CONFIG_BRCMFMAC is not set
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_HOSTAP_PLX=3Dm
CONFIG_HOSTAP_PCI=3Dm
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=3Dm
CONFIG_IPW2200_MONITOR=3Dy
CONFIG_IPW2200_RADIOTAP=3Dy
CONFIG_IPW2200_PROMISCUOUS=3Dy
CONFIG_IPW2200_QOS=3Dy
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=3Dm
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLWIFI=3Dm
CONFIG_IWLDVM=3Dm
# CONFIG_IWLMVM is not set
CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
CONFIG_IWLWIFI_P2P=3Dy
CONFIG_IWLEGACY=3Dm
CONFIG_IWL4965=3Dm
CONFIG_IWL3945=3Dm

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_LIBERTAS=3Dm
CONFIG_LIBERTAS_USB=3Dm
CONFIG_LIBERTAS_SPI=3Dm
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_LIBERTAS_MESH=3Dy
# CONFIG_HERMES is not set
CONFIG_P54_COMMON=3Dm
CONFIG_P54_USB=3Dm
CONFIG_P54_PCI=3Dm
CONFIG_P54_SPI=3Dm
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=3Dy
CONFIG_RT2X00=3Dm
CONFIG_RT2400PCI=3Dm
CONFIG_RT2500PCI=3Dm
CONFIG_RT61PCI=3Dm
CONFIG_RT2800PCI=3Dm
CONFIG_RT2800PCI_RT33XX=3Dy
CONFIG_RT2800PCI_RT35XX=3Dy
CONFIG_RT2800PCI_RT53XX=3Dy
CONFIG_RT2800PCI_RT3290=3Dy
CONFIG_RT2500USB=3Dm
CONFIG_RT73USB=3Dm
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT33XX=3Dy
CONFIG_RT2800USB_RT35XX=3Dy
CONFIG_RT2800USB_RT53XX=3Dy
# CONFIG_RT2800USB_RT55XX is not set
# CONFIG_RT2800USB_UNKNOWN is not set
CONFIG_RT2800_LIB=3Dm
CONFIG_RT2X00_LIB_MMIO=3Dm
CONFIG_RT2X00_LIB_PCI=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_CRYPTO=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
# CONFIG_RT2X00_DEBUG is not set
CONFIG_RTL_CARDS=3Dm
CONFIG_RTL8192CE=3Dm
CONFIG_RTL8192SE=3Dm
CONFIG_RTL8192DE=3Dm
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8188EE is not set
CONFIG_RTL8192CU=3Dm
CONFIG_RTLWIFI=3Dm
CONFIG_RTLWIFI_PCI=3Dm
CONFIG_RTLWIFI_USB=3Dm
CONFIG_RTLWIFI_DEBUG=3Dy
CONFIG_RTL8192C_COMMON=3Dm
# CONFIG_WL_TI is not set
CONFIG_ZD1211RW=3Dm
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_PCIE=3Dm
# CONFIG_MWIFIEX_USB is not set
# CONFIG_CW1200 is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=3Dm
CONFIG_WIMAX_I2400M_USB=3Dm
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=3Dm
CONFIG_IEEE802154_FAKEHARD=3Dm
CONFIG_VMXNET3=3Dm
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm
CONFIG_INPUT_SPARSEKMAP=3Dm
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ADP5588=3Dm
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=3Dm
CONFIG_KEYBOARD_LKKBD=3Dm
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_LM8323=3Dm
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=3Dm
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=3Dm
CONFIG_KEYBOARD_STOWAWAY=3Dm
CONFIG_KEYBOARD_SUNKBD=3Dy
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_CYPRESS=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_MOUSE_PS2_SENTELIC=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=3Dy
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
CONFIG_MOUSE_SYNAPTICS_USB=3Dm
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=3Dy
CONFIG_TABLET_USB_ACECAD=3Dm
CONFIG_TABLET_USB_AIPTEK=3Dm
CONFIG_TABLET_USB_GTCO=3Dm
CONFIG_TABLET_USB_HANWANG=3Dm
CONFIG_TABLET_USB_KBTAB=3Dm
CONFIG_TABLET_USB_WACOM=3Dm
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_SPARCSPKR=3Dm
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
CONFIG_INPUT_ATI_REMOTE2=3Dm
CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=3Dm
CONFIG_INPUT_YEALINK=3Dm
CONFIG_INPUT_CM109=3Dm
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=3Dm
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=3Dm
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=3Dm
CONFIG_N_GSM=3Dm
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=3Dm
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_MFD_HSU=3Dm
CONFIG_SERIAL_SUNCORE=3Dy
CONFIG_SERIAL_SUNZILOG=3Dy
CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy
CONFIG_SERIAL_SUNSU=3Dy
CONFIG_SERIAL_SUNSU_CONSOLE=3Dy
CONFIG_SERIAL_SUNSAB=3Dy
CONFIG_SERIAL_SUNSAB_CONSOLE=3Dy
CONFIG_SERIAL_SUNHV=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_HVC_DRIVER=3Dy
CONFIG_VIRTIO_CONSOLE=3Dm
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=3Dm
CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
CONFIG_HW_RANDOM_N2RNG=3Dm
CONFIG_HW_RANDOM_VIRTIO=3Dm
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dm
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_SMBUS=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=3Dm
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_OCORES=3Dm
CONFIG_I2C_PCA_PLATFORM=3Dm
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=3Dm
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=3Dm
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
CONFIG_I2C_TAOS_EVM=3Dm
CONFIG_I2C_TINY_USB=3Dm

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_BITBANG=3Dm
CONFIG_SPI_BUTTERFLY=3Dm
CONFIG_SPI_LM70_LLP=3Dm
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=3Dm
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=3Dm
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=3Dm
CONFIG_PPS_CLIENT_PARPORT=3Dm
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dm

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
CONFIG_GPIO_DEVRES=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=3Dm
# CONFIG_BATTERY_SBS is not set
CONFIG_BATTERY_BQ27x00=3Dm
CONFIG_BATTERY_BQ27X00_I2C=3Dy
CONFIG_BATTERY_BQ27X00_PLATFORM=3Dy
CONFIG_BATTERY_MAX17040=3Dm
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_CHARGER_PCF50633=3Dm
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=3Dm
CONFIG_SENSORS_AD7418=3Dm
CONFIG_SENSORS_ADCXX=3Dm
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=3Dm
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=3Dm
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=3Dm
CONFIG_SENSORS_ADT7462=3Dm
CONFIG_SENSORS_ADT7470=3Dm
CONFIG_SENSORS_ADT7475=3Dm
CONFIG_SENSORS_ASC7621=3Dm
CONFIG_SENSORS_ATXP1=3Dm
CONFIG_SENSORS_DS620=3Dm
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_I5K_AMB=3Dm
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=3Dm
CONFIG_SENSORS_F75375S=3Dm
CONFIG_SENSORS_G760A=3Dm
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_LINEAGE=3Dm
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=3Dm
CONFIG_SENSORS_LM73=3Dm
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=3Dm
CONFIG_SENSORS_LTC4151=3Dm
CONFIG_SENSORS_LTC4215=3Dm
CONFIG_SENSORS_LTC4245=3Dm
CONFIG_SENSORS_LTC4261=3Dm
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=3Dm
CONFIG_SENSORS_LM95245=3Dm
CONFIG_SENSORS_MAX1111=3Dm
CONFIG_SENSORS_MAX16065=3Dm
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=3Dm
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6639=3Dm
CONFIG_SENSORS_MAX6642=3Dm
CONFIG_SENSORS_MAX6650=3Dm
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=3Dm
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT21=3Dm
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_SMM665=3Dm
CONFIG_SENSORS_DME1737=3Dm
CONFIG_SENSORS_EMC1403=3Dm
CONFIG_SENSORS_EMC2103=3Dm
CONFIG_SENSORS_EMC6W201=3Dm
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=3Dm
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=3Dm
CONFIG_SENSORS_SCH5627=3Dm
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_ADS1015=3Dm
CONFIG_SENSORS_ADS7828=3Dm
CONFIG_SENSORS_ADS7871=3Dm
CONFIG_SENSORS_AMC6821=3Dm
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_THMC50=3Dm
CONFIG_SENSORS_TMP102=3Dm
CONFIG_SENSORS_TMP401=3Dm
CONFIG_SENSORS_TMP421=3Dm
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=3Dm
CONFIG_SENSORS_VT8231=3Dm
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83793=3Dm
CONFIG_SENSORS_W83795=3Dm
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=3Dm
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=3Dm
# CONFIG_SENSORS_ULTRA45 is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
CONFIG_SSB=3Dm
CONFIG_SSB_SPROM=3Dy
CONFIG_SSB_BLOCKIO=3Dy
CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
CONFIG_SSB_PCIHOST=3Dy
CONFIG_SSB_B43_PCI_BRIDGE=3Dy
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
CONFIG_SSB_DRIVER_PCICORE=3Dy
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
CONFIG_BCMA=3Dm
CONFIG_BCMA_BLOCKIO=3Dy
CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
CONFIG_BCMA_HOST_PCI=3Dy
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dm
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_HTC_PASIC3=3Dm
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=3Dm
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=3Dm
CONFIG_PCF50633_ADC=3Dm
CONFIG_PCF50633_GPIO=3Dm
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=3Dm
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_WL1273_CORE=3Dm
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_DUMMY is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dm
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dm
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_MAX1586=3Dm
CONFIG_REGULATOR_MAX8649=3Dm
CONFIG_REGULATOR_MAX8660=3Dm
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_LP3971=3Dm
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_PCF50633=3Dm
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=3Dm
CONFIG_REGULATOR_TPS6507X=3Dm
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_MEDIA_SUPPORT=3Dm

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_RC_SUPPORT is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_CYPRESS_FIRMWARE is not set

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#

#
# Customise DVB Frontends
#
CONFIG_DVB_TUNER_DIB0070=3Dm
CONFIG_DVB_TUNER_DIB0090=3Dm

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_DRM=3Dm
CONFIG_DRM_KMS_HELPER=3Dm
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=3Dm

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=3Dm
CONFIG_DRM_I2C_SIL164=3Dm
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_TDFX=3Dm
CONFIG_DRM_R128=3Dm
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_RADEON_UMS is not set
CONFIG_DRM_NOUVEAU=3Dm
CONFIG_NOUVEAU_DEBUG=3D5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_MGA=3Dm
CONFIG_DRM_VIA=3Dm
CONFIG_DRM_SAVAGE=3Dm
CONFIG_DRM_VMWGFX=3Dm
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
CONFIG_VGASTATE=3Dm
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_HDMI=3Dy
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_DDC=3Dm
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=3Dm
CONFIG_FB_SYS_COPYAREA=3Dm
CONFIG_FB_SYS_IMAGEBLIT=3Dm
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dm
CONFIG_FB_DEFERRED_IO=3Dy
CONFIG_FB_SVGALIB=3Dm
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_GRVGA is not set
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=3Dy
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_SBUS=3Dy
# CONFIG_FB_BW2 is not set
# CONFIG_FB_CG3 is not set
CONFIG_FB_CG6=3Dy
CONFIG_FB_FFB=3Dy
# CONFIG_FB_TCX is not set
# CONFIG_FB_CG14 is not set
# CONFIG_FB_P9100 is not set
# CONFIG_FB_LEO is not set
CONFIG_FB_XVR500=3Dy
CONFIG_FB_XVR2500=3Dy
CONFIG_FB_XVR1000=3Dy
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=3Dy
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=3Dy
CONFIG_FB_ATY128_BACKLIGHT=3Dy
CONFIG_FB_ATY=3Dy
CONFIG_FB_ATY_CT=3Dy
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=3Dy
CONFIG_FB_ATY_BACKLIGHT=3Dy
CONFIG_FB_S3=3Dm
CONFIG_FB_S3_DDC=3Dy
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=3Dm
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=3Dm
CONFIG_FB_PM3=3Dm
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_TMIO is not set
CONFIG_FB_SM501=3Dm
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=3Dm
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=3Dm
CONFIG_FB_MB862XX=3Dm
CONFIG_FB_MB862XX_PCI_GDC=3Dy
CONFIG_FB_MB862XX_I2C=3Dy
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_EXYNOS_VIDEO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LM3630 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_LOGO is not set
CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_MAX_CARDS2
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_RAWMIDI_SEQ=3Dm
CONFIG_SND_OPL3_LIB_SEQ=3Dm
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
CONFIG_SND_EMU10K1_SEQ=3Dm
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=3Dm
CONFIG_SND_VIRMIDI=3Dm
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=3Dm
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=3Dm
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_PCI=3Dy
CONFIG_SND_AD1889=3Dm
CONFIG_SND_ALS300=3Dm
CONFIG_SND_ALI5451=3Dm
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_OXYGEN_LIB=3Dm
CONFIG_SND_OXYGEN=3Dm
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS5535AUDIO=3Dm
CONFIG_SND_CTXFI=3Dm
CONFIG_SND_DARLA20=3Dm
CONFIG_SND_GINA20=3Dm
CONFIG_SND_LAYLA20=3Dm
CONFIG_SND_DARLA24=3Dm
CONFIG_SND_GINA24=3Dm
CONFIG_SND_LAYLA24=3Dm
CONFIG_SND_MONA=3Dm
CONFIG_SND_MIA=3Dm
CONFIG_SND_ECHO3G=3Dm
CONFIG_SND_INDIGO=3Dm
CONFIG_SND_INDIGOIO=3Dm
CONFIG_SND_INDIGODJ=3Dm
CONFIG_SND_INDIGOIOX=3Dm
CONFIG_SND_INDIGODJX=3Dm
CONFIG_SND_EMU10K1=3Dm
# CONFIG_SND_EMU10K1X is not set
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_HDSPM=3Dm
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=3Dm
CONFIG_SND_LX6464ES=3Dm
CONFIG_SND_MAESTRO3=3Dm
CONFIG_SND_MAESTRO3_INPUT=3Dy
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=3Dm
CONFIG_SND_RIPTIDE=3Dm
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=3Dm
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
CONFIG_SND_SPI=3Dy
CONFIG_SND_USB=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_UA101=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
CONFIG_SND_USB_CAIAQ_INPUT=3Dy
CONFIG_SND_USB_6FIRE=3Dm
# CONFIG_SND_USB_HIFACE is not set
CONFIG_SND_FIREWIRE=3Dy
CONFIG_SND_FIREWIRE_LIB=3Dm
CONFIG_SND_FIREWIRE_SPEAKERS=3Dm
CONFIG_SND_ISIGHT=3Dm
# CONFIG_SND_SCS1X is not set
CONFIG_SND_SPARC=3Dy
CONFIG_SND_SUN_AMD7930=3Dm
CONFIG_SND_SUN_CS4231=3Dm
CONFIG_SND_SUN_DBRI=3Dm
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=3Dm

#
# HID support
#
CONFIG_HID=3Dm
CONFIG_HIDRAW=3Dy
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
CONFIG_HID_ACRUX=3Dm
CONFIG_HID_ACRUX_FF=3Dy
CONFIG_HID_APPLE=3Dm
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_PRODIKEYS=3Dm
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
CONFIG_DRAGONRISE_FF=3Dy
CONFIG_HID_EMS_FF=3Dm
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=3Dm
CONFIG_HID_HOLTEK=3Dm
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_HUION is not set
CONFIG_HID_KEYTOUCH=3Dm
CONFIG_HID_KYE=3Dm
CONFIG_HID_UCLOGIC=3Dm
CONFIG_HID_WALTOP=3Dm
CONFIG_HID_GYRATION=3Dm
# CONFIG_HID_ICADE is not set
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
CONFIG_HID_LCPOWER=3Dm
# CONFIG_HID_LENOVO_TPKBD is not set
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_LOGITECH_FF=3Dy
CONFIG_LOGIRUMBLEPAD2_FF=3Dy
CONFIG_LOGIG940_FF=3Dy
CONFIG_LOGIWHEELS_FF=3Dy
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
CONFIG_HID_MULTITOUCH=3Dm
CONFIG_HID_NTRIG=3Dm
CONFIG_HID_ORTEK=3Dm
CONFIG_HID_PANTHERLORD=3Dm
CONFIG_PANTHERLORD_FF=3Dy
CONFIG_HID_PETALYNX=3Dm
CONFIG_HID_PICOLCD=3Dm
CONFIG_HID_PICOLCD_FB=3Dy
CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
CONFIG_HID_PICOLCD_LEDS=3Dy
CONFIG_HID_PRIMAX=3Dm
CONFIG_HID_ROCCAT=3Dm
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
CONFIG_HID_SPEEDLINK=3Dm
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_GREENASIA=3Dm
CONFIG_GREENASIA_FF=3Dy
CONFIG_HID_SMARTJOYPLUS=3Dm
CONFIG_SMARTJOYPLUS_FF=3Dy
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=3Dm
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=3Dm
CONFIG_THRUSTMASTER_FF=3Dy
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_ZEROPLUS=3Dm
CONFIG_ZEROPLUS_FF=3Dy
CONFIG_HID_ZYDACRON=3Dm
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
CONFIG_USB_HID=3Dm
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
CONFIG_USB_MON=3Dm
CONFIG_USB_WUSB=3Dm
CONFIG_USB_WUSB_CBAF=3Dm
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=3Dm
CONFIG_USB_XHCI_HCD=3Dm
# CONFIG_USB_XHCI_HCD_DEBUGGING is not set
CONFIG_USB_EHCI_HCD=3Dm
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_EHCI_PCI=3Dm
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=3Dm
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FUSBH200_HCD is not set
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD_PCI=3Dm
# CONFIG_USB_OHCI_HCD_SSB is not set
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_U132_HCD=3Dm
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=3Dm
CONFIG_USB_WHCI_HCD=3Dm
CONFIG_USB_HWA_HCD=3Dm
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=3Dm
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
CONFIG_USB_STORAGE_ALAUDA=3Dm
CONFIG_USB_STORAGE_ONETOUCH=3Dm
CONFIG_USB_STORAGE_KARMA=3Dm
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
CONFIG_USB_STORAGE_ENE_UB6250=3Dm

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_CHIPIDEA is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_FUNSOFT=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MOTOROLA=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_HP4X=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIEMENS_MPI=3Dm
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
CONFIG_USB_SERIAL_VIVOPAY_SERIAL=3Dm
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_ZIO=3Dm
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_ZTE is not set
CONFIG_USB_SERIAL_SSU100=3Dm
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_FLASHLOADER is not set
# CONFIG_USB_SERIAL_SUUNTO is not set
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_SEVSEG=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_CYPRESS_CY7C63=3Dm
CONFIG_USB_CYTHERM=3Dm
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
CONFIG_USB_APPLEDISPLAY=3Dm
CONFIG_USB_SISUSBVGA=3Dm
CONFIG_USB_SISUSBVGA_CON=3Dy
CONFIG_USB_LD=3Dm
CONFIG_USB_TRANCEVIBRATOR=3Dm
CONFIG_USB_IOWARRIOR=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_ISIGHTFW=3Dm
CONFIG_USB_YUREX=3Dm
CONFIG_USB_EZUSB_FX2=3Dm
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_ATM is not set
# CONFIG_USB_PHY is not set
# CONFIG_USB_GADGET is not set
CONFIG_UWB=3Dm
CONFIG_UWB_HWA=3Dm
CONFIG_UWB_WHCI=3Dm
CONFIG_UWB_I1480U=3Dm
# CONFIG_MMC is not set
CONFIG_MEMSTICK=3Dm
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=3Dm

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=3Dm
CONFIG_MEMSTICK_JMICRON_38X=3Dm
CONFIG_MEMSTICK_R592=3Dm
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_SUNFIRE is not set
CONFIG_LEDS_PCA9532=3Dm
CONFIG_LEDS_LP3944=3Dm
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_PCA955X=3Dm
# CONFIG_LEDS_PCA9633 is not set
CONFIG_LEDS_DAC124S085=3Dm
CONFIG_LEDS_REGULATOR=3Dm
CONFIG_LEDS_BD2802=3Dm
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_BLINKM is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dm
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_ACCESSIBILITY=3Dy
CONFIG_A11Y_BRAILLE_CONSOLE=3Dy
CONFIG_INFINIBAND=3Dm
CONFIG_INFINIBAND_USER_MAD=3Dm
CONFIG_INFINIBAND_USER_ACCESS=3Dm
CONFIG_INFINIBAND_USER_MEM=3Dy
CONFIG_INFINIBAND_ADDR_TRANS=3Dy
CONFIG_INFINIBAND_MTHCA=3Dm
CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
CONFIG_INFINIBAND_QIB=3Dm
CONFIG_INFINIBAND_AMSO1100=3Dm
# CONFIG_INFINIBAND_AMSO1100_DEBUG is not set
CONFIG_INFINIBAND_CXGB3=3Dm
# CONFIG_INFINIBAND_CXGB3_DEBUG is not set
CONFIG_INFINIBAND_CXGB4=3Dm
CONFIG_MLX4_INFINIBAND=3Dm
CONFIG_INFINIBAND_NES=3Dm
# CONFIG_INFINIBAND_NES_DEBUG is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_IPOIB=3Dm
CONFIG_INFINIBAND_IPOIB_CM=3Dy
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=3Dm
# CONFIG_INFINIBAND_SRPT is not set
CONFIG_INFINIBAND_ISER=3Dm
# CONFIG_INFINIBAND_ISERT is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=3Dm
CONFIG_RTC_DRV_DS1374=3Dm
CONFIG_RTC_DRV_DS1672=3Dm
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_MAX6900=3Dm
CONFIG_RTC_DRV_RS5C372=3Dm
CONFIG_RTC_DRV_ISL1208=3Dm
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=3Dm
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF8563=3Dm
CONFIG_RTC_DRV_PCF8583=3Dm
CONFIG_RTC_DRV_M41T80=3Dm
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=3Dm
CONFIG_RTC_DRV_S35390A=3Dm
CONFIG_RTC_DRV_FM3130=3Dm
CONFIG_RTC_DRV_RX8581=3Dm
CONFIG_RTC_DRV_RX8025=3Dm
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=3Dm
CONFIG_RTC_DRV_DS1305=3Dm
CONFIG_RTC_DRV_DS1390=3Dm
CONFIG_RTC_DRV_MAX6902=3Dm
CONFIG_RTC_DRV_R9701=3Dm
CONFIG_RTC_DRV_RS5C348=3Dm
CONFIG_RTC_DRV_DS3234=3Dm
CONFIG_RTC_DRV_PCF2123=3Dm
# CONFIG_RTC_DRV_RX4581 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
CONFIG_RTC_DRV_DS1286=3Dm
CONFIG_RTC_DRV_DS1511=3Dm
CONFIG_RTC_DRV_DS1553=3Dm
CONFIG_RTC_DRV_DS1742=3Dm
CONFIG_RTC_DRV_STK17TA8=3Dm
CONFIG_RTC_DRV_M48T86=3Dm
CONFIG_RTC_DRV_M48T35=3Dm
CONFIG_RTC_DRV_M48T59=3Dy
CONFIG_RTC_DRV_MSM6242=3Dm
CONFIG_RTC_DRV_BQ4802=3Dy
CONFIG_RTC_DRV_RP5C01=3Dm
CONFIG_RTC_DRV_V3020=3Dm
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_PCF50633=3Dm

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=3Dy
CONFIG_RTC_DRV_STARFIRE=3Dy
# CONFIG_RTC_DRV_SNVS is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dm
CONFIG_UIO_CIF=3Dm
CONFIG_UIO_PDRV=3Dm
CONFIG_UIO_PDRV_GENIRQ=3Dm
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=3Dm
CONFIG_UIO_SERCOS3=3Dm
CONFIG_UIO_PCI_GENERIC=3Dm
CONFIG_UIO_NETX=3Dm
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=3Dm

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_BALLOON=3Dm
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_STAGING=3Dy
# CONFIG_ET131X is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_W35UND is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_ECHO is not set
# CONFIG_COMEDI is not set
# CONFIG_ASUS_OLED is not set
# CONFIG_PANEL is not set
# CONFIG_R8187SE is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_RTS5139 is not set
# CONFIG_TRANZPORT is not set
# CONFIG_IDE_PHISON is not set
# CONFIG_LINE6_USB is not set
# CONFIG_USB_SERIAL_QUATECH2 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_DX_SEP is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_CRYSTALHD is not set
# CONFIG_FB_XGI is not set
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=3Dm
CONFIG_SPEAKUP_SYNTH_ACNTSA=3Dm
CONFIG_SPEAKUP_SYNTH_ACNTPC=3Dm
CONFIG_SPEAKUP_SYNTH_APOLLO=3Dm
CONFIG_SPEAKUP_SYNTH_AUDPTR=3Dm
CONFIG_SPEAKUP_SYNTH_BNS=3Dm
CONFIG_SPEAKUP_SYNTH_DECTLK=3Dm
CONFIG_SPEAKUP_SYNTH_DECEXT=3Dm
# CONFIG_SPEAKUP_SYNTH_DECPC is not set
CONFIG_SPEAKUP_SYNTH_DTLK=3Dm
CONFIG_SPEAKUP_SYNTH_KEYPC=3Dm
CONFIG_SPEAKUP_SYNTH_LTLK=3Dm
CONFIG_SPEAKUP_SYNTH_SOFT=3Dm
CONFIG_SPEAKUP_SYNTH_SPKOUT=3Dm
CONFIG_SPEAKUP_SYNTH_TXPRT=3Dm
CONFIG_SPEAKUP_SYNTH_DUMMY=3Dm
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_USB_WPAN_HCD is not set
# CONFIG_WIMAX_GDM72XX is not set
CONFIG_NET_VENDOR_SILICOM=3Dy
# CONFIG_SBYPASS is not set
# CONFIG_BPCTL is not set
# CONFIG_CED1401 is not set
# CONFIG_DGRP is not set
# CONFIG_FIREWIRE_SERIAL is not set

#
# Hardware Spinlock drivers
#
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=3Dy
CONFIG_OF_IOMMU=3Dy

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dy
CONFIG_OBP_FLASH=3Dm
# CONFIG_TADPOLE_TS102_UCTRL is not set
CONFIG_BBC_I2C=3Dm
CONFIG_ENVCTRL=3Dm
CONFIG_DISPLAY7SEG=3Dm

#
# File systems
#
CONFIG_EXT2_FS=3Dm
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_DEFAULTS_TO_ORDERED=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dy
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_FS_STATS=3Dy
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=3Dm
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_NILFS2_FS=3Dm
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dm
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGEC7
CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm
CONFIG_MISC_FILESYSTEMS=3Dy
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=3Dm
CONFIG_ECRYPT_FS=3Dm
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=3Dm
CONFIG_EFS_FS=3Dm
CONFIG_LOGFS=3Dm
CONFIG_CRAMFS=3Dm
CONFIG_SQUASHFS=3Dm
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
CONFIG_VXFS_FS=3Dm
CONFIG_MINIX_FS=3Dm
CONFIG_MINIX_FS_NATIVE_ENDIAN=3Dy
CONFIG_OMFS_FS=3Dm
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=3Dm
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
CONFIG_ROMFS_ON_BLOCK=3Dy
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EXOFS_FS=3Dm
# CONFIG_EXOFS_DEBUG is not set
# CONFIG_F2FS_FS is not set
CONFIG_ORE=3Dm
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V2=3Dm
CONFIG_NFS_V3=3Dm
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dm
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=3Dy
# CONFIG_NFS_V4_2 is not set
CONFIG_PNFS_FILE_LAYOUT=3Dm
CONFIG_PNFS_BLOCK=3Dm
CONFIG_PNFS_OBJLAYOUT=3Dm
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
CONFIG_NFS_FSCACHE=3Dy
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
# CONFIG_NFSD_V4_SECURITY_LABEL is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_BACKCHANNEL=3Dy
CONFIG_SUNRPC_XPRT_RDMA=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=3Dm
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
CONFIG_CIFS_ACL=3Dy
CONFIG_CIFS_DEBUG=3Dy
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
# CONFIG_CIFS_SMB2 is not set
CONFIG_CIFS_FSCACHE=3Dy
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
CONFIG_AFS_FS=3Dm
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=3Dy
CONFIG_9P_FS=3Dm
CONFIG_9P_FSCACHE=3Dy
CONFIG_9P_FS_POSIX_ACL=3Dy
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
CONFIG_DLM_DEBUG=3Dy

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
CONFIG_BOOT_PRINTK_DELAY=3Dy
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN 48
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy

#
# Memory Debugging
#
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT`
# CONFIG_RCU_CPU_STALL_INFO is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=3Dy
# CONFIG_PROBE_EVENTS is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_DEBUG_DCFLUSH is not set

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEYS_DEBUG_PROC_KEYS=3Dy
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_PATH=3Dy
CONFIG_LSM_MMAP_MIN_ADDR2768
CONFIG_SECURITY_SELINUX=3Dy
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
# CONFIG_SECURITY_SMACK is not set
CONFIG_SECURITY_TOMOYO=3Dy
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY 48
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/init"
CONFIG_SECURITY_APPARMOR=3Dy
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=3D1
# CONFIG_SECURITY_YAMA is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dm
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP=3Dm
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_GF128MUL=3Dm
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_PCRYPT=3Dm
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dm
CONFIG_CRYPTO_SEQIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
CONFIG_CRYPTO_CTR=3Dm
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=3Dm
CONFIG_CRYPTO_HMAC=3Dm
CONFIG_CRYPTO_XCBC=3Dm
CONFIG_CRYPTO_VMAC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dy
# CONFIG_CRYPTO_CRC32C_SPARC64 is not set
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_GHASH=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
# CONFIG_CRYPTO_MD5_SPARC64 is not set
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_RMD128=3Dm
CONFIG_CRYPTO_RMD160=3Dm
CONFIG_CRYPTO_RMD256=3Dm
CONFIG_CRYPTO_RMD320=3Dm
CONFIG_CRYPTO_SHA1=3Dm
# CONFIG_CRYPTO_SHA1_SPARC64 is not set
CONFIG_CRYPTO_SHA256=3Dm
# CONFIG_CRYPTO_SHA256_SPARC64 is not set
CONFIG_CRYPTO_SHA512=3Dm
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_SPARC64 is not set
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
# CONFIG_CRYPTO_CAMELLIA_SPARC64 is not set
CONFIG_CRYPTO_CAST_COMMON=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DES=3Dm
# CONFIG_CRYPTO_DES_SPARC64 is not set
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_ZLIB=3Dm
CONFIG_CRYPTO_LZO=3Dm
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dm
CONFIG_CRYPTO_USER_API=3Dm
CONFIG_CRYPTO_USER_API_HASH=3Dm
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
CONFIG_CRYPTO_HW=3Dy
# CONFIG_CRYPTO_DEV_NIAGARA2 is not set
CONFIG_CRYPTO_DEV_HIFN_795X=3Dm
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=3Dy
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dy
CONFIG_CRC_T10DIF=3Dy
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_CRC8=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_LZ4_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_XZ_DEC_X86=3Dy
CONFIG_XZ_DEC_POWERPC=3Dy
CONFIG_XZ_DEC_IA64=3Dy
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
CONFIG_XZ_DEC_SPARC=3Dy
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_DECOMPRESS_LZ4=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy
CONFIG_LRU_CACHE=3Dm
CONFIG_AVERAGE=3Dy
CONFIG_CORDIC=3Dm
# CONFIG_DDR is not set
CONFIG_OID_REGISTRY=3Dm
CONFIG_FONT_SUPPORT=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x16=3Dy
CONFIG_FONT_SUN8x16=3Dy
# CONFIG_FONT_SUN12x22 is not set

prtconf:
System Configuration:  Sun Microsystems  sun4u
Memory size: 16256 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0229e20
    .node:  f0229e20
    idprom:  01840014.4f869926.00000000.869926de.00000000.00000000.00000000=
.00000000
    scsi-initiator-id:  00000007
    banner-name: 'Sun Fire T200'
    name: 'SUNW,Sun-Fire-T200'
    stick-frequency:  3b9aca00
    breakpoint-trap:  0000007f
    device_type: 'sun4v'
    compatible: 'sun4v'
    #address-cells:  00000002
    #size-cells:  00000002

    Node 0xf022d008
        .node:  f022d008
        name: 'packages'

        Node 0xf02494cc
            .node:  f02494cc
            name: 'SUNW,builtin-drivers'

        Node 0xf0258a0c
            .node:  f0258a0c
            lba64: =20
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0259108
            .node:  f0259108
            name: 'disk-label'

        Node 0xf0259a64
            .node:  f0259a64
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf02616ec
            .node:  f02616ec
            source: '/flashprom:'
            name: 'dropins'

        Node 0xf026261c
            .node:  f026261c
            name: 'SUNW,asr'

        Node 0xf0266bcc
            .node:  f0266bcc
            name: 'kbd-translator'

        Node 0xf0268300
            .node:  f0268300
            name: 'obp-tftp'

    Node 0xf022d080
        .node:  f022d080
        bootargs:  00
        bootpath: '/pci@780/pci@0/pci@9/scsi@0/disk@0,0:a'
        mmu:  fff74080
        memory:  fff74290
        stdout:  fec9be08
        stdin:  fedafd70
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf022d0f4
        .node:  f022d0f4
        version: 'OBP 4.30.4.d 2011/07/06 14:29'
        model: 'SUNW,4.30.4.d'
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf022d184
            .node:  f022d184
            name: 'client-services'

    Node 0xf022d23c
        .node:  f022d23c
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        keyboard-layout: =20
        reboot-command: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        verbosity: 'min'
        pci-mem64?: 'false'
        diag-switch?: 'false'
        local-mac-address?: 'true'
        fcode-debug?: 'false'
        scsi-initiator-id: '7'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
        oem-banner?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        ttya-mode: '9600,8,n,1,-'
        output-device: 'virtual-console'
        input-device: 'virtual-console'
        auto-boot-on-error?: 'false'
        load-base: '16384'
        auto-boot?: 'true'
        network-boot-arguments: =20
        boot-command: 'boot'
        boot-file: =20
        boot-device: 'disk net'
        multipath-boot?: 'false'
        boot-device-index: '0'
        use-nvramrc?: 'false'
        nvramrc: =20
        error-reset-recovery: 'boot'
        name: 'options'

    Node 0xf022d2b4
        .node:  f022d2b4
        ttya: '/pci@7c0/pci@0/pci@1/pci@0/isa@2/serial@0,3f8'
        nvram: '/virtual-devices/nvram@3'
        net3: '/pci@7c0/pci@0/pci@2/network@0,1'
        net2: '/pci@7c0/pci@0/pci@2/network@0'
        net1: '/pci@780/pci@0/pci@1/network@0,1'
        net0: '/pci@780/pci@0/pci@1/network@0'
        net: '/pci@780/pci@0/pci@1/network@0'
        ide: '/pci@7c0/pci@0/pci@1/pci@0/ide@8'
        cdrom: '/pci@7c0/pci@0/pci@1/pci@0/ide@8/cdrom@0,0:f'
        disk3: '/pci@780/pci@0/pci@9/scsi@0/disk@3'
        disk2: '/pci@780/pci@0/pci@9/scsi@0/disk@2'
        disk1: '/pci@780/pci@0/pci@9/scsi@0/disk@1'
        disk0: '/pci@780/pci@0/pci@9/scsi@0/disk@0'
        disk: '/pci@780/pci@0/pci@9/scsi@0/disk@0'
        scsi: '/pci@780/pci@0/pci@9/scsi@0'
        virtual-console: '/virtual-devices/console@1'
        name: 'aliases'

    Node 0xf023f740
        .node:  f023f740
        reg:  00000000.08000000.00000003.f8000000
        available:  00000003.ffd2c000.00000000.00008000.00000003.ffd0e000.0=
0000000.0001a000.00000003.ffc28000.00000000.000d6000.00000000.08400000.0000=
0003.f7820000
        name: 'memory'

    Node 0xf023fd4c
        .node:  f023fd4c
        translations:  00000000.00002000.00000000.00bfe000.80000000.0840274=
0.00000000.40000000.00000000.00c00000.80000000.08800740.00000000.415ba000.0=
0000000.02a46000.80000000.09dba740.00000000.f0000000.00000000.00400000.8000=
0000.08000750.00000000.fec9a000.00000000.00008000.80000003.ffc20750.0000000=
0.fedae000.00000000.00008000.80000003.ffd38750.00000000.fedb6000.00000000.0=
0008000.80000003.ffdc0750.00000000.fedbe000.00000000.00080000.80000003.ffd4=
0750.00000000.fee3e000.00000000.00102000.80000003.ffdc8750.00000000.fef4000=
0.00000000.000c0000.80000003.fff22750.00000000.fff00000.00000000.0004c000.8=
0000003.ffeca750.00000000.fff50000.00000000.0000a000.80000003.fff16750.0000=
0000.fff5a000.00000000.00016000.80000003.fffe2750.00000000.fff70000.0000000=
0.00010000.80000000.081f0750
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.feca2000.00000000.0010c000.00000000.f0a00000.0000000=
0.0e29a000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf02780c4
        .node:  f02780c4
        interrupt-map:  00000001.00000001.f02780c4.00000011.00000009.000000=
01.f02780c4.00000015.0000000a.00000001.f02780c4.00000016.0000000b.00000001.=
f02780c4.00000017.0000000c.00000001.f02780c4.00000018.0000000d.00000001.f02=
780c4.00000019.0000000e.00000001.f02780c4.0000001a.00000004.00000001.f02780=
c4.00000020.00000004.00000002.f02780c4.00000021.00000004.00000003.f02780c4.=
00000022.00000004.00000004.f02780c4.00000023.00000004.00000005.f02780c4.000=
00024.00000004.00000006.f02780c4.00000025.00000004.00000007.f02780c4.000000=
26.00000004.00000008.f02780c4.00000027
        interrupt-map-mask:  0000001f.00ffffff.00000003
        #interrupt-cells:  00000001
        reg:  c0000100.00000000.00000000.00000000
        #address-cells:  00000001
        #size-cells:  00000000
        device_type: 'virtual-devices'
        compatible:  53554e57.2c73756e.34762d76.69727475.616c2d64.65766963.=
65730053.554e572c.76697274.75616c2d.64657669.63657300
        name: 'virtual-devices'

        Node 0xf02791cc
            .node:  f02791cc
            name: 'flashprom'
            reg:  00000000

        Node 0xf02797a0
            .node:  f02797a0
            #address-cells:  00000001
            #size-cells:  00000000
            reg:  00000200
            compatible: 'SUNW,sun4v-channel-devices'
            device_type: 'channel-devices'
            name: 'channel-devices'

            Node 0xf027a6f8
                .node:  f027a6f8
                compatible: 'SUNW,sun4v-channel'
                reg:  00000000
                name: 'virtual-channel'

            Node 0xf027a7cc
                .node:  f027a7cc
                compatible: 'SUNW,sun4v-channel'
                reg:  00000001
                name: 'virtual-channel-client'

            Node 0xf027a8a4
                .node:  f027a8a4
                compatible: 'SUNW,sun4v-channel'
                reg:  00000003
                name: 'virtual-channel'

        Node 0xf027a9b0
            .node:  f027a9b0
            reg:  00000001
            device_type: 'serial'
            compatible: 'SUNW,sun4v-console'
            name: 'console'
            interrupts:  00000001

        Node 0xf027b180
            .node:  f027b180
            compatible: 'SUNW,sun4v-tod'
            reg:  00000005
            name: 'rtc'

        Node 0xf027b84c
            .node:  f027b84c
            channel#:  00000066
            mtu:  000001f8
            flags:  0000003f
            compatible:  73702d66.6d610067.6c766300
            reg:  00000009
            name: 'fma'
            interrupts:  00000001

        Node 0xf027b998
            .node:  f027b998
            channel#:  00000067
            mtu:  000001f8
            flags:  0000003f
            compatible:  73702d73.756e7674.7300676c.766300
            reg:  0000000a
            name: 'sunvts'
            interrupts:  00000001

        Node 0xf027baec
            .node:  f027baec
            channel#:  00000068
            mtu:  000001f8
            flags:  0000003f
            compatible:  73702d73.756e6d63.00676c76.6300
            reg:  0000000b
            name: 'sunmc'
            interrupts:  00000001

        Node 0xf027bc3c
            .node:  f027bc3c
            channel#:  00000069
            mtu:  000001f8
            flags:  0000003f
            compatible:  73702d65.78706c6f.72657200.676c7663.00
            reg:  0000000c
            name: 'explorer'
            interrupts:  00000001

        Node 0xf027bd98
            .node:  f027bd98
            channel#:  0000006a
            mtu:  000001f8
            flags:  0000003f
            compatible:  73702d6c.65640067.6c766300
            reg:  0000000d
            name: 'led'
            interrupts:  00000001

        Node 0xf027bee4
            .node:  f027bee4
            channel#:  0000006b
            mtu:  000001f8
            flags:  0000003f
            compatible:  53554e57.2c666c61.73687570.64617465.00676c76.6300
            reg:  0000000e
            name: 'flashupdate'
            interrupts:  00000001

        Node 0xf027c04c
            .node:  f027c04c
            compatible: 'SUNW,sun4v-ncp'
            reg:  00000004
            name: 'ncp'
            interrupts:  00000001.00000002.00000003.00000004.00000005.00000=
006.00000007.00000008

    Node 0xf027c328
        .node:  f027c328
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000000.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027c458
        .node:  f027c458
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000001.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027c588
        .node:  f027c588
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000002.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027c6b8
        .node:  f027c6b8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000003.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027c7e8
        .node:  f027c7e8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000004.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027c918
        .node:  f027c918
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000005.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027ca48
        .node:  f027ca48
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000006.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027cb78
        .node:  f027cb78
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000007.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027cca8
        .node:  f027cca8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000008.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027cdd8
        .node:  f027cdd8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000009.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027cf08
        .node:  f027cf08
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000a.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d038
        .node:  f027d038
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000b.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d168
        .node:  f027d168
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000c.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d298
        .node:  f027d298
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000d.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d3c8
        .node:  f027d3c8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000e.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d4f8
        .node:  f027d4f8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000000f.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d628
        .node:  f027d628
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000010.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d758
        .node:  f027d758
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000011.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d888
        .node:  f027d888
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000012.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027d9b8
        .node:  f027d9b8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000013.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027dae8
        .node:  f027dae8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000014.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027dc18
        .node:  f027dc18
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000015.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027dd48
        .node:  f027dd48
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000016.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027de78
        .node:  f027de78
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000017.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027dfa8
        .node:  f027dfa8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000018.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e0d8
        .node:  f027e0d8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c0000019.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e208
        .node:  f027e208
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001a.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e338
        .node:  f027e338
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001b.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e468
        .node:  f027e468
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001c.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e598
        .node:  f027e598
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001d.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e6c8
        .node:  f027e6c8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001e.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e7f8
        .node:  f027e7f8
        clock-frequency:  3b9aca00
        compatible:  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.=
73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        reg:  c000001f.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf027e92c
        .node:  f027e92c
        interrupt-map:  00020000.00000000.00000000.00000001.f027e92c.000000=
14.00020000.00000000.00000000.00000002.f027e92c.00000015.00020000.00000000.=
00000000.00000003.f027e92c.00000016.00020000.00000000.00000000.00000004.f02=
7e92c.00000017
        interrupt-map-mask:  00fff000.00000000.00000000.00000007
        #interrupt-cells:  00000001
        interrupts:  0000003f.0000003e
        available:  81000000.00000000.00002000.00000000.0fffe000.82000000.0=
0000000.00120000.00000000.000e0000.82000000.00000000.00800000.00000000.7f7f=
0000.c3000000.00000001.00000000.00000003.ffff0000
        reg:  c0000780.00000000.00000000.00000000
        ranges:  01000000.00000000.00000000.800000e8.10000000.00000000.1000=
0000.02000000.00000000.00000000.800000ea.00000000.00000000.7fff0000.0300000=
0.00000000.00000000.800000ec.00000000.00000003.ffff0000
        msi-eq-to-devino:  00000000.00000024.00000018
        #msi-eqs:  00000024
        msix-data-width:  00000020
        msi-eq-size:  00000080
        msi-ranges:  00000000.00000100
        msi-data-mask:  000000ff
        #msi:  00000100
        msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff0000.0=
0010000
        bus-range:  00000002.00000007
        bus-parity-generated: =20
        #address-cells:  00000003
        #size-cells:  00000002
        name: 'pci'
        compatible: 'SUNW,sun4v-pci'
        device_type: 'pciex'
        virtual-dma:  80000000.7ff80000

        Node 0xf028f9b8
            .node:  f028f9b8
            assigned-addresses:  82020010.00000000.00100000.00000000.000200=
00
            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.=
00000000.00002000.82000000.00000000.00200000.82000000.00000000.00200000.000=
00000.00600000
            bus-range:  00000003.00000007
            compatible:  70636965.78313062.352c3835.33322e62.63007063.69657=
831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578=
.636c6173.732c3036.303400
            reg:  00020000.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pciex'
            name: 'pci'
            interrupts:  00000001
            cache-line-size:  00000010
            class-code:  00060400
            revision-id:  000000bc
            device-id:  00008532
            vendor-id:  000010b5

            Node 0xf0291d7c
                .node:  f0291d7c
                available:  81000000.00000000.00000040.00000000.00000fc0.82=
000000.00000000.00240000.00000000.000c0000
                ranges:  81000000.00000000.00000000.81000000.00000000.00000=
000.00000000.00001000.82000000.00000000.00200000.82000000.00000000.00200000=
.00000000.00100000
                bus-range:  00000004.00000004
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00030800.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf0294140
                    .node:  f0294140
                    local-mac-address:  00144f86.9926
                    mac-addresses:  00144f86.9926
                    assigned-addresses:  82040010.00000000.00200000.0000000=
0.00020000.81040018.00000000.00000000.00000000.00000020
                    compatible:  70636965.78383038.362c3130.35652e31.303865=
2e.31303565.2e360070.63696578.38303836.2c313035.652e3130.38652e31.30356500.=
70636965.78383038.362c3130.35652e36.00706369.65783830.38362c31.30356500.706=
36965.78636c61.73732c30.32303030.30007063.69657863.6c617373.2c303230.3000
                    reg:  00040000.00000000.00000000.00000000.00000000.0304=
0010.00000000.00000000.00000000.00020000
                    max-frame-size:  00010000
                    address-bits:  00000030
                    device_type: 'network'
                    name: 'network'
                    interrupts:  00000001
                    cache-line-size:  00000010
                    class-code:  00020000
                    subsystem-id:  0000105e
                    subsystem-vendor-id:  0000108e
                    revision-id:  00000006
                    device-id:  0000105e
                    vendor-id:  00008086

                Node 0xf0299c3c
                    .node:  f0299c3c
                    local-mac-address:  00144f86.9927
                    mac-addresses:  00144f86.9927
                    assigned-addresses:  82040110.00000000.00220000.0000000=
0.00020000.81040118.00000000.00000020.00000000.00000020
                    compatible:  70636965.78383038.362c3130.35652e31.303865=
2e.31303565.2e360070.63696578.38303836.2c313035.652e3130.38652e31.30356500.=
70636965.78383038.362c3130.35652e36.00706369.65783830.38362c31.30356500.706=
36965.78636c61.73732c30.32303030.30007063.69657863.6c617373.2c303230.3000
                    reg:  00040100.00000000.00000000.00000000.00000000.0304=
0110.00000000.00000000.00000000.00020000
                    max-frame-size:  00010000
                    address-bits:  00000030
                    device_type: 'network'
                    name: 'network'
                    interrupts:  00000002
                    cache-line-size:  00000010
                    class-code:  00020000
                    subsystem-id:  0000105e
                    subsystem-vendor-id:  0000108e
                    revision-id:  00000006
                    device-id:  0000105e
                    vendor-id:  00008086

            Node 0xf029f83c
                .node:  f029f83c
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00=
000.ffffffff.00200000
                bus-range:  00000005.00000005
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00031000.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

            Node 0xf02a1c9c
                .node:  f02a1c9c
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00=
000.ffffffff.00200000
                bus-range:  00000006.00000006
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00034000.00000000.00000000.00000000.00000000
                physical-slot#:  000000e0
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

            Node 0xf02a4124
                .node:  f02a4124
                available:  81000000.00000000.00001100.00000000.00000f00.82=
000000.00000000.00320000.00000000.000e0000
                ranges:  81000000.00000000.00001000.81000000.00000000.00001=
000.00000000.00001000.82000000.00000000.00300000.82000000.00000000.00300000=
.00000000.00500000
                bus-range:  00000007.00000007
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00034800.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf02a64e8
                    .node:  f02a64e8
                    firmware-version: '1.09.00.00'
                    mpt-version: '1.05'
                    assigned-addresses:  81070010.00000000.00001000.0000000=
0.00000100.82070014.00000000.00300000.00000000.00010000.8207001c.00000000.0=
0310000.00000000.00010000.82070030.00000000.00400000.00000000.00400000
                    compatible:  70636965.78313030.302c3536.2e313030.302e31=
30.30302e32.00706369.65783130.30302c35.362e3130.30302e31.30303000.70636965.=
78313030.302c3536.2e320070.63696578.31303030.2c353600.70636965.78636c61.737=
32c30.31303030.30007063.69657863.6c617373.2c303130.30007063.69313030.302c35=
36.00
                    model: 'LSI,1064E'
                    reg:  00070000.00000000.00000000.00000000.00000000.0107=
0010.00000000.00000000.00000000.00000100.03070014.00000000.00000000.0000000=
0.00010000.0307001c.00000000.00000000.00000000.00010000.02070030.00000000.0=
0000000.00000000.00400000
                    version: '1.00.41'
                    wide:  00000010
                    device_type: 'scsi-2'
                    name: 'scsi'
                    interrupts:  00000001
                    cache-line-size:  00000080
                    class-code:  00010000
                    subsystem-id:  00001000
                    subsystem-vendor-id:  00001000
                    revision-id:  00000002
                    device-id:  00000056
                    vendor-id:  00001000

                    Node 0xf02b2bd4
                        .node:  f02b2bd4
                        device_type: 'byte'
                        compatible: 'st'
                        name: 'tape'

                    Node 0xf02b3914
                        .node:  f02b3914
                        lba64: =20
                        device_type: 'block'
                        compatible: 'sd'
                        name: 'disk'

    Node 0xf0287174
        .node:  f0287174
        interrupt-map:  00020000.00000000.00000000.00000001.f0287174.000000=
14.00020000.00000000.00000000.00000002.f0287174.00000015.00020000.00000000.=
00000000.00000003.f0287174.00000016.00020000.00000000.00000000.00000004.f02=
87174.00000017
        interrupt-map-mask:  00fff000.00000000.00000000.00000007
        #interrupt-cells:  00000001
        interrupts:  0000003f.0000003e
        available:  81000000.00000000.00002000.00000000.0fffe000.82000000.0=
0000000.00120000.00000000.000e0000.82000000.00000000.03100000.00000000.7cef=
0000.c3000000.00000001.00000000.00000003.ffff0000
        reg:  c00007c0.00000000.00000000.00000000
        ranges:  01000000.00000000.00000000.800000f0.10000000.00000000.1000=
0000.02000000.00000000.00000000.800000f2.00000000.00000000.7fff0000.0300000=
0.00000000.00000000.800000f4.00000000.00000003.ffff0000
        msi-eq-to-devino:  00000000.00000024.00000018
        #msi-eqs:  00000024
        msix-data-width:  00000020
        msi-eq-size:  00000080
        msi-ranges:  00000000.00000100
        msi-data-mask:  000000ff
        #msi:  00000100
        msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff0000.0=
0010000
        bus-range:  00000002.00000009
        bus-parity-generated: =20
        #address-cells:  00000003
        #size-cells:  00000002
        name: 'pci'
        compatible: 'SUNW,sun4v-pci'
        device_type: 'pciex'
        virtual-dma:  80000000.7ff80000

        Node 0xf02b4bd8
            .node:  f02b4bd8
            assigned-addresses:  82020010.00000000.00100000.00000000.000200=
00
            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.=
00000000.00002000.82000000.00000000.00200000.82000000.00000000.00200000.000=
00000.02f00000
            bus-range:  00000003.00000009
            compatible:  70636965.78313062.352c3835.33322e62.63007063.69657=
831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578=
.636c6173.732c3036.303400
            reg:  00020000.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pciex'
            name: 'pci'
            interrupts:  00000001
            cache-line-size:  00000010
            class-code:  00060400
            revision-id:  000000bc
            device-id:  00008532
            vendor-id:  000010b5

            Node 0xf02b6f9c
                .node:  f02b6f9c
                ranges:  81000000.00000000.00000000.81000000.00000000.00000=
000.00000000.00001000.82000000.00000000.00200000.82000000.00000000.00200000=
.00000000.02e00000
                bus-range:  00000004.00000006
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00030800.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf02b9360
                    .node:  f02b9360
                    interrupt-map:  00052800.00000000.00000000.00000001.f02=
87174.00000001.00053000.00000000.00000000.00000001.f0287174.00000003.000540=
00.00000000.00000000.00000001.f0287174.00000004
                    interrupt-map-mask:  00fff800.00000000.00000000.00000007
                    #interrupt-cells:  00000001
                    available:  81000000.00000000.00000130.00000000.00000ed=
0.82000000.00000000.00202000.00000000.00dfe000
                    ranges:  81000000.00000000.00000000.81000000.00000000.0=
0000000.00000000.00001000.82000000.00000000.00200000.82000000.00000000.0020=
0000.00000000.02e00000
                    bus-range:  00000005.00000005
                    compatible:  70636965.78383038.362c3334.302e3900.706369=
65.78383038.362c3334.30007063.69657863.6c617373.2c303630.34303000.70636965.=
78636c61.73732c30.36303400
                    reg:  00040000.00000000.00000000.00000000.00000000
                    #address-cells:  00000003
                    #size-cells:  00000002
                    device_type: 'pciex'
                    name: 'pci'
                    cache-line-size:  00000010
                    class-code:  00060400
                    revision-id:  00000009
                    device-id:  00000340
                    vendor-id:  00008086

                    Node 0xf02bba9c
                        .node:  f02bba9c
                        assigned-addresses:  81051010.00000000.00000000.000=
00000.00010000.82051014.00000000.00000000.00000000.00100000
                        interrupt-map:  00000000.000003f8.00000001.f0287174=
.00000002
                        interrupt-map-mask:  00000003.00ffffff.0000000f
                        #interrupt-cells:  00000001
                        ranges:  00000000.00000000.81051010.00000000.000000=
00.00010000.00000001.00000000.82051014.00000000.00000000.00100000
                        reg:  00051000.00000000.00000000.00000000.00000000.=
81051010.00000000.00000000.00000000.00010000.82051014.00000000.00000000.000=
00000.00100000
                        #size-cells:  00000001
                        #address-cells:  00000002
                        name: 'isa'
                        devsel-speed:  00000001
                        latency-timer:  00000000
                        max-latency:  00000000
                        min-grant:  00000000
                        cache-line-size:  00000000
                        class-code:  00060100
                        subsystem-id:  00001533
                        subsystem-vendor-id:  000010b9
                        revision-id:  00000000
                        device-id:  00001533
                        vendor-id:  000010b9

                        Node 0xf02bd6ec
                            .node:  f02bd6ec
                            ignore-cd: =20
                            reg:  00000000.000003f8.00000008
                            interrupts:  00000001
                            compatible:  73753136.35353000.737500
                            device_type: 'serial'
                            name: 'serial'

                    Node 0xf02bf2e4
                        .node:  f02bf2e4
                        assigned-addresses:  82052810.00000000.01000000.000=
00000.01000000
                        sunw,find-fcode:  f02c4a64
                        maximum-frame#:  0000ffff
                        reg:  00052800.00000000.00000000.00000000.00000000.=
02052810.00000000.00000000.00000000.01000000
                        #size-cells:  00000000
                        #address-cells:  00000001
                        compatible:  70636931.3062392c.35323337.2e330070.63=
693130.62392c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617=
373.2c306330.3300
                        name: 'usb'
                        fast-back-to-back: =20
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000050
                        min-grant:  00000000
                        interrupts:  00000001
                        cache-line-size:  00000000
                        class-code:  000c0310
                        revision-id:  00000003
                        device-id:  00005237
                        vendor-id:  000010b9

                    Node 0xf02c5900
                        .node:  f02c5900
                        assigned-addresses:  82053010.00000000.02000000.000=
00000.01000000
                        sunw,find-fcode:  f02cb080
                        maximum-frame#:  0000ffff
                        reg:  00053000.00000000.00000000.00000000.00000000.=
02053010.00000000.00000000.00000000.01000000
                        #size-cells:  00000000
                        #address-cells:  00000001
                        compatible:  70636931.3062392c.35323337.2e330070.63=
693130.62392c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617=
373.2c306330.3300
                        name: 'usb'
                        fast-back-to-back: =20
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000050
                        min-grant:  00000000
                        interrupts:  00000001
                        cache-line-size:  00000000
                        class-code:  000c0310
                        revision-id:  00000003
                        device-id:  00005237
                        vendor-id:  000010b9

                        Node 0xf02cbe98
                            .node:  f02cbe98
                            #size-cells:  00000000
                            #address-cells:  00000001
                            endpoints: '0,8,81,1'
                            interface#:  00000000
                            compatible:  75736233.65622c33.3330312e.3330300=
0.75736233.65622c33.33303100.75736233.65622c63.6c617373.392e302e.30007573.6=
2336562.2c636c61.7373392e.30007573.62336562.2c636c61.73733900.7573622c.636c=
6173.73392e30.2e300075.73622c63.6c617373.392e3000.7573622c.636c6173.7339007=
5.73626966.3365622c.636c6173.73392e30.2e300075.73626966.3365622c.636c6173.7=
3392e30.00757362.69663365.622c636c.61737339.00757362.69662c63.6c617373.392e=
302e.30007573.6269662c.636c6173.73392e30.00757362.69662c63.6c617373.3900
                            name: 'hub'
                            reg:  00000001
                            assigned-address:  00000002
                            0max-packet:  00000008

                    Node 0xf02d11d0
                        .node:  f02d11d0
                        assigned-addresses:  81054010.00000000.00000100.000=
00000.00000008.81054014.00000000.00000118.00000000.00000008.81054018.000000=
00.00000110.00000000.00000008.8105401c.00000000.00000108.00000000.00000008.=
81054020.00000000.00000120.00000000.00000010
                        reg:  00054000.00000000.00000000.00000000.00000000.=
01054010.00000000.00000000.00000000.00000008.01054014.00000000.00000000.000=
00000.00000004.01054018.00000000.00000000.00000000.00000008.0105401c.000000=
00.00000000.00000000.00000004.01054020.00000000.00000000.00000000.00000010
                        compatible:  70636931.3062392c.35323239.2e633400.70=
636931.3062392c.35323239.00706369.636c6173.732c3031.30316666.00706369.636c6=
173.732c3031.303100
                        #address-cells:  00000002
                        device_type: 'ide'
                        name: 'ide'
                        fast-back-to-back: =20
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000004
                        min-grant:  00000002
                        interrupts:  00000001
                        cache-line-size:  00000000
                        class-code:  000101ff
                        revision-id:  000000c4
                        device-id:  00005229
                        vendor-id:  000010b9

                        Node 0xf02d43f4
                            .node:  f02d43f4
                            device_type: 'block'
                            name: 'disk'
                            compatible: 'ide-disk'

                        Node 0xf02d4ae8
                            .node:  f02d4ae8
                            device_type: 'block'
                            name: 'cdrom'
                            compatible: 'ide-cdrom'

                Node 0xf02d5604
                    .node:  f02d5604
                    ranges:  82000000.00000000.fff00000.82000000.00000000.f=
ff00000.ffffffff.00200000
                    bus-range:  00000006.00000006
                    compatible:  70636965.78383038.362c3334.312e3900.706369=
65.78383038.362c3334.31007063.69657863.6c617373.2c303630.34303000.70636965.=
78636c61.73732c30.36303400
                    reg:  00040200.00000000.00000000.00000000.00000000
                    #address-cells:  00000003
                    #size-cells:  00000002
                    device_type: 'pciex'
                    name: 'pci'
                    cache-line-size:  00000010
                    class-code:  00060400
                    revision-id:  00000009
                    device-id:  00000341
                    vendor-id:  00008086

            Node 0xf02d7af8
                .node:  f02d7af8
                available:  81000000.00000000.00001040.00000000.00000fc0.82=
000000.00000000.03040000.00000000.000c0000
                ranges:  81000000.00000000.00001000.81000000.00000000.00001=
000.00000000.00001000.82000000.00000000.03000000.82000000.00000000.03000000=
.00000000.00100000
                bus-range:  00000007.00000007
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00031000.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf02d9ebc
                    .node:  f02d9ebc
                    local-mac-address:  00144f86.9928
                    mac-addresses:  00144f86.9928
                    assigned-addresses:  82070010.00000000.03000000.0000000=
0.00020000.81070018.00000000.00001000.00000000.00000020
                    compatible:  70636965.78383038.362c3130.35652e31.303865=
2e.31303565.2e360070.63696578.38303836.2c313035.652e3130.38652e31.30356500.=
70636965.78383038.362c3130.35652e36.00706369.65783830.38362c31.30356500.706=
36965.78636c61.73732c30.32303030.30007063.69657863.6c617373.2c303230.3000
                    reg:  00070000.00000000.00000000.00000000.00000000.0307=
0010.00000000.00000000.00000000.00020000
                    max-frame-size:  00010000
                    address-bits:  00000030
                    device_type: 'network'
                    name: 'network'
                    interrupts:  00000001
                    cache-line-size:  00000010
                    class-code:  00020000
                    subsystem-id:  0000105e
                    subsystem-vendor-id:  0000108e
                    revision-id:  00000006
                    device-id:  0000105e
                    vendor-id:  00008086

                Node 0xf02df9b8
                    .node:  f02df9b8
                    local-mac-address:  00144f86.9929
                    mac-addresses:  00144f86.9929
                    assigned-addresses:  82070110.00000000.03020000.0000000=
0.00020000.81070118.00000000.00001020.00000000.00000020
                    compatible:  70636965.78383038.362c3130.35652e31.303865=
2e.31303565.2e360070.63696578.38303836.2c313035.652e3130.38652e31.30356500.=
70636965.78383038.362c3130.35652e36.00706369.65783830.38362c31.30356500.706=
36965.78636c61.73732c30.32303030.30007063.69657863.6c617373.2c303230.3000
                    reg:  00070100.00000000.00000000.00000000.00000000.0307=
0110.00000000.00000000.00000000.00020000
                    max-frame-size:  00010000
                    address-bits:  00000030
                    device_type: 'network'
                    name: 'network'
                    interrupts:  00000002
                    cache-line-size:  00000010
                    class-code:  00020000
                    subsystem-id:  0000105e
                    subsystem-vendor-id:  0000108e
                    revision-id:  00000006
                    device-id:  0000105e
                    vendor-id:  00008086

            Node 0xf02e55b8
                .node:  f02e55b8
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00=
000.ffffffff.00200000
                bus-range:  00000008.00000008
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00034000.00000000.00000000.00000000.00000000
                physical-slot#:  000000e1
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5

            Node 0xf02e7a40
                .node:  f02e7a40
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00=
000.ffffffff.00200000
                bus-range:  00000009.00000009
                compatible:  70636965.78313062.352c3835.33322e62.63007063.6=
9657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.6369=
6578.636c6173.732c3036.303400
                reg:  00034800.00000000.00000000.00000000.00000000
                physical-slot#:  000000e2
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000bc
                device-id:  00008532
                vendor-id:  000010b5


dmesg:
Sun Fire T200, No Keyboard
Copyright (c) 1998, 2011, Oracle and/or its affiliates. All rights reserved.
OpenBoot 4.30.4.d, 16256 MB memory available, Serial #75929894.
Ethernet address 0:14:4f:86:99:26, Host ID: 84869926.



Boot device: disk  File and args:=20
SILO Version 1.4.14
boot:=20
Linux                    LinuxOLD                 test                     =

boot: test console=3DttyHV0 initcall_debug debug
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.11.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.d 2011/07/06 14:29'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.11.0 (mroos@t2000) (gcc version 4.6.3 (Debia=
n 4.6.3-14) ) #3 SMP Wed Sep 18 18:39:49 EEST 2013
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:14:4f:86:99:26
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 97041 bytes of memory.
[    0.000000] MDESC: Size is 42288 bytes.
[    0.000000] PLATFORM: banner-name [Sun Fire T200]
[    0.000000] PLATFORM: name [SUNW,Sun-Fire-T200]
[    0.000000] PLATFORM: hostid [84869926]
[    0.000000] PLATFORM: serial# [00ab4130]
[    0.000000] PLATFORM: stick-frequency [3b9aca00]
[    0.000000] PLATFORM: mac-address [144f869926]
[    0.000000] PLATFORM: watchdog-resolution [1000 ms]
[    0.000000] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.000000] PLATFORM: max-cpus [32]
[    0.000000] Top of RAM: 0x3ffd34000, Total RAM: 0x3f7918000
[    0.000000] Memory hole size: 132MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x08400000-0x3ffd33fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x08400000-0x3ffc1ffff]
[    0.000000]   node   0: [mem 0x3ffc28000-0x3ffcfdfff]
[    0.000000]   node   0: [mem 0x3ffd0e000-0x3ffd27fff]
[    0.000000]   node   0: [mem 0x3ffd2c000-0x3ffd33fff]
[    0.000000] On node 0 totalpages: 2079884
[    0.000000]   Normal zone: 16250 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 2079884 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,ASIBlkInit]
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff803f7400000 s23104 r8192 =
d26048 u131072
[    0.000000] pcpu-alloc: s23104 r8192 d26048 u131072 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14=
 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31=20
[    0.000000] SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) nr(25=
6)]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 2063634
[    0.000000] Kernel command line: root=3D/dev/sda1 ro debug console=3Dtty=
HV0 initcall_debug debug
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 1677721=
6 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 8388608 =
bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 16472768K/16639072K available (4319K kernel code, 52=
5K rwdata, 1392K rodata, 280K init, 853K bss, 166304K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids2.
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[800000] shift[23]
[    0.000000] clockevent: mult[80000000] shift[31]
[    0.000000] Console: colour dummy device 80x25
[   53.824761] Calibrating delay using timer specific routine.. 2006.28 Bog=
oMIPS (lpj@12562)
[   53.825483] pid_max: default: 32768 minimum: 301
[   53.826024] Security Framework initialized
[   53.826371] AppArmor: AppArmor disabled by boot time parameter
[   53.826893] Mount-cache hash table entries: 512
[   53.828741] Initializing cgroup subsys devices
[   53.829117] Initializing cgroup subsys freezer
[   53.829471] Initializing cgroup subsys net_cls
[   53.829822] Initializing cgroup subsys blkio
[   53.830160] Initializing cgroup subsys perf_event
[   53.830970] calling  cpu_type_probe+0x0/0x32c @ 1
[   53.831354] initcall cpu_type_probe+0x0/0x32c returned 0 after 0 usecs
[   53.831858] calling  trace_init_flags_sys_exit+0x0/0x14 @ 1
[   53.832295] initcall trace_init_flags_sys_exit+0x0/0x14 returned 0 after=
 0 usecs
[   53.832865] calling  trace_init_flags_sys_enter+0x0/0x14 @ 1
[   53.833327] initcall trace_init_flags_sys_enter+0x0/0x14 returned 0 afte=
r 0 usecs
[   53.833899] calling  init_hw_perf_events+0x0/0x15c @ 1
[   53.834294] Performance events: Supported PMU type is 'niagara'
[   53.834884] initcall init_hw_perf_events+0x0/0x15c returned 0 after 0 us=
ecs
[   53.835414] calling  spawn_ksoftirqd+0x0/0x40 @ 1
[   53.835902] initcall spawn_ksoftirqd+0x0/0x40 returned 0 after 0 usecs
[   53.836406] calling  init_workqueues+0x0/0x420 @ 1
[   53.837968] initcall init_workqueues+0x0/0x420 returned 0 after 3906 use=
cs
[   53.838507] calling  check_cpu_stall_init+0x0/0x20 @ 1
[   53.838913] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 us=
ecs
[   53.839441] calling  migration_init+0x0/0x80 @ 1
[   53.839813] initcall migration_init+0x0/0x80 returned 0 after 0 usecs
[   53.840309] calling  cpu_stop_init+0x0/0xa8 @ 1
[   53.840799] initcall cpu_stop_init+0x0/0xa8 returned 0 after 0 usecs
[   53.841304] calling  rcu_register_oom_notifier+0x0/0x1c @ 1
[   53.841759] initcall rcu_register_oom_notifier+0x0/0x1c returned 0 after=
 0 usecs
[   53.842322] calling  rcu_scheduler_really_started+0x0/0x14 @ 1
[   53.842788] initcall rcu_scheduler_really_started+0x0/0x14 returned 0 af=
ter 0 usecs
[   53.843365] calling  rcu_spawn_gp_kthread+0x0/0xa0 @ 1
[   53.843941] initcall rcu_spawn_gp_kthread+0x0/0xa0 returned 0 after 0 us=
ecs
[   53.844485] calling  relay_init+0x0/0x8 @ 1
[   53.844816] initcall relay_init+0x0/0x8 returned 0 after 0 usecs
[   53.845292] calling  tracer_alloc_buffers+0x0/0x1d4 @ 1
[   53.846086] initcall tracer_alloc_buffers+0x0/0x1d4 returned 0 after 390=
6 usecs
[   53.846644] calling  init_events+0x0/0x80 @ 1
[   53.847004] initcall init_events+0x0/0x80 returned 0 after 0 usecs
[   53.847481] calling  init_trace_printk+0x0/0x14 @ 1
[   53.847871] initcall init_trace_printk+0x0/0x14 returned 0 after 0 usecs
[   53.848393] calling  event_trace_memsetup+0x0/0x58 @ 1
[   53.849009] initcall event_trace_memsetup+0x0/0x58 returned 0 after 0 us=
ecs
[   53.886582] Brought up 32 CPUs
[   53.886920] Testing NMI watchdog ... OK.
[   53.971526] devtmpfs: initialized
[   53.972203] calling  ipc_ns_init+0x0/0x1c @ 1
[   53.972565] initcall ipc_ns_init+0x0/0x1c returned 0 after 0 usecs
[   53.973056] calling  init_mmap_min_addr+0x0/0x14 @ 1
[   53.973458] initcall init_mmap_min_addr+0x0/0x14 returned 0 after 0 usecs
[   53.973986] calling  init_cpufreq_transition_notifier_list+0x0/0x28 @ 1
[   53.974524] initcall init_cpufreq_transition_notifier_list+0x0/0x28 retu=
rned 0 after 0 usecs
[   53.975169] calling  net_ns_init+0x0/0x114 @ 1
[   53.975889] initcall net_ns_init+0x0/0x114 returned 0 after 3906 usecs
[   53.976491] calling  sparc_sysrq_init+0x0/0x38 @ 1
[   53.976878] initcall sparc_sysrq_init+0x0/0x38 returned 0 after 0 usecs
[   53.977397] calling  register_sparc64_cpufreq_notifier+0x0/0x20 @ 1
[   53.977883] initcall register_sparc64_cpufreq_notifier+0x0/0x20 returned=
 0 after 0 usecs
[   53.978501] calling  sstate_init+0x0/0x78 @ 1
[   53.978928] initcall sstate_init+0x0/0x78 returned 0 after 0 usecs
[   53.979417] calling  ldc_init+0x0/0xc8 @ 1
[   53.979797] ldc.c:v1.1 (July 22, 2008)
[   53.980089] ldc: Domaining disabled.
[   53.980392] initcall ldc_init+0x0/0xc8 returned -19 after 0 usecs
[   53.980862] calling  wq_sysfs_init+0x0/0x18 @ 1
[   53.981295] initcall wq_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[   53.981795] calling  ksysfs_init+0x0/0x8c @ 1
[   53.982175] initcall ksysfs_init+0x0/0x8c returned 0 after 0 usecs
[   53.982665] calling  init_jiffies_clocksource+0x0/0x14 @ 1
[   53.983098] initcall init_jiffies_clocksource+0x0/0x14 returned 0 after =
0 usecs
[   53.983654] calling  event_trace_enable+0x0/0x17c @ 1
[   53.984537] initcall event_trace_enable+0x0/0x17c returned 0 after 0 use=
cs
[   53.985074] calling  init_zero_pfn+0x0/0x28 @ 1
[   53.985437] initcall init_zero_pfn+0x0/0x28 returned 0 after 0 usecs
[   53.985924] calling  fsnotify_init+0x0/0x2c @ 1
[   53.986315] initcall fsnotify_init+0x0/0x2c returned 0 after 0 usecs
[   53.986803] calling  filelock_init+0x0/0xa0 @ 1
[   53.987269] initcall filelock_init+0x0/0xa0 returned 0 after 0 usecs
[   53.987773] calling  init_script_binfmt+0x0/0x20 @ 1
[   53.988189] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs
[   53.988710] calling  init_elf_binfmt+0x0/0x20 @ 1
[   53.989086] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
[   53.989586] calling  init_compat_elf_binfmt+0x0/0x20 @ 1
[   53.990003] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 =
usecs
[   53.990558] calling  debugfs_init+0x0/0x64 @ 1
[   53.990933] initcall debugfs_init+0x0/0x64 returned 0 after 0 usecs
[   53.991415] calling  securityfs_init+0x0/0x50 @ 1
[   53.991802] initcall securityfs_init+0x0/0x50 returned 0 after 0 usecs
[   53.992322] calling  prandom_init+0x0/0xe0 @ 1
[   53.992873] initcall prandom_init+0x0/0xe0 returned 0 after 0 usecs
[   53.993523] calling  regulator_init+0x0/0x7c @ 1
[   53.994263] regulator-dummy: no parameters
[   53.994678] initcall regulator_init+0x0/0x7c returned 0 after 0 usecs
[   53.995189] calling  cpufreq_core_init+0x0/0xec @ 1
[   53.995588] initcall cpufreq_core_init+0x0/0xec returned 0 after 0 usecs
[   53.996101] calling  sock_init+0x0/0x9c @ 1
[   53.996958] initcall sock_init+0x0/0x9c returned 0 after 0 usecs
[   53.997430] calling  net_inuse_init+0x0/0x2c @ 1
[   53.997843] initcall net_inuse_init+0x0/0x2c returned 0 after 0 usecs
[   53.998337] calling  netpoll_init+0x0/0x20 @ 1
[   53.998692] initcall netpoll_init+0x0/0x20 returned 0 after 0 usecs
[   53.999183] calling  netlink_proto_init+0x0/0x2c0 @ 1
[   53.999595] NET: Registered protocol family 16
[   53.999977] initcall netlink_proto_init+0x0/0x2c0 returned 0 after 0 use=
cs
[   54.000630] calling  scan_of_devices+0x0/0x38 @ 1
[   54.009270] initcall scan_of_devices+0x0/0x38 returned 0 after 7812 usecs
[   54.009795] calling  vio_init+0x0/0x194 @ 1
[   54.010217] VIO: Adding device channel-devices
[   54.010659] VIO: Adding device vldc-port-0-0
[   54.011062] VIO: Adding device vldc-port-0-1
[   54.011465] VIO: Adding device vldc-port-0-2
[   54.011867] VIO: Adding device vldc-port-1-0
[   54.012259] VIO: Adding device vldc-port-3-0
[   54.012704] VIO: Adding device vldc-port-3-8
[   54.013121] VIO: Adding device ds-1
[   54.013468] VIO: Adding device ds-0
[   54.013819] initcall vio_init+0x0/0x194 returned -19 after 3906 usecs
[   54.014322] calling  bdi_class_init+0x0/0x5c @ 1
[   54.014737] initcall bdi_class_init+0x0/0x5c returned 0 after 0 usecs
[   54.015234] calling  kobject_uevent_init+0x0/0x14 @ 1
[   54.015654] initcall kobject_uevent_init+0x0/0x14 returned 0 after 0 use=
cs
[   54.016189] calling  pcibus_class_init+0x0/0x1c @ 1
[   54.016601] initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs
[   54.017134] calling  pci_driver_init+0x0/0x14 @ 1
[   54.017576] initcall pci_driver_init+0x0/0x14 returned 0 after 0 usecs
[   54.018079] calling  backlight_class_init+0x0/0x68 @ 1
[   54.018512] initcall backlight_class_init+0x0/0x68 returned 0 after 0 us=
ecs
[   54.019054] calling  tty_class_init+0x0/0x48 @ 1
[   54.019449] initcall tty_class_init+0x0/0x48 returned 0 after 0 usecs
[   54.019945] calling  vtconsole_class_init+0x0/0xec @ 1
[   54.020443] initcall vtconsole_class_init+0x0/0xec returned 0 after 0 us=
ecs
[   54.020987] calling  regmap_initcall+0x0/0x14 @ 1
[   54.021395] initcall regmap_initcall+0x0/0x14 returned 0 after 0 usecs
[   54.021899] calling  spi_init+0x0/0x7c @ 1
[   54.022306] initcall spi_init+0x0/0x7c returned 0 after 0 usecs
[   54.058196] calling  topology_init+0x0/0xe4 @ 1
[   54.064558] initcall topology_init+0x0/0xe4 returned 0 after 3906 usecs
[   54.065070] calling  sbus_init+0x0/0x3ec @ 1
[   54.065429] initcall sbus_init+0x0/0x3ec returned 0 after 0 usecs
[   54.065902] calling  pcibios_init+0x0/0x14 @ 1
[   54.066282] initcall pcibios_init+0x0/0x14 returned 0 after 0 usecs
[   54.095986] calling  psycho_init+0x0/0x18 @ 1
[   54.096631] initcall psycho_init+0x0/0x18 returned 0 after 0 usecs
[   54.141431] calling  sabre_init+0x0/0x18 @ 1
[   54.142205] initcall sabre_init+0x0/0x18 returned 0 after 0 usecs
[   54.142681] calling  schizo_init+0x0/0x18 @ 1
[   54.160725] initcall schizo_init+0x0/0x18 returned 0 after 0 usecs
[   54.161208] calling  pci_sun4v_init+0x0/0x18 @ 1
[   54.161770] pci_sun4v: Registered hvapi major[1] minor[0]
[   54.174540] /pci@780: SUN4V PCI Bus Module
[   54.174869] /pci@780: On NUMA node 0
[   54.175162] /pci@780: PCI IO[e810000000] MEM[ea00000000]
[   54.186669] /pci@780: Unable to request IOMMU resource.
[   54.235500] /pci@780: MSI Queue first[0] num[36] count[128] devino[0x18]
[   54.236027] /pci@780: MSI first[0] num[256] mask[0xff] width[32]
[   54.236487] /pci@780: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:=
0x10000]
[   54.237217] /pci@780: MSI queues at RA [00000003f4300000]
[   54.237805] PCI: Scanning PBM /pci@780
[   54.238255] pci_sun4v f027e92c: PCI host bridge to bus 0000:02
[   54.238719] pci_bus 0000:02: root bus resource [io  0xe810000000-0xe81ff=
fffff] (bus address [0x0000-0xfffffff])
[   54.239499] pci_bus 0000:02: root bus resource [mem 0xea00000000-0xea7ff=
effff] (bus address [0x00000000-0x7ffeffff])
[   54.240286] pci_bus 0000:02: root bus resource [bus 02-07]
[   54.241062] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[   54.242337] pci 0000:03:01.0: PME# supported from D0 D3hot D3cold
[   54.243660] pci 0000:04:00.0: PME# supported from D0 D3hot
[   54.244650] pci 0000:04:00.1: PME# supported from D0 D3hot
[   54.250801] pci 0000:03:02.0: PME# supported from D0 D3hot D3cold
[   54.252080] pci 0000:03:08.0: PME# supported from D0 D3hot D3cold
[   54.264448] pci 0000:03:09.0: PME# supported from D0 D3hot D3cold
[   54.265749] pci 0000:07:00.0: supports D1 D2
[   54.266406] /pci@7c0: SUN4V PCI Bus Module
[   54.275813] /pci@7c0: On NUMA node 0
[   54.276098] /pci@7c0: PCI IO[f010000000] MEM[f200000000]
[   54.276515] /pci@7c0: Unable to request IOMMU resource.
[   54.325481] /pci@7c0: MSI Queue first[0] num[36] count[128] devino[0x18]
[   54.326016] /pci@7c0: MSI first[0] num[256] mask[0xff] width[32]
[   54.326643] /pci@7c0: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:=
0x10000]
[   54.327204] /pci@7c0: MSI queues at RA [00000003f4380000]
[   54.327621] PCI: Scanning PBM /pci@7c0
[   54.328055] pci_sun4v f0287174: PCI host bridge to bus 0001:02
[   54.328530] pci_bus 0001:02: root bus resource [io  0xf010000000-0xf01ff=
fffff] (bus address [0x0000-0xfffffff])
[   54.329290] pci_bus 0001:02: root bus resource [mem 0xf200000000-0xf27ff=
effff] (bus address [0x00000000-0x7ffeffff])
[   54.330075] pci_bus 0001:02: root bus resource [bus 02-09]
[   54.340931] pci 0001:02:00.0: PME# supported from D0 D3hot D3cold
[   54.342206] pci 0001:03:01.0: PME# supported from D0 D3hot D3cold
[   54.355600] pci 0001:04:00.0: PME# supported from D0 D3hot D3cold
[   54.357237] pci 0001:05:05.0: PME# supported from D3cold
[   54.358079] pci 0001:05:06.0: PME# supported from D3cold
[   54.369545] pci 0001:04:00.2: PME# supported from D0 D3hot D3cold
[   54.370829] pci 0001:03:02.0: PME# supported from D0 D3hot D3cold
[   54.372129] pci 0001:07:00.0: PME# supported from D0 D3hot
[   54.383360] pci 0001:07:00.1: PME# supported from D0 D3hot
[   54.384333] pci 0001:03:08.0: PME# supported from D0 D3hot D3cold
[   54.397713] pci 0001:03:09.0: PME# supported from D0 D3hot D3cold
[   54.398839] initcall pci_sun4v_init+0x0/0x18 returned 0 after 144531 use=
cs
[   54.399598] calling  fire_init+0x0/0x18 @ 1
[   54.400294] initcall fire_init+0x0/0x18 returned 0 after 0 usecs
[   54.400773] calling  param_sysfs_init+0x0/0x1c8 @ 1
[   54.404874] initcall param_sysfs_init+0x0/0x1c8 returned 0 after 0 usecs
[   54.405410] calling  pm_sysrq_init+0x0/0x20 @ 1
[   54.405777] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs
[   54.406272] calling  default_bdi_init+0x0/0x6c @ 1
[   54.411423] initcall default_bdi_init+0x0/0x6c returned 0 after 0 usecs
[   54.411947] calling  init_bio+0x0/0x120 @ 1
[   54.434279] bio: create slab <bio-0> at 0
[   54.434991] initcall init_bio+0x0/0x120 returned 0 after 0 usecs
[   54.435471] calling  fsnotify_notification_init+0x0/0x90 @ 1
[   54.485450] initcall fsnotify_notification_init+0x0/0x90 returned 0 afte=
r 0 usecs
[   54.486019] calling  cryptomgr_init+0x0/0x14 @ 1
[   54.486389] initcall cryptomgr_init+0x0/0x14 returned 0 after 0 usecs
[   54.503018] calling  blk_settings_init+0x0/0x30 @ 1
[   54.503408] initcall blk_settings_init+0x0/0x30 returned 0 after 0 usecs
[   54.516015] calling  blk_ioc_init+0x0/0x30 @ 1
[   54.516482] initcall blk_ioc_init+0x0/0x30 returned 0 after 0 usecs
[   54.516968] calling  blk_softirq_init+0x0/0x80 @ 1
[   54.528463] initcall blk_softirq_init+0x0/0x80 returned 0 after 0 usecs
[   54.528970] calling  blk_iopoll_setup+0x0/0x80 @ 1
[   54.529356] initcall blk_iopoll_setup+0x0/0x80 returned 0 after 0 usecs
[   54.540962] calling  genhd_device_init+0x0/0x7c @ 1
[   54.541903] initcall genhd_device_init+0x0/0x7c returned 0 after 0 usecs
[   54.553515] calling  blk_dev_integrity_init+0x0/0x30 @ 1
[   54.554030] initcall blk_dev_integrity_init+0x0/0x30 returned 0 after 0 =
usecs
[   54.566690] calling  pci_slot_init+0x0/0x4c @ 1
[   54.567072] initcall pci_slot_init+0x0/0x4c returned 0 after 0 usecs
[   54.567562] calling  fbmem_init+0x0/0xa0 @ 1
[   54.579050] initcall fbmem_init+0x0/0xa0 returned 0 after 0 usecs
[   54.579525] calling  misc_init+0x0/0xbc @ 1
[   54.579913] initcall misc_init+0x0/0xbc returned 0 after 0 usecs
[   54.592479] calling  vga_arb_device_init+0x0/0x104 @ 1
[   54.593069] vgaarb: loaded
[   54.593316] initcall vga_arb_device_init+0x0/0x104 returned 0 after 0 us=
ecs
[   54.604943] calling  cn_init+0x0/0xb4 @ 1
[   54.605303] initcall cn_init+0x0/0xb4 returned 0 after 0 usecs
[   54.605759] calling  dma_buf_init+0x0/0x74 @ 1
[   54.618264] initcall dma_buf_init+0x0/0x74 returned 0 after 0 usecs
[   54.618751] calling  init_scsi+0x0/0xc4 @ 1
[   54.619871] SCSI subsystem initialized
[   54.631284] initcall init_scsi+0x0/0xc4 returned 0 after 3906 usecs
[   54.631770] calling  serio_init+0x0/0x30 @ 1
[   54.632170] initcall serio_init+0x0/0x30 returned 0 after 0 usecs
[   54.643889] calling  input_init+0x0/0x110 @ 1
[   54.644303] initcall input_init+0x0/0x110 returned 0 after 0 usecs
[   54.656892] calling  rtc_init+0x0/0x5c @ 1
[   54.657248] initcall rtc_init+0x0/0x5c returned 0 after 0 usecs
[   54.657723] calling  power_supply_class_init+0x0/0x54 @ 1
[   54.669365] initcall power_supply_class_init+0x0/0x54 returned 0 after 0=
 usecs
[   54.669918] calling  hwmon_init+0x0/0x48 @ 1
[   54.670293] initcall hwmon_init+0x0/0x48 returned 0 after 0 usecs
[   54.682865] calling  watchdog_init+0x0/0x70 @ 1
[   54.683263] initcall watchdog_init+0x0/0x70 returned 0 after 0 usecs
[   54.696870] calling  leds_init+0x0/0x54 @ 1
[   54.697244] initcall leds_init+0x0/0x54 returned 0 after 0 usecs
[   54.697724] calling  proto_init+0x0/0x14 @ 1
[   54.711189] initcall proto_init+0x0/0x14 returned 0 after 0 usecs
[   54.711660] calling  net_dev_init+0x0/0x1f0 @ 1
[   54.712517] initcall net_dev_init+0x0/0x1f0 returned 0 after 0 usecs
[   54.726112] calling  neigh_init+0x0/0x9c @ 1
[   54.726460] initcall neigh_init+0x0/0x9c returned 0 after 0 usecs
[   54.726927] calling  fib_rules_init+0x0/0xc4 @ 1
[   54.740403] initcall fib_rules_init+0x0/0xc4 returned 0 after 0 usecs
[   54.740897] calling  pktsched_init+0x0/0x10c @ 1
[   54.741281] initcall pktsched_init+0x0/0x10c returned 0 after 0 usecs
[   54.754888] calling  tc_filter_init+0x0/0x60 @ 1
[   54.755259] initcall tc_filter_init+0x0/0x60 returned 0 after 0 usecs
[   54.768854] calling  tc_action_init+0x0/0x60 @ 1
[   54.769224] initcall tc_action_init+0x0/0x60 returned 0 after 0 usecs
[   54.769715] calling  genl_init+0x0/0xa8 @ 1
[   54.783210] initcall genl_init+0x0/0xa8 returned 0 after 0 usecs
[   54.783680] calling  wireless_nlevent_init+0x0/0x14 @ 1
[   54.784094] initcall wireless_nlevent_init+0x0/0x14 returned 0 after 0 u=
secs
[   54.798850] calling  clock_init+0x0/0x78 @ 1
[   54.799272] initcall clock_init+0x0/0x78 returned 0 after 0 usecs
[   54.814009] calling  sunfire_init+0x0/0x30 @ 1
[   54.814615] initcall sunfire_init+0x0/0x30 returned 0 after 0 usecs
[   54.815102] calling  dma_init+0x0/0x8 @ 1
[   54.829549] initcall dma_init+0x0/0x8 returned 0 after 0 usecs
[   54.830006] calling  auxio_init+0x0/0x18 @ 1
[   54.830472] initcall auxio_init+0x0/0x18 returned 0 after 0 usecs
[   54.846100] calling  ds_init+0x0/0xa4 @ 1
[   54.846655] ds.c:v1.0 (Jul 11, 2007)
[   54.847051] initcall ds_init+0x0/0xa4 returned 0 after 0 usecs
[   54.859607] calling  clocksource_done_booting+0x0/0x48 @ 1
[   54.860273] Switched to clocksource stick
[   54.860627] initcall clocksource_done_booting+0x0/0x48 returned 0 after =
393 usecs
[   54.872314] calling  tracer_init_debugfs+0x0/0x218 @ 1
[   54.874837] initcall tracer_init_debugfs+0x0/0x218 returned 0 after 2060=
 usecs
[   54.885481] calling  init_trace_printk_function_export+0x0/0x38 @ 1
[   54.885982] initcall init_trace_printk_function_export+0x0/0x38 returned=
 0 after 11 usecs
[   54.899716] calling  event_trace_init+0x0/0x234 @ 1
[   54.915510] initcall event_trace_init+0x0/0x234 returned 0 after 15036 u=
secs
[   54.916054] calling  init_pipe_fs+0x0/0x48 @ 1
[   54.916619] initcall init_pipe_fs+0x0/0x48 returned 0 after 178 usecs
[   54.917127] calling  eventpoll_init+0x0/0xbc @ 1
[   54.927909] initcall eventpoll_init+0x0/0xbc returned 0 after 313 usecs
[   54.928444] calling  anon_inode_init+0x0/0x64 @ 1
[   54.929013] initcall anon_inode_init+0x0/0x64 returned 0 after 184 usecs
[   54.942636] calling  tomoyo_initerface_init+0x0/0x138 @ 1
[   54.943061] initcall tomoyo_initerface_init+0x0/0x138 returned 0 after 0=
 usecs
[   54.956725] calling  aa_create_aafs+0x0/0xbc @ 1
[   54.957096] initcall aa_create_aafs+0x0/0xbc returned 0 after 0 usecs
[   54.957589] calling  blk_scsi_ioctl_init+0x0/0xcc @ 1
[   54.971230] initcall blk_scsi_ioctl_init+0x0/0xcc returned 0 after 0 use=
cs
[   54.971767] calling  chr_dev_init+0x0/0xe0 @ 1
[   54.996171] initcall chr_dev_init+0x0/0xe0 returned 0 after 9696 usecs
[   54.996700] calling  firmware_class_init+0x0/0x44 @ 1
[   54.997137] initcall firmware_class_init+0x0/0x44 returned 0 after 30 us=
ecs
[   55.001721] calling  cpufreq_gov_performance_init+0x0/0x14 @ 1
[   55.002193] initcall cpufreq_gov_performance_init+0x0/0x14 returned 0 af=
ter 1 usecs
[   55.017889] calling  sysctl_core_init+0x0/0x2c @ 1
[   55.018313] initcall sysctl_core_init+0x0/0x2c returned 0 after 39 usecs
[   55.032949] calling  inet_init+0x0/0x34c @ 1
[   55.033754] NET: Registered protocol family 2
[   55.035676] TCP established hash table entries: 131072 (order: 8, 209715=
2 bytes)
[   55.055913] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[   55.060382] TCP: Hash tables configured (established 131072 bind 65536)
[   55.062058] TCP: reno registered
[   55.062339] UDP hash table entries: 8192 (order: 5, 262144 bytes)
[   55.064014] UDP-Lite hash table entries: 8192 (order: 5, 262144 bytes)
[   55.076781] initcall inet_init+0x0/0x34c returned 0 after 42469 usecs
[   55.077282] calling  ipv4_offload_init+0x0/0x68 @ 1
[   55.077671] initcall ipv4_offload_init+0x0/0x68 returned 0 after 1 usecs
[   55.089277] calling  af_unix_init+0x0/0x5c @ 1
[   55.089706] NET: Registered protocol family 1
[   55.090102] initcall af_unix_init+0x0/0x5c returned 0 after 452 usecs
[   55.104724] calling  ipv6_offload_init+0x0/0x8c @ 1
[   55.105117] initcall ipv6_offload_init+0x0/0x8c returned 0 after 1 usecs
[   55.118738] calling  pci_apply_final_quirks+0x0/0x140 @ 1
[   55.119279] PCI: CLS mismatch (64 !=3D 512), using 64 bytes
[   55.119762] pci 0001:05:02.0: Activating ISA DMA hang workarounds
[   55.133389] PCI: Enabling device: (0001:05:05.0), cmd 2

--=20
Meelis Roos (mroos@linux.ee)
