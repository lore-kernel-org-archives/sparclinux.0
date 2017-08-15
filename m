From: Meelis Roos <mroos@linux.ee>
Date: Tue, 15 Aug 2017 14:37:13 +0000
Subject: Niagara2 crypto engine questions
Message-Id: <alpine.LRH.2.20.1708151728010.29628@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I enabled the n2_crypto driver in my t5140 kernel since the device seems 
to be there. The driver loads and finds something:

[   41.432364] n2_crypto: n2_crypto.c:v0.2 (July 28, 2011)
[   41.503135] n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7
[   41.593090] n2_crypto: Registered NCS HVAPI version 2.0
[   41.942614] n2_crypto: md5 alg registration failed
[   42.594045] n2cp f027ba24: /virtual-devices@100/n2cp@7: Unable to register algorithms.
[   42.975493] n2cp: probe of f027ba24 failed with error -22
[   44.305316] n2_crypto: Found NCP at /virtual-devices@100/ncp@6
[   44.392193] n2_crypto: Registered NCS HVAPI version 2.0

However, why is there an error about algorithms registration?

Why are there 2 different devices in OF? /virtual-devices@100/n2cp@7 and 
/virtual-devices@100/ncp@6 (the latter does not give any errors in 
dmesg)?

/proc/crypto shows only generic drivers for the primitives.

What applications can make use of the n2 crypto engine - only the kernel 
itself?

I have not enabled the SPARC64 versions of crypto primitives since my 
CPU CAPS does not show them and they do not load.

[    3.010249] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    3.010747] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit]

CONFIG_CRYPTO_MD5=y so MD5 si not missing from the kernel altogether.

-- 
Meelis Roos (mroos@linux.ee)
