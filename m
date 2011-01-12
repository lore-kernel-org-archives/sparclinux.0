From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 12 Jan 2011 01:30:25 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <1294795825.13868.6.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2011-01-11 at 16:22 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Wed, 12 Jan 2011 00:20:50 +0000
> 
> > On Tue, 2011-01-11 at 15:48 -0800, David Miller wrote:
> > 
> >> This patch set makes sure that FB drivers for PCI devices utilizing
> >> the svgalib interfaces work on multi-domain PCI architectures.
> >> 
> >> Basically this amounts to making sure that the vgastate->vgabase
> >> __iomem pointer makes it way into every interfaces and gets used
> >> by all of the I/O access calls.
> > 
> > jeez, that was fast work! I'd already done the changes in s3fb.c but
> > didn't get as far as you did with this. 
> > 
> > I'm now testing your patches right now.
> 
> Thanks a lot in advance for testing Alex.

With your patches, this happens:

Jan 12 01:24:20 sodium kernel: fb1: S3 Virge/GX on 0000:00:03.0, 6 MB RAM, 14 MHz MCLK
Jan 12 01:24:24 sodium kernel: eth0: Link down, cable problem?
Jan 12 01:24:36 sodium kernel: eth0: Auto-Negotiation unsuccessful, trying force link mode
Jan 12 01:24:45 sodium kernel: eth0: Link down, cable problem?
Jan 12 01:24:47 sodium kernel: ERROR(1): Cheetah error trap taken afsr[0010100000000000] afar[00000000000a0000] TL1(0)
Jan 12 01:24:47 sodium kernel: ERROR(1): TPC[1057490c] TNPC[10574910] O7[80] TSTATE[9911001600]
Jan 12 01:24:47 sodium kernel: ERROR(1): TPC<restore_vga+0x8c0/0x1068 [vgastate]>
Jan 12 01:24:47 sodium kernel: ERROR(1): M_SYND(0),  E_SYND(0), Privileged
Jan 12 01:24:47 sodium kernel: ERROR(1): Highest priority error (0000100000000000) "Unmapped error from system bus"
Jan 12 01:24:47 sodium kernel: ERROR(1): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
Jan 12 01:24:47 sodium kernel: ERROR(1): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
Jan 12 01:24:47 sodium kernel: ERROR(1): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
Jan 12 01:24:47 sodium kernel: ERROR(1): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Jan 12 01:24:47 sodium kernel: ERROR(1): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Jan 12 01:24:47 sodium kernel: ERROR(1): E-cache idx[a0000] tag[0000000001000049]
Jan 12 01:24:47 sodium kernel: ERROR(1): E-cache data0[82006c3080a08001] data1[1268001b03001c87] data2[25002050f05c24d0] data3[230021f8e65861e0]
Jan 12 01:24:47 sodium kernel: Kernel panic - not syncing: Irrecoverable deferred error trap.
Jan 12 01:24:47 sodium kernel: 
Jan 12 01:24:47 sodium kernel: sym0: SCSI BUS reset detected.
Jan 12 01:24:47 sodium kernel: sym0: SCSI BUS has been reset.
Jan 12 01:24:47 sodium kernel: Call Trace:
Jan 12 01:24:47 sodium kernel: [00000000004292d0] cheetah_deferred_handler+0x494/0x4cc
Jan 12 01:24:47 sodium kernel: [0000000000405e70] c_deferred+0x18/0x24
Jan 12 01:24:47 sodium kernel: [000000001057490c] restore_vga+0x8c0/0x1068 [vgastate]
Jan 12 01:24:47 sodium kernel: [00000000105b0840] s3fb_release+0x40/0x6c [s3fb]
Jan 12 01:24:47 sodium kernel: [00000000005ca0fc] fb_release+0x24/0x4c
Jan 12 01:24:47 sodium kernel: [00000000004bb8a0] fput+0x118/0x1e0
Jan 12 01:24:47 sodium kernel: [00000000004b9100] filp_close+0x64/0x78
Jan 12 01:24:47 sodium kernel: [00000000004b91a0] SyS_close+0x8c/0xe4
Jan 12 01:24:47 sodium kernel: [0000000000406154] linux_sparc_syscall32+0x34/0x40


-- 
Tactical Nuclear Kittens
