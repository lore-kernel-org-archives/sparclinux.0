From: kbuild test robot <lkp@intel.com>
Date: Thu, 30 Mar 2017 12:18:00 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <201703302036.mn7yu2Zn%fengguang.wu@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl>
In-Reply-To: <20170329184431.6226-1-oliver@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Olliver,

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.11-rc4 next-20170330]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/serial-Do-not-treat-the-IIR-register-as-a-bitfield/20170330-165826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/staging/media/lirc/lirc_sir.c:285:44: sparse: undefined identifier 'UART_IIR_ID'
   drivers/staging/media/lirc/lirc_sir.c:286:29: sparse: undefined identifier 'UART_IIR_ID'
>> drivers/staging/media/lirc/lirc_sir.c:287:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:290:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:293:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:299:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c: In function 'sir_interrupt':
   drivers/staging/media/lirc/lirc_sir.c:285:37: error: 'UART_IIR_ID' undeclared (first use in this function)
     while ((iir = inb(io + UART_IIR) & UART_IIR_ID)) {
                                        ^~~~~~~~~~~
   drivers/staging/media/lirc/lirc_sir.c:285:37: note: each undeclared identifier is reported only once for each function it appears in

vim +/case +287 drivers/staging/media/lirc/lirc_sir.c

34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  279  	ktime_t curr_time;
34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  280  	static unsigned long delt;
34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  281  	unsigned long deltintr;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  282  	unsigned long flags;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  283  	int iir, lsr;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  284  
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26 @285  	while ((iir = inb(io + UART_IIR) & UART_IIR_ID)) {
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  286  		switch (iir&UART_IIR_ID) { /* FIXME toto treba preriedit */
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26 @287  		case UART_IIR_MSI:
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  288  			(void) inb(io + UART_MSR);
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  289  			break;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  290  		case UART_IIR_RLSI:

:::::: The code at line 287 was first introduced by commit
:::::: 404f3e956bc7ab03ac604fabf136e69607315f60 V4L/DVB: staging/lirc: add lirc_sir driver

:::::: TO: Jarod Wilson <jarod@redhat.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
