From: Meelis Roos <mroos@linux.ee>
Date: Thu, 02 Jun 2016 19:11:38 +0000
Subject: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org, linux.pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

Between 4.5.0 and 4.6.0-rc3, my Spar Enterprise T5120 has started=20
showing the following messages during bootup:

[   64.564608] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_d=
word+0x64/0x80
[   64.564688] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_d=
word+0x64/0x80
[   64.564760] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_d=
word+0x64/0x80
[   64.564832] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_d=
word+0x64/0x80
[   64.564904] Kernel unaligned access at TPC[69fb04] pci_bus_read_config_d=
word+0x64/0x80


lspci -vvvxxx:


02:00.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at 00100000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=12, sec-latency=3D0
	I/O behind bridge: 00000000-00003fff
	Memory behind bridge: 00200000-00dfffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0000
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 10 00 00 00 00 00 02 03 12 00 01 31 00 00
20: 20 00 d0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 00 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 51 00 03 80 00 00
70: 00 00 09 00 81 dc 02 00 00 00 81 10 00 00 00 00
80: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

03:01.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=03, secondary=04, subordinate	, sec-latency=3D0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00200000-005fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0001
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 04 09 00 01 11 00 00
20: 20 00 50 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 01 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 00 03 80 00 00
70: 00 00 09 00 41 dc 1a 01 00 00 41 30 00 00 00 00
80: c0 01 48 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

03:02.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Physical Slot: 2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=03, secondary
, subordinate
, sec-latency=3D0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 00600000-00bfffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0006
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 0a 0a 00 21 21 00 00
20: 60 00 b0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 06 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 00 03 80 00 00
70: 00 00 09 00 41 dc 1a 02 00 00 41 30 80 0c 00 00
80: c0 03 48 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

03:08.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=03, secondary=0B, subordinate=11, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 00c00000-00dfffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0007
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 0b 11 00 31 31 00 00
20: c0 00 d0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 07 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 00 03 80 00 00
70: 00 00 09 00 81 dc 1a 08 00 00 81 30 00 00 00 00
80: c0 01 48 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

03:09.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=03, secondary=12, subordinate=12, sec-latency=3D0
	I/O behind bridge: 00004000-00003fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 000e
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #9, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending+ InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 12 12 00 41 31 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 0e 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 81 dc 1a 09 00 00 01 10 80 0c 10 00
80: c0 01 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

04:00.0 PCI bridge: PLX Technology, Inc. PEX 8517 16-lane, 5-port PCI Expre=
ss Switch (rev ac) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at 00200000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=04, secondary=05, subordinate	, sec-latency=3D0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00300000-005fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0002
	Capabilities: [68] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
00: b5 10 17 85 07 04 10 00 ac 00 04 06 10 00 01 00
10: 00 00 20 00 00 00 00 00 04 05 09 00 01 11 00 00
20: 30 00 50 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 00 00 00 00 05 68 81 00 00 00 ff ff
50: 03 00 00 00 02 00 00 00 ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 00 51 00 01 00 00 00
70: 00 00 0a 00 41 dc 02 00 00 00 41 10 00 00 00 00
80: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

05:01.0 PCI bridge: PLX Technology, Inc. PEX 8517 16-lane, 5-port PCI Expre=
ss Switch (rev ac) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=05, secondary=06, subordinate=07, sec-latency=3D0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 00300000-003fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0003
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
00: b5 10 17 85 07 04 10 00 ac 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 05 06 07 00 11 01 00 00
20: 30 00 30 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 00 00 00 00 05 68 81 00 00 00 ff ff
50: 03 00 00 00 03 00 00 00 ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 00 61 00 01 00 00 00
70: 00 00 00 00 41 dc 1a 01 00 00 11 30 00 00 00 00
80: c0 01 00 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

05:02.0 PCI bridge: PLX Technology, Inc. PEX 8517 16-lane, 5-port PCI Expre=
ss Switch (rev ac) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=05, secondary=08, subordinate=08, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00400000-004fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0004
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
00: b5 10 17 85 07 04 10 00 ac 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 05 08 08 00 01 01 00 00
20: 40 00 40 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 00 00 00 00 05 68 81 00 00 00 ff ff
50: 03 00 00 00 04 00 00 00 ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 00 61 00 01 00 00 00
70: 00 00 00 00 41 dc 1a 02 00 00 41 30 00 00 00 00
80: c0 01 00 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

05:03.0 PCI bridge: PLX Technology, Inc. PEX 8517 16-lane, 5-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=05, secondary	, subordinate	, sec-latency=3D0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00500000-005fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0005
	Capabilities: [68] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Device Serial Number 00-00-00-01-00-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=3D1 ArbSelect=3DFixed TC/VC=00
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
00: b5 10 17 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 05 09 09 00 11 11 00 00
20: 50 00 50 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 00 00 00 00 05 68 81 00 00 00 ff ff
50: 03 00 00 00 05 00 00 00 ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 00 61 00 01 00 00 00
70: 00 00 00 00 41 dc 1a 03 00 00 41 30 00 00 00 00
80: c0 01 00 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

06:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI=
 Bridge (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=06, secondary=07, subordinate=07, sec-latency=3D0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 00300000-003fffff
	Prefetchable memory behind bridge: 00000000-ffffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <=
1us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Power Budgeting <?>
00: b5 10 12 81 07 00 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 06 07 07 00 10 00 20 02
20: 30 00 30 00 00 00 f0 ff 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 02 5a 00 00 00 00 11 20 0e 00 00 00 00 00
50: 05 60 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 71 00 20 00 00 00 07 50 00 00 11 4c 02 00
70: 00 00 11 00 80 0c 00 00 00 00 40 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

07:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-=
if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 00300000 (32-bit, non-prefetchable) [size=3D8K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: ohci-pci
00: 33 10 35 00 06 00 10 02 43 10 03 0c 10 40 80 00
10: 00 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 01 2a
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 05 33 b0 6c 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

07:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-=
if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 23
	Region 0: Memory at 00302000 (32-bit, non-prefetchable) [size=3D8K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: ohci-pci
00: 33 10 35 00 06 00 10 02 43 10 03 0c 10 40 00 00
10: 00 20 30 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 01 2a
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

07:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 0=
4) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at 00304000 (32-bit, non-prefetchable) [size=3D8K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 33 10 e0 00 02 00 10 02 04 20 03 0c 10 40 00 00
10: 00 40 30 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 e0 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 03 10 22
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 3f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 05 33 b0 6c 00 00 00 00 01 00 00 00 00 00 00 c0
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

08:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 76
	Region 0: Memory at 00400000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: I/O ports at <unassigned> [size2]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 000f
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-23-f2-2a
	Kernel driver in use: e1000e
00: 86 80 5e 10 46 05 10 00 06 00 00 02 10 00 80 00
10: 00 00 40 00 00 00 00 00 01 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 5e 10
30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 48 00 20 00 21
d0: 05 e0 81 00 00 00 ff ff 03 00 00 00 0f 00 00 00
e0: 10 00 01 00 c1 0c 00 00 1f 28 0a 00 41 6c 03 02
f0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00

08:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 79
	Region 0: Memory at 00420000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: I/O ports at 0020 [size2]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0012
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-23-f2-2a
	Kernel driver in use: e1000e
00: 86 80 5e 10 46 05 10 00 06 00 00 02 10 00 80 00
10: 00 00 42 00 00 00 00 00 21 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 5e 10
30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 48 00 20 00 21
d0: 05 e0 81 00 00 00 ff ff 03 00 00 00 12 00 00 00
e0: 10 00 01 00 c1 0c 00 00 1f 28 0a 00 41 6c 03 02
f0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00

09:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 80
	Region 0: Memory at 00500000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: I/O ports at 1000 [size2]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0013
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-23-f2-2c
	Kernel driver in use: e1000e
00: 86 80 5e 10 46 05 10 00 06 00 00 02 10 00 80 00
10: 00 00 50 00 00 00 00 00 01 10 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 5e 10
30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 48 00 20 00 21
d0: 05 e0 81 00 00 00 ff ff 03 00 00 00 13 00 00 00
e0: 10 00 01 00 c1 0c 00 00 1f 28 0a 00 41 6c 03 03
f0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00

09:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)
	Subsystem: Oracle/SUN Device 105e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 81
	Region 0: Memory at 00520000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 2: I/O ports at 1020 [size2]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000003ffff0000  Data: 0014
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-23-f2-2c
	Kernel driver in use: e1000e
00: 86 80 5e 10 46 05 10 00 06 00 00 02 10 00 80 00
10: 00 00 52 00 00 00 00 00 21 10 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 5e 10
30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 48 00 20 00 21
d0: 05 e0 81 00 00 00 ff ff 03 00 00 00 14 00 00 00
e0: 10 00 01 00 c1 0c 00 00 1f 28 0a 00 41 6c 03 03
f0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00

0a:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1068E PCI-Exp=
ress Fusion-MPT SAS (rev 04)
	Subsystem: LSI Logic / Symbios Logic Device 1000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 512 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 2000 [disabled] [size%6]
	Region 1: Memory at 00600000 (64-bit, non-prefetchable) [sizedK]
	Region 3: Memory at 00610000 (64-bit, non-prefetchable) [sizedK]
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Expansion ROM at 00800000 [disabled] [size=3D4M]
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
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [98] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
		Vector table: BAR=3D1 offset=00002000
		PBA: BAR=3D1 offset=00003000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: mptsas
00: 00 10 58 00 06 00 10 00 04 00 00 01 80 00 00 00
10: 01 20 00 00 04 00 60 00 00 00 00 00 04 00 61 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 80 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 68 02 06 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 0a 00 00 10 98 01 00 25 00 00 00
70: 10 28 0a 00 81 0c 00 00 00 00 41 10 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 05 b0 80 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 00 00 00 01 20 00 00 01 30 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0b:00.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at 00c00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0B, secondary=0C, subordinate=11, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 00d00000-00dfffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0008
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 c0 00 00 00 00 00 0b 0c 11 00 31 31 00 00
20: d0 00 d0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 08 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 51 00 03 80 00 00
70: 00 00 09 00 81 dc 02 00 00 00 81 10 00 00 00 00
80: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0c:01.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Physical Slot: 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0C, secondary
, subordinate
, sec-latency=3D0
	I/O behind bridge: 00003000-00002fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 0009
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending+ InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0c 0d 0d 00 31 21 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 09 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 41 dc 1a 01 00 00 01 10 80 0c 08 00
80: c0 01 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0c:02.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0C, secondary=0E, subordinate=0E, sec-latency=3D0
	I/O behind bridge: 00003000-00002fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 000a
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending+ InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0c 0e 0e 00 31 21 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 0a 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 41 dc 1a 02 00 00 01 10 80 0c 20 00
80: c0 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0c:08.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0C, secondary=0F, subordinate=0F, sec-latency=3D0
	I/O behind bridge: 00003000-00002fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 000b
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #5, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending+ InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0c 0f 0f 00 31 21 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 0b 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 81 dc 1a 08 00 00 01 10 80 0c 28 00
80: c0 01 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0c:09.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0C, secondary=10, subordinate=10, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 00d00000-00dfffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 000c
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #9, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <=
2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0c 10 10 00 31 31 00 00
20: d0 00 d0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 0c 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 41 dc 1a 09 00 00 41 30 80 0c 00 00
80: c0 01 48 01 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0c:0a.0 PCI bridge: PLX Technology, Inc. PEX 8533 32-lane, 6-port PCI Expre=
ss Switch (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 1: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Bus: primary=0C, secondary=11, subordinate=11, sec-latency=3D0
	I/O behind bridge: 00004000-00003fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- <SERR- <PERR-
	[virtual] Expansion ROM at ffffff3f00000000 [disabled]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [48] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
		Address: 00000003ffff0000  Data: 000d
		Masking: 00000001  Pending: ffffffff
	Capabilities: [68] Express (v1) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #10, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s =
<2us, L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
	Capabilities: [90] Subsystem: PLX Technology, Inc. PEX 8533 32-lane, 6-por=
t PCI Express Switch
	Capabilities: [100 v1] Device Serial Number aa-85-48-10-b5-00-0e-df
	Capabilities: [fb4 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=100ns PATEntryBits=3D4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=06 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32+ WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
			Status:	NegoPending+ InProgress-
			Port Arbitration Table <?>
	Kernel driver in use: pcieport
00: b5 10 33 85 07 04 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0c 11 11 00 41 31 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 48 03 c8 08 00 00 00 05 68 81 01 00 00 ff ff
50: 03 00 00 00 0d 00 00 00 01 00 00 00 ff ff ff ff
60: ff ff ff ff ff ff ff ff 10 90 61 01 03 80 00 00
70: 00 00 09 00 41 dc 1a 0a 00 00 01 10 80 0c 18 00
80: c0 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
90: 0d 00 00 00 b5 10 33 85 ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: b5 10 33 85 aa 00 00 00 ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

10:00.0 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI =
Express HBA (rev 03)
	Subsystem: QLogic Corp. Device 0143
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at 3000 [disabled] [size%6]
	Region 1: Memory at 00d00000 (64-bit, non-prefetchable) [size=16K]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Expansion ROM at 00d40000 [disabled] [size%6K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit Latency L0s <4us=
, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [64] MSI: Enable- Count=3D1/16 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [74] Vital Product Data
		Product Name: SG-(X)PCIE2FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Ex=
press Dual Channel Host Bus Adapter
		Read-only fields:
			[PN] Part number: 375-3356-02
			[SN] Serial number: 0402R00-0906697031
			[V0] Vendor specific: PW=15W
			[EC] Engineering changes: R50
			[MN] Manufacture ID: 53 75 6e 20 4d 69 63 72 6f 73 79 73 74 65 6d 73 2c =
20 49 6e 63 2e
			[V1] Vendor specific: 01.08
			[V3] Vendor specific: 04.00.26
			[V4] Vendor specific: 01.24
			[V5] Vendor specific: 01.24
			[YA] Asset tag:                =20
			[RV] Reserved: checksum good, 0 byte(s) reserved
		End
	Capabilities: [7c] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=3D1 offset=00002000
		PBA: BAR=3D1 offset=00003000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Kernel driver in use: qla2xxx
00: 77 10 32 24 46 01 10 00 03 00 04 0c 10 00 80 00
10: 01 30 00 00 04 00 d0 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 77 10 43 01
30: 00 00 d4 00 44 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 01 4c 02 00 00 00 00 00 10 64 01 00
50: 83 71 64 00 1f 58 0a 00 41 e4 03 00 00 00 41 10
60: 00 00 00 00 05 74 88 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 03 7c e8 80 60 78 00 00 11 00 0f 80
80: 01 20 00 00 01 30 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

10:00.1 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI =
Express HBA (rev 03)
	Subsystem: QLogic Corp. Device 0143
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 22
	Region 0: I/O ports at 3100 [disabled] [size%6]
	Region 1: Memory at 00d04000 (64-bit, non-prefetchable) [size=16K]
	Region 3: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffffff3f00000000 (32-bit, non-prefetchable)
	Expansion ROM at 00d80000 [disabled] [size%6K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit Latency L0s <4us=
, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [64] MSI: Enable- Count=3D1/16 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [74] Vital Product Data
		Product Name: SG-(X)PCIE2FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Ex=
press Dual Channel Host Bus Adapter
		Read-only fields:
			[PN] Part number: 375-3356-02
			[SN] Serial number: 0402R00-0906697031
			[V0] Vendor specific: PW=15W
			[EC] Engineering changes: R50
			[MN] Manufacture ID: 53 75 6e 20 4d 69 63 72 6f 73 79 73 74 65 6d 73 2c =
20 49 6e 63 2e
			[V1] Vendor specific: 01.08
			[V3] Vendor specific: 04.00.26
			[V4] Vendor specific: 01.24
			[V5] Vendor specific: 01.24
			[YA] Asset tag:                =20
			[RV] Reserved: checksum good, 0 byte(s) reserved
		End
	Capabilities: [7c] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=3D1 offset=00002000
		PBA: BAR=3D1 offset=00003000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Kernel driver in use: qla2xxx
00: 77 10 32 24 46 01 10 00 03 00 04 0c 10 00 80 00
10: 01 31 00 00 04 40 d0 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 77 10 43 01
30: 00 00 d8 00 44 00 00 00 00 00 00 00 00 02 00 00
40: 00 00 00 00 01 4c 02 00 00 00 00 00 10 64 01 00
50: 83 71 64 00 1f 58 0a 00 41 e4 03 00 00 00 41 10
60: 00 00 00 00 05 74 88 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 03 7c e8 80 60 78 00 00 11 00 0f 80
80: 01 20 00 00 01 30 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



--=20
Meelis Roos (mroos@linux.ee)
