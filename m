From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 09:47:57 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0808211235150.17855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Please add "initcall_debug" to the kernel boot command line,
> that will print the last module initialization function that
> gets called right before it hangs.

Yeah!

grepping for 'calling|initcall' results in

calling  scsi_complete_async_scans+0x8/0x100
initcall scsi_complete_async_scans+0x8/0x100 returned 0 after 0 msecs
calling  tcp_congestion_default+0x8/0x28
initcall tcp_congestion_default+0x8/0x28 returned 0 after 0 msecs
calling  tulip_init+0x8/0x6c [tulip]
initcall tulip_init+0x8/0x6c [tulip] returned 0 after 1726 msecs
calling  usb_init+0x8/0x140 [usbcore]
calling  i2c_init+0x8/0x80 [i2c_core]
initcall i2c_init+0x8/0x80 [i2c_core] returned 0 after 1413 msecs
calling  i2c_ali1535_init+0x8/0x38 [i2c_ali1535]
initcall i2c_ali1535_init+0x8/0x38 [i2c_ali1535] returned 0 after 811 msecs
calling  cdrom_init+0x8/0x84 [cdrom]
initcall cdrom_init+0x8/0x84 [cdrom] returned 0 after 0 msecs
initcall usb_init+0x8/0x140 [usbcore] returned 0 after 10341 msecs
calling  ohci_hcd_mod_init+0x8/0xb0 [ohci_hcd]
calling  init_sr+0x8/0x58 [sr_mod]
calling  i2c_ali15x3_init+0x8/0x38 [i2c_ali15x3]

Three outstanding initcalls (some awk & diff shows there are no more).

Retried the same image again with exact same command line, this time it 
hung after sata:

calling  suncore_init+0x8/0x1c
initcall suncore_init+0x8/0x1c returned 0 after 0 msecs
calling  sunsu_init+0x8/0x184
initcall sunsu_init+0x8/0x184 returned 0 after 70776 msecs
calling  sunsab_init+0x8/0x114
initcall sunsab_init+0x8/0x114 returned 0 after 252 msecs
calling  loop_init+0x8/0x224
initcall loop_init+0x8/0x224 returned 0 after 8090 msecs
calling  net_olddevs_init+0x8/0x104
initcall net_olddevs_init+0x8/0x104 returned 0 after 0 msecs
calling  init_netconsole+0x8/0x20c
initcall init_netconsole+0x8/0x20c returned 0 after 69 msecs
calling  init_sd+0x8/0xd8
initcall init_sd+0x8/0xd8 returned 0 after 574 msecs
calling  uli_init+0x8/0x34
initcall uli_init+0x8/0x34 returned 0 after 273 msecs
calling  ali_init+0x8/0x34

ali_init seems to be the only outstanding initcall here, verified by 
diff.

In previous try, it finished after 12s:
initcall ali_init+0x8/0x34 returned 0 after 12641 msecs

So first time it is one of ohci_hcd_mod_init, init_sr, i2c_ali15x3_init 
and second time ali_init. ali stuff seems most suspicios but there are 
still 2 different modules (seemingly causing different failures).

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
