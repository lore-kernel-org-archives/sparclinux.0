From: Meelis Roos <mroos@linux.ee>
Date: Wed, 03 Jul 2013 11:05:40 +0000
Subject: Re: sparc ESP SCSI error handling BUG+hang
Message-Id: <alpine.SOC.1.00.1307031353170.24784@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1304211357540.2145@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1304211357540.2145@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

> I revived my Sun E3000 after its main disk died, reinstalled Debian and=20
> after long apuse I am testing linux kernels again on it. In general it=20
> works fine but I left the bad disk connected and sometimes it causes ESP =

> SCSI BUG in esp_free_lun_tag. Sometimes it just works.

I instrumented the esp code in 3.10 with copious printks and got a better
picture.

Target 0 is sda and it works, target 1 is sdb (usually does not spin up),
target 2 is sdc, probably broken. I specifically left sdb and sdc in the
machine to debug esp.

I have filtered out target 0 devug printk-s and added/left 1 and 2 there.

ESP alloc 1 means esp_alloc_lun_tag for target 1
ESP free 2 means esp_free_lun_tag for target 2

The pattern is that usually target 2 commands are tagged and are allocated =
and
freed correctly. But on some condition, find_and_prep_issuable_command deci=
des
to clear tag in command entry because of AUTOSENSE flag, and after that,
esp_free_lun_tag sees the entry as untagged, instead of tagged, but its
non_tagged_cmd field is NULL and does not equal to the specified command en=
try,
which causes BUG and hang because it happens in interrupt context.

I got stuck in understanding autosense - why are there 2 invocations of
esp0: Doing auto-sense for tgt[2] lun[0]
line?

[  216.087864] sd 0:0:1:0: [sdb] Write Protect is off
[  216.087892] sd 0:0:1:0: [sdb] Mode Sense: 9f 00 10 08
[  216.087962] ESP alloc 1: tagged, lp=FFfff800fc780000, tag2,0
[  216.087968] ESP alloc 1: done
[  216.088002] ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 04 00 ]
[  216.122992] ESP free 1: tag 32,0
[  216.123193] ESP alloc 1: tagged, lp=FFfff800fc780000, tag2,0
[  216.123200] ESP alloc 1: done
[  216.123234] ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 20 00 ]
[  216.191894] ESP free 1: tag 32,0
[  216.192011] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  216.192805] ESP alloc 2: tagged, lp=FFfff800fc3d7000, tag2,0
[  216.192812] ESP alloc 2: done
[  216.192842] ESP: tgt[2] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
[  216.230179] esp0: Doing auto-sense for tgt[2] lun[0]
[  216.230367] ESP: find_and_prep_issuable_command (AUTOSENSE) zeroing tag =
in 2 (fffff800fb193bc0), lp=FFfff800fc3d7000
[  216.230376] esp0: Doing auto-sense for tgt[2] lun[0]
[  216.230812] ESP free 2: untagged, lp=FFfff800fc3d7000
[  216.230827] lp=FFfff800fc3d7000, lp->non_tagged_cmd=3D          (null), =
ent=FFfff800fb193bc0
[  216.230837] kernel BUG at drivers/scsi/esp_scsi.c:620!

(the line number is of course wrong, it's the second BUG inside esp_free_lu=
n_tag)

--=20
Meelis Roos (mroos@linux.ee)
