From: Raphael Assenat <raph@raphnet.net>
Date: Thu, 02 Feb 2006 17:50:08 +0000
Subject: System becomes slow after a few hours with 2.6.16-rc1
Message-Id: <20060202175008.GA14374@aramis.lan.raphnet.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have upgraded from kernel 2.6.12 to 2.6.16-rc1 from git. Everything
seem to work fine but after a few hours (6-7 hours), 
the machine becomes _very_ slow. I tried 3 times and it always does this.

Here is why I say the machine is slow:
- mouse mouvement is jerky
- some key events are lost
- redrawing the screen when switching virtual desktop in fvwm is slow
- shutdown takes several minutes.
- the ouput from simple commands like 'ls' displays slowly, one line at
  the time, as if it were going through a 2400 baud serial link ;)

The machine is used as workstation. It has a keyboard, mouse and
display. You'll find at the end various pieces of information taken 
on the machine while the problem was occuring. Let me know if there is
any other things I should try next time this occurs.

Regards,
Raphael Assenat

# cat /proc/cpuinfo
qq(Thu,Feb02)qj
cpu             : TI UltraSparc IIi (Sabre)
fpu             : UltraSparc IIi integrated FPU
promlib         : Version 3 Revision 25
prom            : 3.25.3
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
Cpu0Bogo        : 876.54
Cpu0ClkTck      : 000000001a39de00
MMU Type        : Spitfire

# top
top - 06:54:37 up 10:44,  9 users,  load average: 4.02, 4.40, 4.58
Tasks:  70 total,   3 running,  67 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.7% us, 51.2% sy,  0.0% ni, 37.9% id,  0.0% wa,  0.9% hi,  9.3% si 
Mem:    513176k total,   505608k used,     7568k free,   115632k buffers 
Swap:   499952k total,        0k used,   499952k free,   131096k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND        
 8555 root      15   0 51568  22m 4256 S 20.6  4.5  54:52.91 X        
14734 raph      17   0  2752 1384 1104 R 17.1  0.3   0:21.70 top        
14891 raph      18   0   184   16    0 R  2.9  0.0   0:00.14 free        
 8587 raph      15   0  6736 3144 2504 S  2.4  0.6   0:06.04 fvwm        
14890 raph      18   0   192   16    0 R  2.2  0.0   0:00.11 cat        
25013 raph      16   0  7424 3400 2736 S  1.0  0.7   1:30.73 xterm        
 8663 raph      16   0  2248 1216  920 S  0.8  0.2   3:52.20 watch        
25226 raph      16   0  7424 3400 2736 S  0.8  0.7   0:20.31 xterm        
 8590 raph      16   0  6016 2256 1808 S  0.6  0.4   0:03.97 FvwmPager        
 8637 raph      16   0  2248 1192  920 S  0.6  0.2   2:50.83 watch        
 8603 raph      16   0  7424 3408 2744 S  0.4  0.7   1:39.05 xterm        
 8647 raph      16   0  7408 3784 2736 S  0.4  0.7   0:56.18 xterm        
 9368 raph      16   0  7424 3808 2752 S  0.4  0.7   0:25.97 xterm

# cat /proc/interrupts             #           Thu Feb  2 06:55:22 2006

  0:    3872823  timer:dead
  4:      65384  su(mouse):7ea, ide0:7e0
  5:    1133917  eth0:7e1
  9:       2102  su(kbd):7e9
 10:        252  ohci_hcd:usb1:7d0, ohci_hcd:usb2:7d1, ehci_hcd:usb3:7d2
 13:          0  cs4231(capture):7e3
 14:          0  cs4231(play):7e4
 15:          0  SABRE UE:7ee, SABRE CE:7ef, SABRE PCIERR:7f0, power:7e5

# cat /proc/interrupts             #           Thu Feb  2 06:55:34 2006

  0:    3873735  timer:dead
  4:      65999  su(mouse):7ea, ide0:7e0
  5:    1133928  eth0:7e1
  9:       2105  su(kbd):7e9
 10:        252  ohci_hcd:usb1:7d0, ohci_hcd:usb2:7d1, ehci_hcd:usb3:7d2
 13:          0  cs4231(capture):7e3
 14:          0  cs4231(play):7e4
 15:          0  SABRE UE:7ee, SABRE CE:7ef, SABRE PCIERR:7f0, power:7e5

             total       used       free     shared    buffers     cached
Mem:        513176     505776       7400          0     115656     131096
-/+ buffers/cache:     259024     254152
Swap:       499952          0     499952


# cat /proc/vmstat
nr_dirty 3
nr_writeback 0
nr_unstable 0
nr_page_table_pages 174
nr_mapped 11714
nr_slab 0
pgpgin 193782
pgpgout 85525
pswpin 0
pswpout 0
pgalloc_high 0
pgalloc_normal 0
pgalloc_dma32 0
pgalloc_dma 9514608
pgfree 9515572
pgactivate 16634
pgdeactivate 1849
pgfault 22052616
pgmajfault 1108
pgrefill_high 0
pgrefill_normal 0
pgrefill_dma32 0
pgrefill_dma 5085
pgsteal_high 0
pgsteal_normal 0
pgrefill_dma32 0
pgrefill_dma 5085
pgsteal_high 0
pgsteal_normal 0
pgsteal_dma32 0
pgsteal_dma 3800
pgscan_kswapd_high 0
pgscan_kswapd_normal 0
pgscan_kswapd_dma32 0
pgscan_kswapd_dma 6996
pgscan_direct_high 0
pgscan_direct_normal 0
pgscan_direct_dma32 0
pgscan_direct_dma 33
pginodesteal 0
slabs_scanned 117376
kswapd_steal 3768
kswapd_inodesteal 0
pageoutrun 105
allocstall 1
pgrotated 0
nr_bounce 0

# cat /proc/stat
cpu  133085 10646 1538580 2045401 16166 683 137309 0
cpu0 133085 10646 1538580 2045401 16166 683 137309 0
intr 5087481 3881720 0 0 0 69223 1133982 0 0 0 2302 252 2 0 0 0 0
ctxt 6256093
btime 1138842587
processes 79860
procs_running 1
procs_blocked 0

# ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:14 init [3]
    2 ?        SN     0:00 [ksoftirqd/0]
    3 ?        S      0:00 [watchdog/0]
    4 ?        S<     0:00 [events/0]
    5 ?        S<     0:00 [khelper]
    6 ?        S<     0:00 [kthread]
   22 ?        S<     0:00 [kblockd/0]
   21 ?        S      0:00 [powerd]
   25 ?        S<     0:00 [khubd]
   53 ?        S      0:00 [pdflush]
   54 ?        S      0:03 [pdflush]
   56 ?        S<     0:00 [aio/0]
   55 ?        S      0:07 [kswapd0]
   57 ?        S<     0:00 [xfslogd/0]
   58 ?        S<     0:00 [xfsdatad/0]
  642 ?        S<     0:00 [kseriod]
  677 ?        S      0:27 [kjournald]
  768 ?        S<s    0:01 udevd
 6584 ?        S<     0:00 [scsi_eh_1]
 6585 ?        S<     0:00 [usb-storage]
 7765 ?        Ss     0:04 /usr/sbin/syslog-ng
 8294 ?        Ss     0:00 /sbin/portmap
 8380 ?        S      0:05 /usr/sbin/snmpd -p /var/run/snmpd.pid
 8420 ?        Ss     0:00 /usr/sbin/sshd
8456 ?        Ss     0:06 /usr/sbin/cron
 8470 ?        Ss     0:00 login -- raph
 8471 tty2     Ss+    0:00 /sbin/agetty 38400 tty2 linux
 8472 tty3     Ss+    0:00 /sbin/agetty 38400 tty3 linux
 8473 tty4     Ss+    0:00 /sbin/agetty 38400 tty4 linux
 8474 tty5     Ss+    0:00 /sbin/agetty 38400 tty5 linux
 8475 tty6     Ss+    0:00 /sbin/agetty 38400 tty6 linux
 8496 tty1     Ss     0:03 -zsh
 8543 tty1     S+     0:00 /bin/sh /usr/X11R6/bin/startx
 8554 tty1     S+     0:00 xinit /home/raph/.xinitrc -- -br -deferglyphs 16
 8555 ?        S     55:50 X :0 -br -deferglyphs 16
 8587 tty1     S      0:13 fvwm
 8588 tty1     S      0:00 /usr/lib/fvwm/2.5.12/FvwmAnimate 7 4 none 0 8
 8590 tty1     S      0:09 /usr/lib/fvwm/2.5.12/FvwmPager 11 4 none 0 8
 8603 tty1     S      1:39 xterm -bdc
 8605 pts/0    Ss+    0:01 zsh
 8630 tty1     S      0:59 xterm -bdc
 8632 pts/1    Ss     0:00 zsh
 8637 pts/1    S+     2:52 watch -n 1 cat /proc/interrupts
 8647 tty1     S      0:57 xterm -bdc
 8649 pts/2    Ss     0:00 zsh
 8663 pts/2    S+     3:53 watch -n 1 free
 8681 tty1     S      0:00 /bin/bash /usr/libexec/mozilla-launcher
 8696 tty1     S      6:58 /usr/lib/mozilla-firefox/firefox-bin
 8702 tty1     S      0:11 /usr/lib/mozilla-firefox/firefox-bin
 8703 tty1     S      0:21 /usr/lib/mozilla-firefox/firefox-bin
 8708 tty1     S      0:00 /usr/libexec/gconfd-2 12
 8714 tty1     S      0:12 /usr/lib/mozilla-firefox/firefox-bin
 9355 tty1     S      9:10 xterm -bdc
 9359 pts/3    Ss     0:00 zsh
 9368 tty1     S      0:32 xterm -bdc
 9371 pts/4    Ss     0:00 zsh
 9454 pts/3    S+    42:44 ssh xxxxxxxxxxx
25013 tty1     S      1:32 xterm -bdc
25016 pts/5    Ss+    0:00 zsh
25226 tty1     S      0:22 xterm -bdc
25228 pts/6    Ss     0:00 zsh
25251 pts/6    S+     0:03 ssh xxxxxxxxxx
25437 tty1     S      0:18 xterm -bdc
25439 pts/7    Ss     0:00 zsh
25454 pts/7    S+     0:00 vim tel
14705 pts/4    S      0:00 su
14713 pts/4    S      0:01 bash
15086 pts/4    R+     0:02 ps ax
