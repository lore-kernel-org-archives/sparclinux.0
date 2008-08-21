From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 08:16:58 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0808211111180.17855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I instrumented ohci_hub_status_data and usb_hcd_poll_rh_status and on 
> one boot it started looping between these two - but I forgot to turn on 
> serial console logging. With logging on, I have not succeeded in 
> reproducing the looping, its just hangs (and has done so 2 times).

Hah, remebered - I now used the debug option on kernel command line ang 
a huge trace (probably shouldn't have turned on kobject debugging). 
Anyway, there's some info in it - usb_hcd_poll_rh_status is entered but 
it never calls hub_status_data().

kobject: 'usbcore' (000000001003fe10): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006c8237e8): kobject_add_internal: parent: 'usbcore', set: '<NULL>'
kobject: 'usbcore' (000000001003fe10): kobject_uevent_env
kobject: 'usbcore' (000000001003fe10): fill_kobj_path: path = '/module/usbcore'
kobject: 'notes' (fffff8006c822770): kobject_add_internal: parent: 'usbcore', set: '<NULL>'
kobject: 'usb' (fffff8006ca164d8): kobject_add_internal: parent: 'bus', set: 'bus'
kobject: 'usb' (fffff8006ca164d8): kobject_uevent_env
kobject: 'usb' (fffff8006ca164d8): fill_kobj_path: path = '/bus/usb'
kobject: 'devices' (fffff8006e153908): kobject_add_internal: parent: 'usb', set: '<NULL>'
kobject: 'devices' (fffff8006e153908): kobject_uevent_env
kobject: 'devices' (fffff8006e153908): kobject_uevent_env: filter function caused the event to drop!
kobject: 'drivers' (fffff8006e153a10): kobject_add_internal: parent: 'usb', set: '<NULL>'
kobject: 'drivers' (fffff8006e153a10): kobject_uevent_env
kobject: 'drivers' (fffff8006e153a10): kobject_uevent_env: filter function caused the event to drop!
kobject: 'usb_host' (fffff8006ca17288): kobject_add_internal: parent: 'class', set: 'class'
kobject: 'usb_host' (fffff8006ca17288): kobject_uevent_env
kobject: 'usb_host' (fffff8006ca17288): fill_kobj_path: path = '/class/usb_host'
kobject: 'usbfs' (fffff8006ca176d0): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'drivers' (fffff8006c822f68): kobject_add_internal: parent: 'usbcore', set: '<NULL>'
kobject: 'usbfs' (fffff8006ca176d0): kobject_uevent_env
kobject: 'usbfs' (fffff8006ca176d0): fill_kobj_path: path = '/bus/usb/drivers/usbfs'
usbcore: registered new interface driver usbfs
kobject: 'usb_device' (fffff8006ca17ba8): kobject_add_internal: parent: 'class', set: 'class'
kobject: 'usb_device' (fffff8006ca17ba8): kobject_uevent_env
kobject: 'usb_device' (fffff8006ca17ba8): fill_kobj_path: path = '/class/usb_device'
kobject: 'hub' (fffff8006c87d488): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'hub' (fffff8006c87d488): kobject_uevent_env
kobject: 'hub' (fffff8006c87d488): fill_kobj_path: path = '/bus/usb/drivers/hub'
usbcore: registered new interface driver hub
kobject: 'target1:0:0' (fffff8006d5c0a68): kobject_uevent_env
kobject: 'target1:0:0' (fffff8006d5c0a68): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0'
ps used greatest stack depth: 0 bytes left
kobject: '1:0:0:0' (fffff8006e1495b0): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006e1495b0): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0'
kobject: 'sda' (fffff8006d5e65f8): kobject_uevent_env
kobject: 'sda' (fffff8006d5e65f8): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda'
kobject: 'sda1' (fffff8006d5c12e0): kobject_uevent_env
kobject: 'sda1' (fffff8006d5c12e0): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda/sda1'
kobject: 'sda2' (fffff8006d5c1728): kobject_uevent_env
kobject: 'sda2' (fffff8006d5c1728): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda/sda2'
kobject: 'sda3' (fffff8006d5c1b70): kobject_uevent_env
kobject: 'sda3' (fffff8006d5c1b70): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda/sda3'
kobject: 'sda4' (fffff8006d5c1fb8): kobject_uevent_env
kobject: 'sda4' (fffff8006d5c1fb8): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda/sda4'
kobject: 'sda5' (fffff8006d5c2400): kobject_uevent_env
kobject: 'sda5' (fffff8006d5c2400): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/block/sda/sda5'
kobject: 'i2c_ali1535' (0000000010049a90): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006c823210): kobject_add_internal: parent: 'i2c_ali1535', set: '<NULL>'
kobject: 'i2c_ali1535' (0000000010049a90): kobject_uevent_env
kobject: 'i2c_ali1535' (0000000010049a90): fill_kobj_path: path = '/module/i2c_ali1535'
kobject: 'notes' (fffff8006c823430): kobject_add_internal: parent: 'i2c_ali1535', set: '<NULL>'
kobject: 'ali1535_smbus' (fffff8006c87dda8): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'i2c-adapter' (fffff8006c823298): kobject_add_internal: parent: '0000:00:03.0', set: '<NULL>'
kobject: 'i2c-0' (0000000010049770): kobject_add_internal: parent: 'i2c-adapter', set: 'devices'
kobject: 'i2c-0' (0000000010049770): kobject_uevent_env
kobject: 'i2c-0' (0000000010049770): fill_kobj_path: path = '/devices/pci0000:00/0000:00:03.0/i2c-adapter/i2c-0'
kobject: 'drivers' (fffff8006c822440): kobject_add_internal: parent: 'i2c_ali1535', set: '<NULL>'
kobject: 'ali1535_smbus' (fffff8006c87dda8): kobject_uevent_env
kobject: 'ali1535_smbus' (fffff8006c87dda8): fill_kobj_path: path = '/bus/pci/drivers/ali1535_smbus'
kobject: 'usb' (fffff8006c87c920): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'usb' (fffff8006c87c920): kobject_uevent_env
kobject: 'usb' (fffff8006c87c920): fill_kobj_path: path = '/bus/usb/drivers/usb'
usbcore: registered new device driver usb
kobject: '1:0:0:0' (fffff8006d5c2c80): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006d5c2c80): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/bsg/1:0:0:0'
kobject: '1:0:0:0' (fffff8006e149920): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006e149920): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0'
kobject: 'ohci_hcd' (0000000010055c10): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006c823dc0): kobject_add_internal: parent: 'ohci_hcd', set: '<NULL>'
kobject: 'ohci_hcd' (0000000010055c10): kobject_uevent_env
kobject: 'ohci_hcd' (0000000010055c10): fill_kobj_path: path = '/module/ohci_hcd'
kobject: 'notes' (fffff8006c823ed0): kobject_add_internal: parent: 'ohci_hcd', set: '<NULL>'
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 80 td 96
kobject: 'ohci_hcd' (fffff8006ca17da8): kobject_add_internal: parent: 'drivers', set: 'drivers'
PCI: Enabling device: (0000:00:0a.0), cmd 2
ohci_hcd 0000:00:0a.0: OHCI Host Controller
kobject: 'usb_host' (fffff8006c8225d8): kobject_add_internal: parent: '0000:00:0a.0', set: '<NULL>'
kobject: 'usb_host1' (fffff8006d5c6cb8): kobject_add_internal: parent: 'usb_host', set: 'devices'
kobject: 'usb_host1' (fffff8006d5c6cb8): kobject_uevent_env
kobject: 'usb_host1' (fffff8006d5c6cb8): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0a.0/usb_host/usb_host1'
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0a.0: created debug files
ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
kobject: '1:0:0:0' (fffff8006d5c0e98): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006d5c0e98): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:0/scsi_disk/1:0:0:0'
kobject: 'target1:0:1' (fffff8006d5c30f0): kobject_uevent_env
kobject: 'target1:0:1' (fffff8006d5c30f0): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:1'
kobject: '1:0:1:0' (fffff8006e14a5f8): kobject_uevent_env
kobject: '1:0:1:0' (fffff8006e14a5f8): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:1/1:0:1:0'
kobject: '1:0:1:0' (fffff8006d5c3510): kobject_uevent_env
kobject: '1:0:1:0' (fffff8006d5c3510): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:1/1:0:1:0/bsg/1:0:1:0'
kobject: '1:0:1:0' (fffff8006e14a968): kobject_uevent_env
kobject: '1:0:1:0' (fffff8006e14a968): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:1/1:0:1:0/scsi_device/1:0:1:0'
kobject: '0000:00' (fffff8006e034d60): kobject_uevent_env
kobject: '0000:00' (fffff8006e034d60): fill_kobj_path: path = '/devices/pci0000:00/pci_bus/0000:00'
kobject: 'i2c_ali15x3' (0000000010059d10): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006cae26e8): kobject_add_internal: parent: 'i2c_ali15x3', set: '<NULL>'
kobject: 'i2c_ali15x3' (0000000010059d10): kobject_uevent_env
kobject: 'i2c_ali15x3' (0000000010059d10): fill_kobj_path: path = '/module/i2c_ali15x3'
kobject: 'notes' (fffff8006cae2770): kobject_add_internal: parent: 'i2c_ali15x3', set: '<NULL>'
kobject: 'ali15x3_smbus' (fffff8006ca17488): kobject_add_internal: parent: 'drivers', set: 'drivers'
ohci_hcd 0000:00:0a.0: enabling initreset quirk
usb_hcd_poll_rh_status start
ohci_hcd 0000:00:0a.0: OHCI controller state
ohci_hcd 0000:00:0a.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:0a.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:0a.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0a.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:0a.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:0a.0: hcca frame #01a0
ohci_hcd 0000:00:0a.0: roothub.a 02000202 POTPGT=2 NPS NDP=2(2)
ohci_hcd 0000:00:0a.0: roothub.b 00000000 PPCM 00 DR 00
ohci_hcd 0000:00:0a.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:0a.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0a.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
kobject: 'usb1' (fffff8006cabc478): kobject_add_internal: parent: '0000:00:0a.0', set: 'devices'
kobject: 'usb1' (fffff8006cabc478): kobject_uevent_env
kobject: 'usb1' (fffff8006cabc478): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0a.0/usb1'
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
kobject: '1-0:1.0' (fffff8006d5c7130): kobject_add_internal: parent: 'usb1', set: 'devices'
kobject: '1-0:1.0' (fffff8006d5c7130): kobject_uevent_env
kobject: '1-0:1.0' (fffff8006d5c7130): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0a.0/usb1/1-0:1.0'
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: trying to enable port power on non-switchable hub
kobject: 'root' (fffff8006e091200): kobject_uevent_env
kobject: 'root' (fffff8006e091200): fill_kobj_path: path = '/devices/root'
kobject: 'f002d908' (fffff8006e092248): kobject_uevent_env
kobject: 'f002d908' (fffff8006e092248): fill_kobj_path: path = '/devices/root/f002d908'
kobject: 'cdrom' (0000000010069450): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006cae2990): kobject_add_internal: parent: 'cdrom', set: '<NULL>'
kobject: 'cdrom' (0000000010069450): kobject_uevent_env
kobject: 'cdrom' (0000000010069450): fill_kobj_path: path = '/module/cdrom'
kobject: 'notes' (fffff8006cae24c8): kobject_add_internal: parent: 'cdrom', set: '<NULL>'
kobject: 'f0035e4c' (fffff8006e093290): kobject_uevent_env
kobject: 'f0035e4c' (fffff8006e093290): fill_kobj_path: path = '/devices/root/f002d908/f0035e4c'
kobject: 'f0038e7c' (fffff8006e0942d8): kobject_uevent_env
kobject: 'f0038e7c' (fffff8006e0942d8): fill_kobj_path: path = '/devices/root/f002d908/f0038e7c'
kobject: 'f00395c4' (fffff8006e095320): kobject_uevent_env
kobject: 'f00395c4' (fffff8006e095320): fill_kobj_path: path = '/devices/root/f002d908/f00395c4'
kobject: 'sr_mod' (00000000100703d0): kobject_add_internal: parent: 'module', set: 'module'
kobject: 'holders' (fffff8006cae2ff0): kobject_add_internal: parent: 'sr_mod', set: '<NULL>'
kobject: 'sr_mod' (00000000100703d0): kobject_uevent_env
kobject: 'sr_mod' (00000000100703d0): fill_kobj_path: path = '/module/sr_mod'
kobject: 'notes' (fffff8006cae2e58): kobject_add_internal: parent: 'sr_mod', set: '<NULL>'
Driver 'sr' needs updating - please use bus_type methods
kobject: 'sr' (fffff8006ca166d8): kobject_add_internal: parent: 'drivers', set: 'drivers'


-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
