From: Meelis Roos <mroos@linux.ee>
Date: Wed, 04 Mar 2009 07:38:24 +0000
Subject: esp scsi problem on shutdown
Message-Id: <Pine.SOC.4.64.0903040909580.6557@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

since my E3500 and E450 started working mostly fine, I installed Linux 
on an E3000. Here is the first problem I encountered.

I successfully installed Debian Lenny with 2.6.26 kernel, later compiled 
yesterdays 2.6.29-rc6+git. Both kernels have the same problem - on 
shutdown, scsi disk goes offline like in console log below. This is 
repeatable and happens every shutdown so far.

There are 2 SCSI disks on ESP controller (builtin ESP on SBus IO board), 
sda is system disk, sdb is not used. sda (18G IBM) has so far worked 
fine otherwise. sdb had problems that are probably firmware-related - 
PROM errors out finding it and booting from it (something along the 
lines of "unexpeted message 2") but once Linux is booted, it can use the 
disk fine (netbooted installer installed linux first on this disk 
successfully). sdb is not mounted though and is not in use.

Another quirk with the machine is that PROM reports TOD on clockboard is 
dead and it's using TOD from IO board. This does not _seem_ to coause 
any trouble but is noted here for completeness - that is, I'm not 100% 
sure the hardware is OK but I do not see something directly related to 
the problem.

Here are the console messages from 2.6.29-rc6+git:

3,0>ERROR: TEST=NVRAM Devices,SUBTEST=M48T59 (TOD) Init ID=8.1
3,0>Component under test: Board 16 Firehose Bus
3,0>TODC battery is low bit set
Detected failed TOD on clock board. Using backup TOD on board in slot 1

[...]

[  113.862260] esp: esp0, regs[1c738810000:1c738800000] irq[19]
[  113.928122] esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[  117.001940] scsi0 : esp
[  117.037342] scsi 0:0:0:0: Direct-Access     IBM      DDYS-T18350M     S96H PQ: 0 ANSI: 3
[  117.132592] scsi target0:0:0: Beginning Domain Validation
[  117.204391] scsi target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
[  117.293605] scsi target0:0:0: Domain Validation skipping write tests
[  117.367745] scsi target0:0:0: Ending Domain Validation
[  117.447420] scsi 0:0:1:0: Direct-Access     HP       9.10GB A 80-6331      PQ: 0 ANSI: 2
[  117.542504] scsi target0:0:1: Beginning Domain Validation
[  117.620036] scsi target0:0:1: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
[  117.711438] scsi target0:0:1: Domain Validation skipping write tests
[  117.785621] scsi target0:0:1: Ending Domain Validation
[  120.911763] Driver 'sd' needs updating - please use bus_type methods
[  120.990858] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  121.083118] sd 0:0:0:0: [sda] Write Protect is off
[  121.139079] sd 0:0:0:0: [sda] Mode Sense: cb 00 00 08
[  121.201372] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  121.310760] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  121.403030] sd 0:0:0:0: [sda] Write Protect is off
[  121.458948] sd 0:0:0:0: [sda] Mode Sense: cb 00 00 08
[  121.521371] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  121.627859]  sda: sda1 sda2 sda3 sda4
[  121.692369] sd 0:0:0:0: [sda] Attached SCSI disk
[  121.749840] sd 0:0:1:0: [sdb] 17773524 512-byte hardware sectors: (9.10 GB/8.47 GiB)
[  121.842920] sd 0:0:1:0: [sdb] Write Protect is off
[  121.898363] sd 0:0:1:0: [sdb] Mode Sense: 9f 00 10 08
[  121.961410] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  122.065148] sd 0:0:1:0: [sdb] 17773524 512-byte hardware sectors: (9.10 GB/8.47 GiB)
[  122.158288] sd 0:0:1:0: [sdb] Write Protect is off
[  122.213717] sd 0:0:1:0: [sdb] Mode Sense: 9f 00 10 08
[  122.276824] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  122.378053]  sdb: sdb1 sdb2 sdb3 sdb4
[  122.438102] sd 0:0:1:0: [sdb] Attached SCSI disk

[...]

Deconfiguring network interfaces...There is already a pid file /var/run/dhclient.eth0.pid with pid 1186
removed stale PID file
Internet Systems Consortium DHCP Client V3.1.1
Copyright 2004-2008 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/

Listening on LPF/eth0/08:00:20:83:b3:ae
Sending on   LPF/eth0/08:00:20:83:b3:ae
Sending on   Socket/fallback
DHCPRELEASE on eth0 to 172.30.0.1 port 67
[20587.701051] esp: esp0: Aborting command [fffff8003f3c27e0:28]
[20587.767788] esp: esp0: Current command [fffff8003f3c27e0:28]
[20587.835490] esp: esp0: Active command [fffff8003f3c27e0:28]
[20587.902161] esp: esp0: Dumping command log
[20587.951123] esp: esp0: ent[24] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20588.058458] esp: esp0: ent[25] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20588.167848] esp: esp0: ent[26] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20588.275156] esp: esp0: ent[27] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20588.384553] esp: esp0: ent[28] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[20588.491861] esp: esp0: ent[29] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20588.599166] esp: esp0: ent[30] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20588.706474] esp: esp0: ent[31] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
[20588.815863] esp: esp0: ent[0] EVENT val[06] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0d]
[20588.924220] esp: esp0: ent[1] CMD val[10] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[06]
[20589.030484] esp: esp0: ent[2] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[20589.136749] esp: esp0: ent[3] EVENT val[0c] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[20589.245103] esp: esp0: ent[4] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[20589.351368] esp: esp0: ent[5] CMD val[12] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[20589.457631] esp: esp0: ent[6] CMD val[44] sreg[90] seqreg[04] sreg2[20] ireg[20] ss[00] event[0c]
[20589.563903] esp: esp0: ent[7] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[0c] ss[00] event[0c]
[20589.670166] esp: esp0: ent[8] CMD val[90] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[20589.776431] esp: esp0: ent[9] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[20589.882702] esp: esp0: ent[10] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0c]
[20589.992094] esp: esp0: ent[11] EVENT val[04] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20590.101484] esp: esp0: ent[12] CMD val[90] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[04]
[20590.208792] esp: esp0: ent[13] EVENT val[05] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[04]
[20590.318181] esp: esp0: ent[14] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[20590.425496] esp: esp0: ent[15] EVENT val[0d] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[20590.534887] esp: esp0: ent[16] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20590.642194] esp: esp0: ent[17] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20590.749499] esp: esp0: ent[18] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20590.858891] esp: esp0: ent[19] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20590.966204] esp: esp0: ent[20] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20591.075597] esp: esp0: ent[21] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[20591.182903] esp: esp0: ent[22] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20591.290214] esp: esp0: ent[23] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20617.410447] esp: esp0: Aborting command [fffff8003f3c27e0:00]
[20617.477209] esp: esp0: Current command [fffff8003f3c27e0:00]
[20617.544913] esp: esp0: Active command [fffff8003f3c27e0:00]
[20617.611588] esp: esp0: Dumping command log
[20617.660548] esp: esp0: ent[0] EVENT val[06] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0d]
[20617.768934] esp: esp0: ent[1] CMD val[10] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[06]
[20617.875190] esp: esp0: ent[2] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[20617.981466] esp: esp0: ent[3] EVENT val[0c] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[20618.089814] esp: esp0: ent[4] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[20618.196079] esp: esp0: ent[5] CMD val[12] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[20618.302342] esp: esp0: ent[6] CMD val[44] sreg[90] seqreg[04] sreg2[20] ireg[20] ss[00] event[0c]
[20618.408614] esp: esp0: ent[7] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[0c] ss[00] event[0c]
[20618.514876] esp: esp0: ent[8] CMD val[90] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[20618.621149] esp: esp0: ent[9] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[20618.727412] esp: esp0: ent[10] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0c]
[20618.836809] esp: esp0: ent[11] EVENT val[04] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20618.946191] esp: esp0: ent[12] CMD val[90] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[04]
[20619.053505] esp: esp0: ent[13] EVENT val[05] sreg[90] seqreg[04] sreg2[00] ireg[10] ss[00] event[04]
[20619.162897] esp: esp0: ent[14] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[20619.270203] esp: esp0: ent[15] EVENT val[0d] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[20619.379596] esp: esp0: ent[16] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20619.486902] esp: esp0: ent[17] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20619.594216] esp: esp0: ent[18] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[20619.703605] esp: esp0: ent[19] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20619.810916] esp: esp0: ent[20] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[20619.920303] esp: esp0: ent[21] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[20620.027611] esp: esp0: ent[22] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.134925] esp: esp0: ent[23] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.242230] esp: esp0: ent[24] CMD val[1a] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.349537] esp: esp0: ent[25] CMD val[03] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.456849] esp: esp0: ent[26] CMD val[02] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.564155] esp: esp0: ent[27] CMD val[80] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.671462] esp: esp0: ent[28] CMD val[80] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.778774] esp: esp0: ent[29] CMD val[03] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.886082] esp: esp0: ent[30] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20620.993390] esp: esp0: ent[31] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[20637.120304] sd 0:0:0:0: Device offlined - not ready after error recovery


-- 
Meelis Roos (mroos@linux.ee)
