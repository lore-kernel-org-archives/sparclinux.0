From: cookie <cookie@iacookie.net>
Date: Sun, 23 Jul 2006 08:02:10 +0000
Subject: Compile ESP
Message-Id: <EC625B79-6F87-41C4-835E-5EF2E80B7684@iacookie.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello-
   I have noticed that since late 2.6.17 that I was unable to
compile ESP on my U2.  Its running Aurora Linux 2.0.  I have
not seen anyone else mention this, can someone give me a suggestion
on what I may have done wrong?  This is the verbose output from
2.6.18-rc2-git1
   Thanks
Brian


make -f scripts/Makefile.build obj=drivers/scsi
   gcc -Wp,-MD,drivers/scsi/.esp.o.d  -nostdinc -isystem /usr/lib/gcc/ 
sparc64-redhat-linux/3.4.2/include -D__KERNEL__ -Iinclude  -include  
include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno- 
trigraphs -fno-strict-aliasing -fno-common  -O2 -fomit-frame-pointer - 
m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 - 
ffixed-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs - 
Wdeclaration-after-statement     -D"KBUILD_STR(s)=#s" - 
D"KBUILD_BASENAME=KBUILD_STR(esp)"  -D"KBUILD_MODNAME=KBUILD_STR 
(esp)" -c -o drivers/scsi/esp.o drivers/scsi/esp.c
drivers/scsi/esp.c: In function `esp_should_clear_sync':
drivers/scsi/esp.c:2758: error: structure has no member named  
`data_cmnd'
make[2]: *** [drivers/scsi/esp.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2



