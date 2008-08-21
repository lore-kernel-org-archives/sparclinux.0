From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 09:13:21 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0808211145030.17855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Hah, remebered - I now used the debug option on kernel command line ang 
> a huge trace (probably shouldn't have turned on kobject debugging). 

Maybe unimportant, but the other typical place the kernel 
hangs during some boots is after libata disk detection:

sd 1:0:0:0: [sda] Attached SCSI diskkobject: 'scsi_device' (fffff8006c81fcb0): kobject_add_internal: parent: '1:0:0:0', set: '<NULL>'
kobject: '1:0:0:0' (fffff8006e149920): kobject_add_internal: parent: 'scsi_device', set: 'devices'
kobject: '1:0:0:0' (fffff8006e149920): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006e149920): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:'
kobject: 'bsg' (fffff8006c81fd38): kobject_add_internal: parent: '1:0:0:0', set: '<NULL>'
kobject: '1:0:0:0' (fffff8006d5c2c80): kobject_add_internal: parent: 'bsg', set: 'devices'
kobject: '1:0:0:0' (fffff8006d5c2c80): kobject_uevent_env
kobject: '1:0:0:0' (fffff8006d5c2c80): fill_kobj_path: path = '/devices/pci0000:00/0000:00:0d.0/host1/target1:0:0/1:0:0:'

The same kernel image sometimes hangs in this place and sometimes gets 
to ohci and hangs there. Earlier I thought it was a different hang 
condition that some kernel revisions had but now that I did multiple 
boots with the same image, it somethimes hangs here and sometimes there. 
It may depend on kernel boot parameters but then it's the whitespace in 
them becaus semantically same boot command line (test -p debug) has 
caused both hangs.

Some it seems something is causing the CPU to get stuck in either after 
libata detection or during ohci detection and then even sysrq does not 
work.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
