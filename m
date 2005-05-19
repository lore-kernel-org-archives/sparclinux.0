From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 19 May 2005 16:41:54 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <Pine.LNX.4.61.0505191225090.1641@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 19 May 2005, Bob Breuer wrote:

> With that config, I can't boot the resulting image because it's too large for 
> the silo that I'm using.

Right, sorry about that. Debian's sparc kernels are stripped using the 
command

strip -R .comment -R .note -K sun4u_init -K _end -K _start image

after building, that reduces their size to acceptable by SILO.

> Some more details about that kernel and it's initrd:
>
> [root@sparky boot]# ls -l *1166*
> -rw-r--r--  1 root root   25816 Mar  4 21:07 config-2.6.11-1.1166sp1
> -rw-r--r--  1 root root  753917 Mar  7 10:09 initrd-2.6.11-1.1166sp1.img
> -rw-r--r--  1 root root  453452 Mar  4 21:07 System.map-2.6.11-1.1166sp1
> -rwxr-xr-x  1 root root 2471360 Mar  4 21:31 vmlinuz-2.6.11-1.1166sp1
> [root@sparky boot]# file vmlinuz-2.6.11-1.1166sp1 
> vmlinuz-2.6.11-1.1166sp1: ELF 32-bit MSB executable, SPARC, version 1
> (SYSV), statically linked, stripped
> [root@sparky boot]# file initrd-2.6.11-1.1166sp1.img
> initrd-2.6.11-1.1166sp1.img: gzip compressed data, from Unix, max compression
> [root@sparky boot]# zcat initrd-2.6.11-1.1166sp1.img >/tmp/initrd
> [root@sparky boot]# file /tmp/initrd
> /tmp/initrd: ASCII cpio archive (SVR4 with no CRC)
>
> Looks like my initrd is a cpio archive instead of cramfs.

Interesting. I guess that it actually uses initramfs capability to load 
cpio archives into ramdisk. We are planning this transition at some point, 
but at the moment cramfs/ext2 initrds is what is used.

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
