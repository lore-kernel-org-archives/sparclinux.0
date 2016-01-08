From: mroos@linux.ee
Date: Fri, 08 Jan 2016 20:18:38 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <alpine.LRH.2.20.1601082132530.19024@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> >> > So far I have made sure that 4.2.0 works fine on V240 overnight with the 
> >> > following command to find any other errors too.
> >> > while true; do make clean; make -j2 || break; done

For now it seems 4.3.0-00063-gea2d67b and 4.3.0-08824-g7c623ca also 
survive for many hours. That is strange - I think I saw it earlier on 
v240 where I am currently testing (I have seen it multiple times on 
v240, only once or twice on v440).

Now I have also ran 4.4-rc8 on v440 for some hours and it seem to 
survive.

So I do not know how to reproduce the reboot at will :(

> >> let me restart a loop with your .config on my v440 and let this run
> >> overnight, to see if I can reproduce your case.
> > 
> > Hmm. I've rebooted my v440 with a kernel built with your .config,
> > I've been able to do the above make loop for several hours now. 
> > 
> > perhaps it is some service/module that you have enabled/loaded
> > that I dont? Would you like to compare output of lsmod and/or 
> > chkconfig and/or service--status-all? (let me know which one).

lsmod on v440:

ipv6                  371138  22
loop                   18495  0
sr_mod                 15039  0
cdrom                  30798  1 sr_mod
ohci_pci                3362  0
ohci_hcd               32471  1 ohci_pci
usbcore               191889  2 ohci_hcd,ohci_pci
usb_common              3832  1 usbcore
pata_ali                9305  0
libata                195005  1 pata_ali
sg                     19827  0
cassini                46893  0
flash                   3435  0

lsmod on v240:

ipv6                  496922  26
loop                   19367  0
tg3                   167037  0
skge                   40515  0
hwmon                   3838  1 tg3
sg                     20793  0
i2c_ali15x3             6252  0
i2c_ali1535             6046  0
i2c_core               28484  2 i2c_ali1535,i2c_ali15x3
ptp                    12769  1 tg3
pps_core                8737  1 ptp
flash                   3875  0

skge is for Ethernet controller: SysKonnect SK-9872 Gigabit 
Ethernet Server Adapter (SK-NET GE-ZX dual link) (rev 12) that is in the 
v240 as an additional card with OF ROM.


> > Other thing is, there is nothing in the console/logs to 
> > give a hint why it rebooted?

Nothing in ALOM console log history or in syslog.

> It could also be influenced by either the amount of memory he has
> installed, or what userland he is using.

v240 has 6G RAM, v440 has 8G.

Userland is Debian unstable, as it was as of July 25, 2015. gcc 4.9.3-2, 
binutils 2.25-10.

My usage pattern on all the machines was powering up the machine, doing
git pull && make -j4 && echo OK
where -j number corresponds to number of CPUs in the system. Maybe git 
pull created some memory pressure before?

ps shows I have running
init udevd dhclient uuidd rsyslogd atd cron irqbalance sshd exim4 ntpd 
getty + sshd,bash for my login session.

v440 also has /usr/bin/daemon /etc/init.d/mpt-statusd check_mpt

init is sysvinit on both machines.

irqbalance and ntpd are the only slightly suspicious ones for my eye, or 
i2c modules but these are only on v240.

mroos@v440:~$ cat /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       
   0:       7561       3617       5495       4128      none  timer
   1:          0          0          0          0     sun4u-IVEC      TOMATILLO_PCIERR
   2:          0          0          0          0     sun4u-IVEC      TOMATILLO_UE
   3:          0          0          0          0     sun4u-IVEC      TOMATILLO_CE
   4:          0          0          0          0     sun4u-IVEC      TOMATILLO_SERR
   6:          0          0        453          0     sun4u-IVEC      eth0
   8:          0          0          0          0     sun4u-IVEC      TOMATILLO_PCIERR
  13:          0          0          0          0     sun4u-IVEC      TOMATILLO_PCIERR
  14:          0          0          0          0     sun4u-IVEC      TOMATILLO_UE
  15:          0          0          0          0     sun4u-IVEC      TOMATILLO_CE
  16:          0          0          0          0     sun4u-IVEC      TOMATILLO_SERR
  19:          0          0          0          0     sun4u-IVEC      power
  20:        230          0          0          0     sun4u-IVEC      su(serial)
  21:          0          0          0          0     sun4u-IVEC      ohci_hcd:usb1
  22:          0          0          0          0     sun4u-IVEC      ohci_hcd:usb2
  23:          0        172          0        199     sun4u-IVEC      pata_ali
  24:          0          0          0          0     sun4u-IVEC      TOMATILLO_PCIERR
  31:          0          0          0       3311     sun4u-IVEC      ioc0
  32:         49          0          0          0     sun4u-IVEC      ioc1
 NMI:          0          0          0          0     Non-maskable interrupts


mroos@v240:~$ cat /proc/interrupts 
            CPU0       CPU1       
   0:   10073372   10074564      none  timer
   1:          0          0     sun4u-IVEC      TOMATILLO_PCIERR
   2:          0          0     sun4u-IVEC      TOMATILLO_UE
   3:          0          0     sun4u-IVEC      TOMATILLO_CE
   4:          0          0     sun4u-IVEC      TOMATILLO_SERR
   6:      44675      52105     sun4u-IVEC      eth0
   8:          0          0     sun4u-IVEC      TOMATILLO_PCIERR
  14:          0          0     sun4u-IVEC      power
  15:          0        266     sun4u-IVEC      su(serial)
  20:          0          0     sun4u-IVEC      TOMATILLO_PCIERR
  21:          0          0     sun4u-IVEC      TOMATILLO_UE
  22:          0          0     sun4u-IVEC      TOMATILLO_CE
  23:          0          0     sun4u-IVEC      TOMATILLO_SERR
  25:      46126      73792     sun4u-IVEC      sym53c8xx
  26:         30          0     sun4u-IVEC      sym53c8xx
  27:          0          0     sun4u-IVEC      TOMATILLO_PCIERR
NMI:      42625      42625      Non-maskable interrupts

-- 
Meelis Roos (mroos@linux.ee)
