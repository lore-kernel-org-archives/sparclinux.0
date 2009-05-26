From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 26 May 2009 18:36:37 +0000
Subject: [2.6.29.4] Blade 2000
Message-Id: <4A1C36B5.6040707@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have made some minor modifications in bbc_i2c driver to add en entry 
in /proc directory. ALl mofications have been made against 2.6.29.4 but 
I haven't verified that this kernel was bootable.

	I have built my own bbc_i2c driver as a module. 2.6.29.4 kernel hangs 
just after qla2xxx initialization. I don't think that this driver try to 
upload firmware. This firmware is built into the kernel.

CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE="ql2200_fw.bin"
CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"

Root rayleigh:[/lib/firmware] > ls
edgeport  emi62  keyspan_pda  ql2100_fw.bin  ql2300_fw.bin  ql2400_fw.bin
emi26     ess    korg         ql2200_fw.bin  ql2322_fw.bin  yamaha
Root rayleigh:[/lib/firmware] >

Configuration:

Blade 2000, 2 GB, 2*UIII+/900, Creator3D, internal NIC + 2*3Com NIC.

	Is it a known trouble ?

	Regards,

	JKB
