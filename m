From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 26 Jan 2007 22:15:30 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169849730.4809.33.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2007-01-26 at 16:05 -0600, Tom 'spot' Callaway wrote:
> On Sun, 2007-01-21 at 17:25 +0200, Meelis Roos wrote:
> > TS> Warning: unable to open an initial console.
> > 
> > Try to use network console if the native console is not supported.
> > netconsole=..., see Documentation/networking/netconsole.txt
> 
> It was a good idea, but unfortunately:
> 
> eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c8 
> eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c9 
> eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:ca 
> eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:cb 
> netconsole: eth0 doesn't support polling, aborting.
> 
> Yes, I have an e10k too. :)

Even when I mount a valid root over NFS, the kernel always says: 
Warning: unable to open an initial console.

It seems like we'd need to enable polling (NAPI?) for the sunHME in
order to use netconsole here, or fix the native console. Any suggestions
would be welcomed.

Here is the full log for 2.6.20-rc6, from OBP to dmesg, on a rather
small domain:

ultra5:spot% netcon -g
trying to connect...
connected.
Unlocked write permission is granted.

SUNW,Ultra-Enterprise-10000, using Network Console
OpenBoot 3.2.181, 2048 MB memory installed, Serial #10944558.
Ethernet address 0:0:be:a7:0:2e, Host ID: 80a7002e.



<#0> ok 
<#0> ok boot /sbus@41,0/SUNW,qfe@1,8c00000 -p root=/dev/nfs
nfsroot.15.36.3:/build/gdb
ip.15.36.9::10.15.36.254:255.255.255.0:spot1:eth0:both
netconsoleD44@10.15.36.9/eth0,@10.15.36.3/
Boot device: /sbus@41,0/SUNW,qfe@1,8c00000  File and args: -p
root=/dev/nfs nfsroot.15.36.3:/build/gdb
ip.15.36.9::10.15.36.254:255.255.255.0:spot1:eth0:both
netconsoleD44@10.15.36.9/eth0,@10.15.36.3/
24f800 
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.181 2003/08/15 11:02'
PROMLIB: Root node compatible: 
Linux version 2.6.20-rc6 (root@odyssey) (gcc version 4.1.1 20061011 (Red
Hat 4.1.1-30)) #3 SMP Fri Jan 26 16:34:09 EST 2007
ARCH: SUN4U
Ethernet address: 00:00:be:a7:00:2e
Remapping the kernel... done.
PROM: Built device tree with 49221 bytes of memory.
Booting Linux...
Built 1 zonelists.  Total pages: 258352
Kernel command line: -p root=/dev/nfs nfsroot.15.36.3:/build/gdb
ip.15.36.9::10.15.36.254:255.255.255.0:spot1:eth0:both
netconsoleD44@10.15.36.9/eth0,@10.15.36.3/
netconsole: local port 4444
netconsole: local IP 10.15.36.9
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 10.15.36.3
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 2062424k available (1760k kernel code, 408k data, 152k init)
[fffff80000000000,000000007fcea000]
Calibrating delay using timer specific routine.. 799.75 BogoMIPS
(lpj99501)
Mount-cache hash table entries: 512
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(8388608):line_sz(64)]
Using max_cache_size of 8MB
Calibrating delay using timer specific routine.. 799.30 BogoMIPS
(lpj98606)
CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(8388608):line_sz(64)]
CPU 1: synchronized TICK with master CPU (last diff -26 cycles,maxerr
973 cycles)
Calibrating delay using timer specific routine.. 799.30 BogoMIPS
(lpj98611)
CPU[2]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(8388608):line_sz(64)]
CPU 2: synchronized TICK with master CPU (last diff -22 cycles,maxerr
993 cycles)
Calibrating delay using timer specific routine.. 799.30 BogoMIPS
(lpj98612)
CPU[3]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(8388608):line_sz(64)]
CPU 3: synchronized TICK with master CPU (last diff -30 cycles,maxerr
991 cycles)
Brought up 4 CPUs
Total of 4 processors activated (3197.66 BogoMIPS).
migration_cost 0751
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 40, at 0000010800000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 41, at 0000010a00000000
sbus1: Clock 25.0 MHz
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Mini RTC Driver
io scheduler noop registered
io scheduler deadline registered (default)
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c8 
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c9 
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:ca 
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:cb 
netconsole: eth0 doesn't support polling, aborting.
qpti0: IRQ 7 SCSI ID 7 <6>scsi0 : PTI Qlogic,ISP SBUS SCSI irq 7 regs at
0000010900010000
(Firmware v1.31.32)(Firmware 1.21 95/05/18) [Fast Wide, using single
ended interface]
scsi 0:0:2:0: Direct-Access     IBM      DDRS34560SUN4.2G S98E PQ: 0
ANSI: 2
SCSI device sda: 8385121 512-byte hdwr sectors (4293 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 8385121 512-byte hdwr sectors (4293 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4 sda6 sda7 sda8
sd 0:0:2:0: Attached scsi disk sda
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr.15.36.9, mask%5.255.255.0, gw.15.36.254,
     host=spot1, domain=, nis-domain=(none),
     bootserver%5.255.255.255, rootserver.15.36.3, rootpathLooking up port of RPC 100003/2 on 10.15.36.3
Looking up port of RPC 100005/1 on 10.15.36.3
VFS: Mounted root (nfs filesystem) readonly.
Warning: unable to open an initial console.
eth0: Link is up using internal transceiver at 10Mb/s, Half Duplex.
eth0: Happy Meal out of receive descriptors, packet dropped.


