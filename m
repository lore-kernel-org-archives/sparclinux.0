From: Ben Collins <bcollins@debian.org>
Date: Tue, 22 Feb 2005 16:29:33 +0000
Subject: Re: Patch: SILO/first-isofs/isofs.c (Fix Sun4c)
Message-Id: <20050222162933.GA25092@internal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks. Committed to the repo. I'll try to get a new version out soon.

As for the next error, it looks like it is trying to load it to the
physical address of 0x0, which is a bad thing. That overwrites silo
itself.

So I guess there is an error in silo (not first-isofs). Check the
memory_find() function in second/memory.c and see why it is using a
physical address of 0x0.

On Tue, Feb 22, 2005 at 04:55:10PM +0000, Chris Newport wrote:
> 
> This small patch fixes silo-1.4.8/first-isofs/isofs.c
> Copying an int into a string is not a good idea.
> 
> Sun4c now loads second.b and the kernel, but still
> barfs loading the initrd.
> 
> boot:
> Loaded kernel version 2.4.27
> Loading initial ramdisk (905216 bytes at 0x0 phys, 0x300000 virt)...
> Data Access ExceptionType b (boot), c(continue), or n (new command mode)
> >
> 
> Does anyone know what is wrong here ?
> 

> --- silo-1.4.8/first-isofs/isofs.c.orig	2005-02-22 13:26:47.000000000 +0000
> +++ silo-1.4.8/first-isofs/isofs.c	2005-02-22 16:31:01.000000000 +0000
> @@ -68,7 +68,7 @@
>  		*s++ = (ap->boot_dev_ctrl & 07) + '0';
>  		*s++ = ',';
>  		// Hopefully it's never > 10
> -		*s++ = ap->boot_dev_unit;
> +		*s++ = (ap->boot_dev_unit & 07) + '0';
>  		*s++ = ','; 
>  		*s++ = '0';
>  		*s++ = ')';


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
