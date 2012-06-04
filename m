From: Marcel van Nies <morcles@gmail.com>
Date: Mon, 04 Jun 2012 20:04:55 +0000
Subject: Re: sparc32: some more testing
Message-Id: <CACEWtaAokQ30d1gJbS-U501HW9c56Lc1CR6cr_uWOfb=iEhN7g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

> I started playing around with this again.
> I did a lot of things related to flush handling with no success.
> In the end I decided to shrink my kernel-image (I use tftpboot.img).
>
> When I finally squezed the kernel (including rootfs) to allow
> me to do the initial memory allocations in the memory area
> below 0xa00000 then I could boot.
>
> So the inital mapping is limited to 10MB...
> I need to find a way to extend the initial mapping without the need
> to access allocated memory.
> I have not looked at it yet - this is just a heads-up.

I have an old working Gentoo userland on disk, so no need for a rootfs.
My kernel-images are around 3.0-3.2MB, well within the 10MB limit.
That's why my kernels boot and yours didn't.

Since booting a kernel with SILO is limited to only 2605056 bytes I
have to use tftboot too.
Solving that problem would require to make a sparc32 kernel relocatable.

M
