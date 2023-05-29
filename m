Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A309C77B7A
	for <sparclinux@archiver.kernel.org>; Mon, 29 May 2023 08:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjE2ITA convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 29 May 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjE2IS7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 29 May 2023 04:18:59 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD1A7
        for <sparclinux@vger.kernel.org>; Mon, 29 May 2023 01:18:55 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          for sparclinux@vger.kernel.org with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q3Y5e-00417A-4u; Mon, 29 May 2023 10:18:54 +0200
Received: from dynamic-077-013-141-233.77.13.pool.telefonica.de ([77.13.141.233] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          for sparclinux@vger.kernel.org with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q3Y5d-003svx-U0; Mon, 29 May 2023 10:18:54 +0200
Message-ID: <f139785634eef66e5f932f4dba9f303214dd1a84.camel@physik.fu-berlin.de>
Subject: Backtrace with 6.3 when running crypto self-tests on T5220
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     sparclinux <sparclinux@vger.kernel.org>
Date:   Mon, 29 May 2023 10:18:53 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.13.141.233
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi!

I just booted one of Debian's T5220 into 6.3 and noticed the following backtrace
that occurs when the crypto self-tests are run (see below).

Anyone seen this, too?

Adrian

[   42.090034] ------------[ cut here ]------------
[   42.090046] WARNING: CPU: 40 PID: 836 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.090083] alg: self-tests for md5 using md5-n2 failed (rc=-90)
[   42.090092] Modules linked in: n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif
crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e usb_common
[   42.090507] CPU: 40 PID: 836 Comm: cryptomgr_test Not tainted 6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.090528] Call Trace:
[   42.090536] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.090569] [<000000000046e248>] __warn+0xc8/0x120
[   42.090589] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.090607] [<00000000008846a0>] alg_test+0x540/0x560
[   42.090628] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.090648] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.090674] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.090700] [<0000000000000000>] 0x0
[   42.090717] ---[ end trace 0000000000000000 ]---
[   42.090779] n2_crypto: md5 alg registered
[   42.121227] sha256_sparc64: sparc64 sha256 opcode not available.
[   42.167285] alg: ahash: hmac-md5-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.167471] alg: self-tests for hmac(md5) using hmac-md5-n2 failed (rc=-90)
[   42.167486] ------------[ cut here ]------------
[   42.167499] WARNING: CPU: 10 PID: 863 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.167546] alg: self-tests for hmac(md5) using hmac-md5-n2 failed (rc=-90)
[   42.167558] Modules linked in: n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif
crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e usb_common
[   42.168146] CPU: 10 PID: 863 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.168173] Call Trace:
[   42.168184] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.168225] [<000000000046e248>] __warn+0xc8/0x120
[   42.168251] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.168277] [<00000000008846a0>] alg_test+0x540/0x560
[   42.168306] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.168334] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.168368] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.168402] [<0000000000000000>] 0x0
[   42.168423] ---[ end trace 0000000000000000 ]---
[   42.168479] n2_crypto: hmac(md5) alg registered
[   42.185926] sha512_sparc64: sparc64 sha512 opcode not available.
[   42.187902] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   42.188232] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   42.188456] sd 1:0:1:0: Attached scsi generic sg2 type 0
[   42.188686] sd 1:0:2:0: Attached scsi generic sg3 type 0
[   42.188906] sd 1:0:3:0: Attached scsi generic sg4 type 0
[   42.222565] alg: ahash: sha1-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.222744] alg: self-tests for sha1 using sha1-n2 failed (rc=-90)
[   42.222758] ------------[ cut here ]------------
[   42.222770] WARNING: CPU: 3 PID: 877 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.222811] alg: self-tests for sha1 using sha1-n2 failed (rc=-90)
[   42.222821] Modules linked in: sg sha512_sparc64(-) n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4
crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft
crc64 crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.223307] CPU: 3 PID: 877 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.223331] Call Trace:
[   42.223342] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.223380] [<000000000046e248>] __warn+0xc8/0x120
[   42.223406] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.223430] [<00000000008846a0>] alg_test+0x540/0x560
[   42.223456] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.223481] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.223511] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.223541] [<0000000000000000>] 0x0
[   42.223560] ---[ end trace 0000000000000000 ]---
[   42.223689] n2_crypto: sha1 alg registered
[   42.273315] alg: ahash: hmac-sha1-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.273489] alg: self-tests for hmac(sha1) using hmac-sha1-n2 failed (rc=-90)
[   42.273502] ------------[ cut here ]------------
[   42.273513] WARNING: CPU: 52 PID: 910 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.273551] alg: self-tests for hmac(sha1) using hmac-sha1-n2 failed (rc=-90)
[   42.273561] Modules linked in: sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif
crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e usb_common
[   42.273970] CPU: 52 PID: 910 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.273991] Call Trace:
[   42.274000] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.274032] [<000000000046e248>] __warn+0xc8/0x120
[   42.274052] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.274070] [<00000000008846a0>] alg_test+0x540/0x560
[   42.274091] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.274111] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.274136] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.274162] [<0000000000000000>] 0x0
[   42.274178] ---[ end trace 0000000000000000 ]---
[   42.274237] n2_crypto: hmac(sha1) alg registered
[   42.312667] md5_sparc64: sparc64 md5 opcode not available.
[   42.325957] alg: ahash: sha256-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.326126] alg: self-tests for sha256 using sha256-n2 failed (rc=-90)
[   42.326139] ------------[ cut here ]------------
[   42.326150] WARNING: CPU: 47 PID: 914 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.326188] alg: self-tests for sha256 using sha256-n2 failed (rc=-90)
[   42.326197] Modules linked in: md5_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.326619] CPU: 47 PID: 914 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.326640] Call Trace:
[   42.326649] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.326682] [<000000000046e248>] __warn+0xc8/0x120
[   42.326702] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.326720] [<00000000008846a0>] alg_test+0x540/0x560
[   42.326741] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.326761] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.326786] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.326812] [<0000000000000000>] 0x0
[   42.326829] ---[ end trace 0000000000000000 ]---
[   42.326879] n2_crypto: sha256 alg registered
[   42.378560] alg: ahash: hmac-sha256-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.378736] alg: self-tests for hmac(sha256) using hmac-sha256-n2 failed (rc=-90)
[   42.378749] ------------[ cut here ]------------
[   42.378761] WARNING: CPU: 36 PID: 922 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.378798] alg: self-tests for hmac(sha256) using hmac-sha256-n2 failed (rc=-90)
[   42.378808] Modules linked in: sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif
crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e usb_common
[   42.379224] CPU: 36 PID: 922 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.379245] Call Trace:
[   42.379254] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.379286] [<000000000046e248>] __warn+0xc8/0x120
[   42.379307] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.379325] [<00000000008846a0>] alg_test+0x540/0x560
[   42.379345] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.379366] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.379391] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.379417] [<0000000000000000>] 0x0
[   42.379434] ---[ end trace 0000000000000000 ]---
[   42.379489] n2_crypto: hmac(sha256) alg registered
[   42.409162] aes_sparc64: sparc64 aes opcodes not available.
[   42.430724] alg: ahash: sha224-n2 export() failed with err -90 on test vector 0, cfg="import/export"
[   42.430894] alg: self-tests for sha224 using sha224-n2 failed (rc=-90)
[   42.430907] ------------[ cut here ]------------
[   42.430919] WARNING: CPU: 44 PID: 926 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.430957] alg: self-tests for sha224 using sha224-n2 failed (rc=-90)
[   42.430966] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.431434] CPU: 44 PID: 926 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.431459] Call Trace:
[   42.431468] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.431502] [<000000000046e248>] __warn+0xc8/0x120
[   42.431522] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.431540] [<00000000008846a0>] alg_test+0x540/0x560
[   42.431561] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.431581] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.431606] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.431632] [<0000000000000000>] 0x0
[   42.431650] ---[ end trace 0000000000000000 ]---
[   42.431697] n2_crypto: sha224 alg registered
[   42.432268] alg: skcipher: ecb-des-n2 encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[   42.432449] alg: self-tests for ecb(des) using ecb-des-n2 failed (rc=-22)
[   42.432461] ------------[ cut here ]------------
[   42.432472] WARNING: CPU: 26 PID: 933 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.432498] alg: self-tests for ecb(des) using ecb-des-n2 failed (rc=-22)
[   42.432507] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.432893] CPU: 26 PID: 933 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.432911] Call Trace:
[   42.432919] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.432943] [<000000000046e248>] __warn+0xc8/0x120
[   42.432962] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.432980] [<00000000008846a0>] alg_test+0x540/0x560
[   42.433001] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.433020] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.433041] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.433062] [<0000000000000000>] 0x0
[   42.433077] ---[ end trace 0000000000000000 ]---
[   42.433113] n2_crypto: ecb(des) alg registered
[   42.433512] alg: skcipher: cbc-des-n2 encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[   42.433812] alg: self-tests for cbc(des) using cbc-des-n2 failed (rc=-22)
[   42.433824] ------------[ cut here ]------------
[   42.433835] WARNING: CPU: 44 PID: 934 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.433862] alg: self-tests for cbc(des) using cbc-des-n2 failed (rc=-22)
[   42.433871] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.434249] CPU: 44 PID: 934 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.434267] Call Trace:
[   42.434275] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.434299] [<000000000046e248>] __warn+0xc8/0x120
[   42.434317] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.434335] [<00000000008846a0>] alg_test+0x540/0x560
[   42.434356] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.434375] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.434395] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.434417] [<0000000000000000>] 0x0
[   42.434431] ---[ end trace 0000000000000000 ]---
[   42.434468] n2_crypto: cbc(des) alg registered
[   42.434692] alg: No test for cfb(des) (cfb-des-n2)
[   42.434734] n2_crypto: cfb(des) alg registered
[   42.435102] alg: skcipher: ecb-3des-n2 encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[   42.435280] alg: self-tests for ecb(des3_ede) using ecb-3des-n2 failed (rc=-22)
[   42.435292] ------------[ cut here ]------------
[   42.435303] WARNING: CPU: 32 PID: 936 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.435329] alg: self-tests for ecb(des3_ede) using ecb-3des-n2 failed (rc=-22)
[   42.435338] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.435720] CPU: 32 PID: 936 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.435738] Call Trace:
[   42.435746] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.435770] [<000000000046e248>] __warn+0xc8/0x120
[   42.435788] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.435806] [<00000000008846a0>] alg_test+0x540/0x560
[   42.435826] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.435845] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.435866] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.435888] [<0000000000000000>] 0x0
[   42.435902] ---[ end trace 0000000000000000 ]---
[   42.435935] n2_crypto: ecb(des3_ede) alg registered
[   42.436400] alg: skcipher: cbc-3des-n2 encryption test failed (wrong result) on test vector 0, cfg="uneven misaligned splits, may sleep"
[   42.436584] alg: self-tests for cbc(des3_ede) using cbc-3des-n2 failed (rc=-22)
[   42.436596] ------------[ cut here ]------------
[   42.436607] WARNING: CPU: 23 PID: 937 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.436633] alg: self-tests for cbc(des3_ede) using cbc-3des-n2 failed (rc=-22)
[   42.436643] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.437023] CPU: 23 PID: 937 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.437041] Call Trace:
[   42.437049] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.437072] [<000000000046e248>] __warn+0xc8/0x120
[   42.437091] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.437108] [<00000000008846a0>] alg_test+0x540/0x560
[   42.437129] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.437148] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.437169] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.437191] [<0000000000000000>] 0x0
[   42.437205] ---[ end trace 0000000000000000 ]---
[   42.437242] n2_crypto: cbc(des3_ede) alg registered
[   42.437485] alg: No test for cfb(des3_ede) (cfb-3des-n2)
[   42.437527] n2_crypto: cfb(des3_ede) alg registered
[   42.437867] alg: skcipher: ecb-aes-n2 encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[   42.438044] alg: self-tests for ecb(aes) using ecb-aes-n2 failed (rc=-22)
[   42.438056] ------------[ cut here ]------------
[   42.438066] WARNING: CPU: 32 PID: 939 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.438093] alg: self-tests for ecb(aes) using ecb-aes-n2 failed (rc=-22)
[   42.438102] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.438479] CPU: 32 PID: 939 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.438497] Call Trace:
[   42.438505] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.438529] [<000000000046e248>] __warn+0xc8/0x120
[   42.438547] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.438565] [<00000000008846a0>] alg_test+0x540/0x560
[   42.438586] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.438605] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.438625] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.438647] [<0000000000000000>] 0x0
[   42.438661] ---[ end trace 0000000000000000 ]---
[   42.438694] n2_crypto: ecb(aes) alg registered
[   42.439076] alg: skcipher: cbc-aes-n2 encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[   42.439386] alg: self-tests for cbc(aes) using cbc-aes-n2 failed (rc=-22)
[   42.439399] ------------[ cut here ]------------
[   42.439409] WARNING: CPU: 27 PID: 940 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.439436] alg: self-tests for cbc(aes) using cbc-aes-n2 failed (rc=-22)
[   42.439445] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.439826] CPU: 27 PID: 940 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.439843] Call Trace:
[   42.439851] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.439875] [<000000000046e248>] __warn+0xc8/0x120
[   42.439893] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.439911] [<00000000008846a0>] alg_test+0x540/0x560
[   42.439931] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.439950] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.439971] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.439992] [<0000000000000000>] 0x0
[   42.440007] ---[ end trace 0000000000000000 ]---
[   42.440040] n2_crypto: cbc(aes) alg registered
[   42.440405] alg: skcipher: ctr-aes-n2 encryption test failed (wrong output IV) on test vector 0, cfg="in-place (one sglist)"
[   42.440588] 00000000: 1e 03 1d da 2f be 03 d1 79 21 70 a0 f3 00 9c ee
[   42.440616] alg: self-tests for ctr(aes) using ctr-aes-n2 failed (rc=-22)
[   42.440628] ------------[ cut here ]------------
[   42.440638] WARNING: CPU: 44 PID: 941 at crypto/testmgr.c:5930 alg_test+0x540/0x560
[   42.440664] alg: self-tests for ctr(aes) using ctr-aes-n2 failed (rc=-22)
[   42.440673] Modules linked in: aes_sparc64(-) sg n2_crypto(+) libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   42.441052] CPU: 44 PID: 941 Comm: cryptomgr_test Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   42.441070] Call Trace:
[   42.441078] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   42.441102] [<000000000046e248>] __warn+0xc8/0x120
[   42.441121] [<000000000046e348>] warn_slowpath_fmt+0xa8/0x100
[   42.441138] [<00000000008846a0>] alg_test+0x540/0x560
[   42.441159] [<0000000000880e18>] cryptomgr_test+0x18/0x60
[   42.441178] [<0000000000497e1c>] kthread+0xdc/0x120
[   42.441198] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   42.441220] [<0000000000000000>] 0x0
[   42.441233] ---[ end trace 0000000000000000 ]---
[   42.441266] n2_crypto: ctr(aes) alg registered
[   42.442401] n2_crypto: Found NCP at /virtual-devices@100/ncp@6
[   42.500395] des_sparc64: sparc64 des opcodes not available.
[   42.502877] camellia_sparc64: sparc64 camellia opcodes not available.
[   42.611819] crc32c_sparc64: sparc64 crc32c opcode not available.
[   42.611866] camellia_sparc64: sparc64 camellia opcodes not available.
[   42.646556] EXT4-fs (md0p1): warning: mounting fs with errors, running e2fsck is recommended
[   42.669622] EXT4-fs (md0p1): mounted filesystem a33f90f4-193b-4160-8050-8ba971f9fea6 with ordered data mode. Quota mode: none.
[   42.743132] crc32c_sparc64: sparc64 crc32c opcode not available.
[   43.487556] Adding 31254448k swap on /dev/sdb2.  Priority:-2 extents:1 across:31254448k FS
[   44.337260] Kernel unaligned access at TPC[845b9c] aa_dfa_unpack+0x3c/0x5c0
[   44.337316] Kernel unaligned access at TPC[845bb0] aa_dfa_unpack+0x50/0x5c0
[   44.337338] Kernel unaligned access at TPC[845c54] aa_dfa_unpack+0xf4/0x5c0
[   44.337363] Kernel unaligned access at TPC[845c54] aa_dfa_unpack+0xf4/0x5c0
[   44.337388] Kernel unaligned access at TPC[845c54] aa_dfa_unpack+0xf4/0x5c0
[   44.346334] audit: type=1400 audit(1685347976.960:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=998 comm="apparmor_parser"
[   44.346377] audit: type=1400 audit(1685347976.960:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=998 comm="apparmor_parser"
[   44.378306] audit: type=1400 audit(1685347976.992:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=997 comm="apparmor_parser"
[   44.383539] audit: type=1400 audit(1685347976.996:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1000 comm="apparmor_parser"
[   44.383578] audit: type=1400 audit(1685347976.996:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1000 comm="apparmor_parser"
[   44.383616] audit: type=1400 audit(1685347976.996:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1000 comm="apparmor_parser"
[   44.533968] audit: type=1400 audit(1685347977.148:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=999
comm="apparmor_parser"
[   44.534022] audit: type=1400 audit(1685347977.148:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=999 comm="apparmor_parser"
[   44.534059] audit: type=1400 audit(1685347977.148:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=999 comm="apparmor_parser"
[   44.534096] audit: type=1400 audit(1685347977.148:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=999 comm="apparmor_parser"
[   45.168467] ------------[ cut here ]------------
[   45.168496] WARNING: CPU: 31 PID: 1023 at kernel/irq/msi.c:196 msi_domain_free_descs+0xf4/0x120
[   45.168543] Modules linked in: binfmt_misc sg n2_crypto libdes n2_rng rng_core flash drm dm_mod drm_panel_orientation_quirks i2c_core loop fuse configfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 multipath linear raid0 md_mod sd_mod t10_pi crc64_rocksoft crc64
crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom uas usb_storage mptsas mptscsih mptbase ohci_pci scsi_transport_sas ohci_hcd ehci_pci niu scsi_mod ehci_hcd scsi_common usbcore e1000e
usb_common
[   45.168974] CPU: 31 PID: 1023 Comm: ip Tainted: G        W          6.3.0-0-sparc64-smp #1  Debian 6.3.4-1~exp1
[   45.168995] Call Trace:
[   45.169004] [<0000000000dd8f4c>] dump_stack+0x8/0x18
[   45.169036] [<000000000046e248>] __warn+0xc8/0x120
[   45.169055] [<000000000046e300>] warn_slowpath_fmt+0x60/0x100
[   45.169073] [<00000000004f8174>] msi_domain_free_descs+0xf4/0x120
[   45.169097] [<00000000004f8620>] msi_domain_free_msi_descs_range+0x20/0x40
[   45.169120] [<0000000000a131e0>] pci_msi_teardown_msi_irqs+0x40/0x60
[   45.169145] [<0000000000a12bec>] pci_free_msi_irqs+0xc/0x40
[   45.169164] [<0000000000a10e10>] pci_disable_msi+0x50/0x80
[   45.169182] [<000000001027d980>] e1000e_open+0x420/0x600 [e1000e]
[   45.169316] [<0000000000b8634c>] __dev_open+0xec/0x1c0
[   45.169336] [<0000000000b86878>] __dev_change_flags+0x1b8/0x260
[   45.169354] [<0000000000b8693c>] dev_change_flags+0x1c/0x80
[   45.169371] [<0000000000b98124>] do_setlink+0x304/0x1240
[   45.169389] [<0000000000b9e668>] __rtnl_newlink+0x548/0x880
[   45.169406] [<0000000000b9e9d4>] rtnl_newlink+0x34/0x60
[   45.169423] [<0000000000b96a24>] rtnetlink_rcv_msg+0x244/0x340
[   45.169455] ---[ end trace 0000000000000000 ]---

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
