From: David Ahern <david.ahern@oracle.com>
Date: Mon, 30 Mar 2015 22:54:05 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <5519D40D.20903@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>	<5515F6B8.8020606@oracle.com>	<5515F782.7060301@oracle.com>	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>	<551623C1.2040300@oracle.com>	<CAE9FiQUNLaNYAk6DoTDCAfbS=B1uks_=381KJDUk46+yg5cVwg@mail.gmail.com>	<5516BF4B.9030901@oracle.com>	<CAE9FiQV_BOKQu8+mCqQRx_RJYucwuGAfJog7qoUW0J_i=9u=Tg@mail.gmail.com>	<55181065.8090807@oracle.com> <CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
In-Reply-To: <CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 3/29/15 2:07 PM, Yinghai Lu wrote:
> [  286.647560] PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
> [  286.921232] PCI: Claiming 0000:00:01.0: Resource 15:
> 0000800100000000..00008004afffffff [220c]
> [  287.229190] PCI: Claiming 0000:01:00.0: Resource 15:
> 0000800100000000..00008004afffffff [220c]
> [  287.533428] PCI: Claiming 0000:02:04.0: Resource 15:
> 0000800100000000..000080012fffffff [220c]
> [  288.149831] PCI: Claiming 0000:03:00.0: Resource 15:
> 0000800100000000..000080012fffffff [220c]
> [  288.252466] PCI: Claiming 0000:04:06.0: Resource 14:
> 0000800100000000..000080010fffffff [220c]
> [  288.867196] PCI: Claiming 0000:05:00.0: Resource 0:
> 0000800100000000..0000800100001fff [204]
> [  288.968221] pci 0000:05:00.0: can't claim BAR 0 [mem
> 0x800100000000-0x800100001fff]: no compatible bridge window
>
> the bridge resource has IORESOURCE_PREFETCH, but the device doesn't have =
that.
>
> So pci_claim_resource can not find parent resource for device
> resource: we can not
> put non pref mem under pref mem.
>
> Can you send out result from ?
> lspci -vvxxx -s 0000:05:00.0

# lspci -vvxxx -s 0000:05:00.0
0000:05:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0=20
Host Controller (rev 03) (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort-=20
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 00000004
	Region 0: Memory at 100000000 (64-bit, non-prefetchable) [size=3D8K]
	Region 2: [virtual] Memory at ffff800000000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at ffff800000000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at ffff800000000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at ffff800000000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at ffff800000000000 [disabled]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
		Vector table: BAR=3D0 offset=00001000
		PBA: BAR=3D0 offset=00001080
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1=20
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us,=20
L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-=20
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF=20
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF=20
Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,=20
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-=20
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-=20
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+=20
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [150 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd
00: 12 19 14 00 06 04 10 00 03 30 03 0c 10 00 00 00
10: 04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 70 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
60: 30 20 00 00 00 00 00 00 00 00 00 00 09 18 20 00
70: 05 90 86 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 11 a0 07 80 00 10 00 00 80 10 00 00 00 00 00 00
a0: 10 00 02 00 c0 8f 00 00 00 28 19 00 12 ec 07 00
b0: 00 00 12 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 10 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 55 00 00 00 01 05 10 20 20 00
f0: 50 07 00 00 00 00 00 80 00 00 00 00 00 00 00 00


>
> If it does have pref, could be of device layer does not pass the pref
> flag properly
> via pci_parse_of_addrs/of_get_property(node, "assigned-addresses".
>
> or the addr0 from "ranges" and "assigned-address" has different definitio=
n.
>
> Thanks
>
> Yinghai
>

