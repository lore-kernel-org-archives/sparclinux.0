From: Robert Reif <reif@earthlink.net>
Date: Wed, 23 Jul 2008 21:30:38 +0000
Subject: e4500 esp scsi problems
Message-Id: <4887A2FE.7050308@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080703070509040407050709"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080703070509040407050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to install linux on an e4500 system and am having
problems with the esp scsi driver.  I installed debian lenny
and it's working fine except for an oops at shutdown in
the esp scsi driver.  This issue is fixed in 2.6.26 so I built
a new kernel from the latest git and the oops went away
but I'm now getting a lot of scsi error messages and hang
at shutdown.  The system works fine with a qlogic isp
sbus card but I would like to get it working with the
built in scsi interface.

I don't know if this is a hardware or software problem so
I could use some advice on how to proceed.

--------------080703070509040407050709
Content-Type: text/plain;
 name="shutdown.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shutdown.txt"

INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
Stopping GNOME Display Manager: gdm.
Stopping anac(h)ronistic cron: anacron.
Stopping deferred execution scheduler: atd.
Stopping network connection manager: NetworkManager.
Stopping network events dispatcher: NetworkManagerDispatcher.
Stopping Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Stopping DHCP D-Bus daemon: dhcdbd.
Stopping Hardware abstraction layer: hald.
Stopping MTA: exim4_listener.
Stopping kerneloops:
Stopping NFS common utilities: statd.
Stopping internet superserver: inetd.
Stopping rsync daemon: rsync.
Stopping file alteration monitor: FAM.
Stopping NTP server: ntpd.
Saving the system clock.
Stopping System Tools Backends: system-tools-backends.
Shutting down ALSA...done (none loaded).
Stopping enhanced syslogd: rsyslogd.
Asking all remaining processes to terminate...done.
All processes ended within 1 seconds....done.
Stopping portmap daemon....
Deconfiguring network interfaces...[  870.281080] esp: esp0: Aborting command [fffff801feac40a0:28]
[  870.356322] esp: esp0: Current command [fffff801feac40a0:28]
[  870.356337] esp: esp0: Active command [fffff801feac40a0:28]
[  870.356348] esp: esp0: Dumping command log
[  870.356362] esp: esp0: ent[22] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356382] esp: esp0: ent[23] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356402] esp: esp0: ent[24] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356422] esp: esp0: ent[25] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  870.356441] esp: esp0: ent[26] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  870.356461] esp: esp0: ent[27] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[  870.356480] esp: esp0: ent[28] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  870.356500] esp: esp0: ent[29] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  870.356519] esp: esp0: ent[30] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
[  870.356539] esp: esp0: ent[31] EVENT val[06] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0d]
[  870.356559] esp: esp0: ent[0] CMD val[10] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[06]
[  870.356578] esp: esp0: ent[1] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[  870.356598] esp: esp0: ent[2] EVENT val[0c] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[  870.356618] esp: esp0: ent[3] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[  870.356637] esp: esp0: ent[4] CMD val[12] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[  870.356657] esp: esp0: ent[5] CMD val[44] sreg[90] seqreg[04] sreg2[20] ireg[20] ss[00] event[0c]
[  870.356676] esp: esp0: ent[6] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[0c] ss[00] event[0c]
[  870.356696] esp: esp0: ent[7] CMD val[90] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[  870.356715] esp: esp0: ent[8] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[  870.356735] esp: esp0: ent[9] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0c]
[  870.356755] esp: esp0: ent[10] EVENT val[03] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356774] esp: esp0: ent[11] CMD val[90] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[03]
[  870.356794] esp: esp0: ent[12] EVENT val[05] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[03]
[  870.356814] esp: esp0: ent[13] EVENT val[0d] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[  870.356833] esp: esp0: ent[14] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356853] esp: esp0: ent[15] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356873] esp: esp0: ent[16] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  870.356892] esp: esp0: ent[17] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  870.356912] esp: esp0: ent[18] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  870.356931] esp: esp0: ent[19] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[  870.356951] esp: esp0: ent[20] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  870.356970] esp: esp0: ent[21] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.369501] esp: esp0: Aborting command [fffff801feac40a0:00]
[  896.443307] esp: esp0: Current command [fffff801feac40a0:00]
[  896.443321] esp: esp0: Active command [fffff801feac40a0:00]
[  896.443331] esp: esp0: Dumping command log
[  896.443342] esp: esp0: ent[30] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
[  896.443365] esp: esp0: ent[31] EVENT val[06] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[0d]
[  896.443386] esp: esp0: ent[0] CMD val[10] sreg[97] seqreg[04] sreg2[00] ireg[18] ss[00] event[06]
[  896.443408] esp: esp0: ent[1] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[  896.443429] esp: esp0: ent[2] EVENT val[0c] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[06]
[  896.443452] esp: esp0: ent[3] CMD val[01] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[  896.443474] esp: esp0: ent[4] CMD val[12] sreg[97] seqreg[04] sreg2[20] ireg[08] ss[00] event[0c]
[  896.443496] esp: esp0: ent[5] CMD val[44] sreg[90] seqreg[04] sreg2[20] ireg[20] ss[00] event[0c]
[  896.443518] esp: esp0: ent[6] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[0c] ss[00] event[0c]
[  896.443539] esp: esp0: ent[7] CMD val[90] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[  896.443560] esp: esp0: ent[8] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[10] ss[00] event[0c]
[  896.443582] esp: esp0: ent[9] EVENT val[0d] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0c]
[  896.443605] esp: esp0: ent[10] EVENT val[03] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  896.443628] esp: esp0: ent[11] CMD val[90] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[03]
[  896.443651] esp: esp0: ent[12] EVENT val[05] sreg[91] seqreg[04] sreg2[00] ireg[10] ss[00] event[03]
[  896.443673] esp: esp0: ent[13] EVENT val[0d] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[05]
[  896.443695] esp: esp0: ent[14] CMD val[01] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  896.443717] esp: esp0: ent[15] CMD val[11] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  896.443739] esp: esp0: ent[16] EVENT val[0b] sreg[93] seqreg[04] sreg2[00] ireg[10] ss[00] event[0d]
[  896.443762] esp: esp0: ent[17] CMD val[12] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  896.443783] esp: esp0: ent[18] EVENT val[0c] sreg[97] seqreg[04] sreg2[00] ireg[08] ss[00] event[0b]
[  896.443805] esp: esp0: ent[19] CMD val[44] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[00] event[0c]
[  896.443827] esp: esp0: ent[20] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443849] esp: esp0: ent[21] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443870] esp: esp0: ent[22] CMD val[1a] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443892] esp: esp0: ent[23] CMD val[03] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443912] esp: esp0: ent[24] CMD val[02] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443934] esp: esp0: ent[25] CMD val[80] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443956] esp: esp0: ent[26] CMD val[80] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.443978] esp: esp0: ent[27] CMD val[03] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.444000] esp: esp0: ent[28] CMD val[01] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  896.444022] esp: esp0: ent[29] CMD val[c6] sreg[90] seqreg[04] sreg2[00] ireg[20] ss[01] event[0c]
[  912.452266] sd 0:0:10:0: Device offlined - not ready after error recovery
[  912.537197] sd 0:0:10:0: rejecting I/O to offline device
[  912.604522] sd 0:0:10:0: rejecting I/O to offline device
run-p[  912.671834] Buffer I/O error on device sda2, logical block 2099200
arts:[  912.671848] lost page write due to I/O error on sda2
 fail[  912.671875] sd 0:0:10:0: rejecting I/O to offline device
ed to[  912.671893] Buffer I/O error on device sda2, logical block 2132529
 open[  912.671906] lost page write due to I/O error on sda2
 dire[  912.671926] sd 0:0:10:0: rejecting I/O to offline device
ctory[  912.671944] Buffer I/O error on device sda2, logical block 2142332
 /etc[  912.671957] lost page write due to I/O error on sda2
/netw[  912.671977] sd 0:0:10:0: rejecting I/O to offline device
ork/i[  912.671995] Buffer I/O error on device sda2, logical block 2160641
f-pos[  912.672008] lost page write due to I/O error on sda2
t-dow[  912.672027] sd 0:0:10:0: rejecting I/O to offline device
n.d: [  912.672045] Buffer I/O error on device sda2, logical block 2173832
Input[  912.672058] lost page write due to I/O error on sda2
/outp[  912.672078] sd 0:0:10:0: rejecting I/O to offline device
ut er[  912.672096] Buffer I/O error on device sda2, logical block 2175041
ror
[  912.672108] lost page write due to I/O error on sda2
done.[  912.672128] sd 0:0:10:0: rejecting I/O to offline device
                                                                                                                                                             
[  912.672146] Buffer I/O error on device sda2, logical block 2384125
[  912.672158] lost page write due to I/O error on sda2
[  912.672178] Buffer I/O error on device sda2, logical block 2384126
[  912.672191] lost page write due to I/O error on sda2
[  912.672211] sd 0:0:10:0: rejecting I/O to offline device
[  912.672228] Buffer I/O error on device sda2, logical block 3485804
[  912.672241] lost page write due to I/O error on sda2
[  912.673005] sd 0:0:10:0: rejecting I/O to offline device
[  912.673038] Buffer I/O error on device sda2, logical block 3485804
[  912.684400] Aborting journal on device sda2.
[  912.684465] sd 0:0:10:0: rejecting I/O to offline device
[  912.684923] __journal_remove_journal_head: freeing b_frozen_data
[  912.684942] __journal_remove_journal_head: freeing b_frozen_data
[  912.684960] __journal_remove_journal_head: freeing b_frozen_data
[  912.684978] __journal_remove_journal_head: freeing b_frozen_data
[  912.745391] ext3_abort called.
[  912.745403] EXT3-fs error (device sda2): ext3_journal_start_sb: Detected aborted journal
[  912.745419] Remounting filesystem read-only
Cleaning up i[  915.287330] sd 0:0:10:0: rejecting I/O to offline device
fupdow[  915.356771] sd 0:0:10:0: rejecting I/O to offline device
n...rm[  915.426650] sd 0:0:10:0: rejecting I/O to offline device
: cannot rem[  915.502553] sd 0:0:10:0: rejecting I/O to offline device
ove `[  915.572250] sd 0:0:10:0: rejecting I/O to offline device
/etc/[  915.640940] sd 0:0:10:0: rejecting I/O to offline device
network/run[  915.715938] sd 0:0:10:0: rejecting I/O to offline device
/ifst[  915.784483] sd 0:0:10:0: rejecting I/O to offline device
ate':[  915.853292] sd 0:0:10:0: rejecting I/O to offline device
 Read-only file system
/etc/init.d/rc: line 220: /etc/rc0.d/S40umountfs: Input/output error
/etc/init.d/rc: line 220: /etc/rc0.d/S60umountroot: Input/output error
/etc/init.d/rc: line 220: /etc/rc0.d/S90halt: Input/output error
INIT: no more processes left in this runlevel
[  944.374038] sd 0:0:10:0: rejecting I/O to offline device
[  944.441132] __ratelimit: 1 messages suppressed
[  944.497786] Buffer I/O error on device sda2, logical block 0
[  944.569176] lost page write due to I/O error on sda2
[  944.632283] Buffer I/O error on device sda2, logical block 1
[  944.703832] lost page write due to I/O error on sda2
[  944.767166] sd 0:0:10:0: rejecting I/O to offline device
[  944.834780] Buffer I/O error on device sda2, logical block 491522
[  944.911692] lost page write due to I/O error on sda2
[  944.974982] Buffer I/O error on device sda2, logical block 491523
[  945.051992] lost page write due to I/O error on sda2
[  945.115460] Buffer I/O error on device sda2, logical block 491524
[  945.192517] lost page write due to I/O error on sda2
[  945.256006] sd 0:0:10:0: rejecting I/O to offline device
[  945.323759] Buffer I/O error on device sda2, logical block 491526
[  945.400801] lost page write due to I/O error on sda2
[  945.464290] sd 0:0:10:0: rejecting I/O to offline device
[  945.533649] sd 0:0:10:0: rejecting I/O to offline device
[  945.601210] sd 0:0:10:0: rejecting I/O to offline device
[  945.668728] sd 0:0:10:0: rejecting I/O to offline device
[  945.736122] sd 0:0:10:0: rejecting I/O to offline device
[  945.804152] sd 0:0:10:0: rejecting I/O to offline device
[  945.871378] sd 0:0:10:0: rejecting I/O to offline device
[  945.871406] sd 0:0:10:0: rejecting I/O to offline device
[  945.871440] sd 0:0:10:0: rejecting I/O to offline device
[  945.932921] sd 0:0:10:0: rejecting I/O to offline device
[  945.932950] sd 0:0:10:0: rejecting I/O to offline device
[  945.932975] sd 0:0:10:0: rejecting I/O to offline device
[  945.932999] sd 0:0:10:0: rejecting I/O to offline device
[  945.933114] sd 0:0:10:0: rejecting I/O to offline device
[  945.933143] sd 0:0:10:0: rejecting I/O to offline device
[  945.933168] sd 0:0:10:0: rejecting I/O to offline device
[  945.933192] sd 0:0:10:0: rejecting I/O to offline device
[  945.933343] sd 0:0:10:0: rejecting I/O to offline device
[  945.933375] sd 0:0:10:0: rejecting I/O to offline device
[  945.933401] sd 0:0:10:0: rejecting I/O to offline device
[  945.933425] sd 0:0:10:0: rejecting I/O to offline device
[  945.933573] sd 0:0:10:0: rejecting I/O to offline device
[  945.933603] sd 0:0:10:0: rejecting I/O to offline device
[  945.933633] sd 0:0:10:0: rejecting I/O to offline device
[  945.933664] sd 0:0:10:0: rejecting I/O to offline device
[  945.933804] sd 0:0:10:0: rejecting I/O to offline device
[  945.933836] sd 0:0:10:0: rejecting I/O to offline device
[  945.933864] sd 0:0:10:0: rejecting I/O to offline device
[  945.933894] sd 0:0:10:0: rejecting I/O to offline device
[  945.934042] sd 0:0:10:0: rejecting I/O to offline device
[  945.934072] sd 0:0:10:0: rejecting I/O to offline device
[  945.934208] sd 0:0:10:0: rejecting I/O to offline device
[  945.934236] sd 0:0:10:0: rejecting I/O to offline device
[  945.934260] sd 0:0:10:0: rejecting I/O to offline device
[  945.934284] sd 0:0:10:0: rejecting I/O to offline device
[  945.938002] sd 0:0:10:0: rejecting I/O to offline device
[  945.938030] sd 0:0:10:0: rejecting I/O to offline device
[  945.938054] sd 0:0:10:0: rejecting I/O to offline device
                                                                                                                                                             



--------------080703070509040407050709--
