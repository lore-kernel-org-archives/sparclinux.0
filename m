From: bLueX <bluex00@gmail.com>
Date: Thu, 02 Sep 2004 15:01:08 +0000
Subject: rarpd compilation problems!
Message-Id: <1b2af24f0409020801add230b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hi! 
I 've a slack 9.0 with 2.4.27 kernel
i need to netboot a sparc station so I  downloaded rarpd since 2.4.27
does not support it..
i compiled libnet 1.1.2.1 and lipcap as rarpd ask you to do ..
the rarpd version i have is 1.1..
the problem appears when i run ./configure

root@dodo:/usr/local/src/rarpd-1.1# ./configure
...
...
checking for libnet library in /usr/ng/lib... not found
checking for libnet library in /usr/lib... not found
checking for libnet library in /usr/local/lib... not found
checking whether to include libnet... no
creating ./config.status
creating Makefile
 
as you can see.. libnet is not being include; so as a result when i tun make:

root@dodo:/usr/local/src/rarpd-1.1# make
gcc -g -O2   -I/usr/include   -DPACKAGE=\"\" -DVERSION=\"\"
-DSTDC_HEADERS=1 -DHAVE_NET_IF_ARP_H=1 -DHAVE_PCAP_NAMEDB_H=1
-DHAVE_STRING_H=1 -DHAVE_STRINGS_H=1 -DHAVE_CTYPE_H=1
-DHAVE_SYS_SOCKET_H=1 -DHAVE_PATHS_H=1  -c rarpd.c -o rarpd.o
rarpd.c: In function `process_arp':
rarpd.c:341: structure has no member named `ar_sha'
rarpd.c:342: structure has no member named `ar_spa'
rarpd.c:343: structure has no member named `ar_tha'
rarpd.c:344: structure has no member named `ar_tpa'
rarpd.c: In function `main':
rarpd.c:456: warning: assignment makes pointer from integer without a cast
make: *** [rarpd.o] Error 1


I am running everythinf from /usr/local/src/ 
I tried several times with different options for libnet configure
(such as ./configure --prefix=/usr) .. nothing seems to work..
the library that rarp is looking for is there (at least I see it
there! is libnet.a) it is @ /usr/lib/libnet.a  , that's why I dont
understand where the problem is...


This error is getting me crazy..
Does anyone know what can be happening?

-- 
bLueX @Neverland
:P
