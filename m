From: Stan Benoit <sbenoit@verizon.net>
Date: Thu, 13 May 2004 21:10:06 +0000
Subject: 2.2.6smp build problem
Message-Id: <1084482606.5080.25.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All,

System: 	SPARCStation 20sx, Dual Ross HyperSPARC 150 processors
Base OS: 	RedHat 6.2 Zoot
GCC 		2.95.3
Binutils 	2.14
make		3.78.1
glibc		2.1.3-15

#make mrproper    	OK
#make menuconfig  	Ok
#make vmlinux		Fault


<snip>
gcc -D__KERNEL__ -I/usr/src/linux/include -D__ASSEMBLY__ -D__SMP__ -pipe
-mno-fpu -fcall-used-g5 -fcall-used-g7 -DEXPORT_SYMTAB -c sprac_ksyms.c
gcc -D_KERNEL-- -I/usr/src/linux/include -D__ASSEMBLY__ -D__SMP__ -ansi
-c entry.S -o entry.o
entry.S: Assembler messages:
entry.S:959: Error: relocation overflow
entry.S:1120: Error: relocation overflow
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory '/usr/src/linux/arch/sparc/kernel'
make: *** [_dir_arch/sparc/kernel] Error 2
[root@localhost linux]#


Do I need to update any of my base packages? 
Is 2.2.26 broke? 

 

-- 
Stan Benoit <sbenoit@verizon.net>

