From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 09 Sep 2008 14:39:32 +0000
Subject: Re: kernel 2.6.26.3 qla2xxx oopsing on Fire 280R
Message-Id: <20080909143932.GA27117@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904093929.GA29006@orion.carnet.hr> <20080908211331.GC22598@plap4-2.qlogic.org> <20080909015321.GA14147@orion.carnet.hr> <20080909020102.GE25591@plap4-2.qlogic.org>
In-Reply-To: <20080909020102.GE25591@plap4-2.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

On Mon, Sep 08, 2008 at 07:01:02PM -0700, Andrew Vasquez wrote:
> Yes, please do try the patch.  Could you also enable error-logging via
> the ql2xextended_error_logging module parameter:
> 
> 	# insmod qla2xxx.ko ql2xextended_error_logging=1
> 
> And send the kernel messages...  Thanks, AV

OK, I reset the bisection, pulled the latest updates, applied your patch
and added the parameter to the initrd module setup, rebuilt after an
all-enter make oldconfig. After rebooting, it failed to load the firmware:

scsi(0): **** Load RISC code **** 
firmware: requesting ql2200_fw.bin 
scsi(0): Failed to load firmware image (ql2200_fw.bin). 
qla2xxx 0001:00:04.0: Firmware image unavailable. 

After the reboot, I noticed that I managed to screw up my silo setup,
so it's going to take me a wee bit more to recover. :<

-- 
     2. That which causes joy or happiness.
