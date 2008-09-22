From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 Sep 2008 12:49:12 +0000
Subject: Re: [PATCH]: Fix disappearing PCI devices
Message-Id: <Pine.SOC.4.64.0809221537220.6574@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20080921.163315.125565921.davem@davemloft.net>
In-Reply-To: <20080921.163315.125565921.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> Ok, new patch to go on top of the previous fixes.
>=20
> It's the same issue as was present in the of_device.c code.
>=20
> I hope your PCI QFE cards will show up now :-)

Yes, they do. Now everything I know to test from the current hardware=20
configuration seems to be working, great! Will change it to be a more=20
diverse config for routine testing on future Linux builds.

By the way, there seems to be a EBUS bridge together with each PCI HME -=20
what are these useful for?

Thank you very much for your work on this!

[  133.345997] eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:2=
0:9d:77:08
[  133.437738] eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:2=
0:9d:77:09
[  133.529438] eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:2=
0:9d:77:0a
[  133.621286] eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:2=
0:9d:77:0b
[  133.713161] eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:=
e2
[  133.797039] eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:2=
0:93:79:94
[  133.889328] eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:2=
0:93:79:95
[  133.981753] eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:2=
0:93:79:96
[  134.074381] eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:2=
0:93:79:97
[  134.167835] eth9-12: Quattro HME (PCI/CheerIO) 10/100baseT Ethernet DEC =
21153 PCI Bridge
[  134.262734] eth9: Quattro HME slot 0 (PCI/CheerIO) 10/100baseT Ethernet =
08:00:20:f6:fd:dc
[  134.365130] eth10: Quattro HME slot 1 (PCI/CheerIO) 10/100baseT Ethernet=
 08:00:20:f6:fd:dd
[  134.466726] eth11: Quattro HME slot 2 (PCI/CheerIO) 10/100baseT Ethernet=
 08:00:20:f6:fd:de
[  134.568457] eth12: Quattro HME slot 3 (PCI/CheerIO) 10/100baseT Ethernet=
 08:00:20:f6:fd:df
[  134.670080] eth13: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:2=
0:b6:ee:e2

and lspci -vvv:

0000:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 01000000 (32-bit, non-prefetchable) [disabled] [size=
=16M]
	Region 1: Memory at 02000000 (32-bit, non-prefetchable) [disabled] [size=
=3D8M]
	Region 2: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 3: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 4: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 5: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Expansion ROM at fffffe2a80000000 [disabled] [size=3D1]

0000:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l 10/100 Ethernet [hme] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 255 (2500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 28
	Region 0: Memory at 02800000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2a80000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2a80000000 [disabled] [size=3D1]
	Kernel driver in use: hme

0001:80:02.0 PCI bridge: Digital Equipment Corporation DECchip 21153 (rev 0=
4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=80, secondary=81, subordinate=81, sec-latency=3D0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 00100000-088fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ <SERR- <PERR-
	[virtual] Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent"0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

0001:81:00.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at 01000000 (32-bit, non-prefetchable) [disabled] [size=
=16M]
	Region 1: Memory at 02000000 (32-bit, non-prefetchable) [disabled] [size=
=3D8M]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]

0001:81:00.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l 10/100 Ethernet [hme] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 31
	Region 0: Memory at 02800000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]
	Kernel driver in use: hme

0001:81:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at 03000000 (32-bit, non-prefetchable) [disabled] [size=
=16M]
	Region 1: Memory at 04000000 (32-bit, non-prefetchable) [disabled] [size=
=3D8M]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]

0001:81:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l 10/100 Ethernet [hme] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 32
	Region 0: Memory at 04800000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]
	Kernel driver in use: hme

0001:81:02.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at 05000000 (32-bit, non-prefetchable) [disabled] [size=
=16M]
	Region 1: Memory at 06000000 (32-bit, non-prefetchable) [disabled] [size=
=3D8M]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]

0001:81:02.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l 10/100 Ethernet [hme] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 33
	Region 0: Memory at 06800000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]
	Kernel driver in use: hme

0001:81:03.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at 07000000 (32-bit, non-prefetchable) [disabled] [size=
=16M]
	Region 1: Memory at 08000000 (32-bit, non-prefetchable) [disabled] [size=
=3D8M]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[disabled] [size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]

0001:81:03.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Mea=
l 10/100 Ethernet [hme] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 30
	Region 0: Memory at 08800000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2b00000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2b00000000 [disabled] [size=3D1]
	Kernel driver in use: hme

0002:00:03.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (=
rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 0: I/O ports at 0400 [size%6]
	Region 1: Memory at 00002000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: [virtual] Memory at fffffe2880000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2880000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2880000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2880000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at 00010000 [disabled] [sizedK]
	Kernel driver in use: qla1280

0003:80:02.0 FDDI network controller: SysKonnect FDDI Adapter (rev 23)
	Subsystem: SysKonnect Device 5821
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2000ns min, 40000ns max)
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at 00002000 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: I/O ports at 0400 [size%6]
	Region 2: [virtual] Memory at fffffe2900000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe2900000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe2900000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe2900000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe2900000000 [disabled] [size=3D1]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Vital Product Data <?>
	Kernel driver in use: skfddi
	Kernel modules: skfp




--=20
Meelis Roos (mroos@linux.ee)
