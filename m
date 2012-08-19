From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:16 +0000
Subject: [PATCH 0/17] First wave of Sparc-T4 patches.
Message-Id: <20120818.232716.1292334913086207826.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch set adds support for two aspects of SPARC-T4.

First, the ability to detect the newer chip features and export them
as hwcap bits to userland as needed.  The CPU CAPS output in the boot
log on a SPARC-T4 looks like:

[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.000000] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[    0.000000] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[    0.000000] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]

Second, support for the NMI watchdog and perf events.

After giving a day or two for feedback I'll commit this work to
sparc-next.

Signed-off-by: David S. Miller <davem@davemloft.net>
